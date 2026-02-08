package com.fooddelivery.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;

import com.razorpay.Order;
import com.razorpay.RazorpayClient;
import com.razorpay.RazorpayException;
import com.fooddelivery.model.Cart;

@WebServlet({"/payment", "/paymentPage"})
public class PaymentPageServlet extends HttpServlet {
    
    // Replace with your actual Test Key ID and Secret
    // NOTE: In production, store these securely (env vars), not in source code!
    private static final String KEY_ID = "rzp_test_1DP5mmOlF5G5ag"; 
    private static final String KEY_SECRET = "7xX9y5Y5Z5z5W5w5v5u5t5s5"; // Placeholder

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // For GET requests, check if we have pending order in session
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login");
            return;
        }
        
        // Check if we have pending payment info in session
        if (session.getAttribute("pendingOrderId") != null || session.getAttribute("cart") != null) {
            // Process the payment page
            processPaymentPage(request, response, session);
        } else {
            response.sendRedirect("home");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login");
            return;
        }
        
        // Get order info from POST parameters or session
        String orderId = request.getParameter("orderId");
        String amountParam = request.getParameter("amount");
        
        if (orderId != null && amountParam != null) {
            try {
                double amount = Double.parseDouble(amountParam);
                // Store in session for security
                session.setAttribute("pendingOrderId", Integer.parseInt(orderId));
                session.setAttribute("pendingOrderAmount", amount);
            } catch (NumberFormatException e) {
                response.sendRedirect("home?error=invalid_amount");
                return;
            }
        }
        
        processPaymentPage(request, response, session);
    }
    
    private void processPaymentPage(HttpServletRequest request, HttpServletResponse response, HttpSession session) 
            throws ServletException, IOException {
        
        double amountDouble = 0;
        Integer orderId = (Integer) session.getAttribute("pendingOrderId");
        Double pendingAmount = (Double) session.getAttribute("pendingOrderAmount");
        
        // Check if this is a quick order (from ADD/BUY buttons)
        if (orderId != null && pendingAmount != null) {
            // Quick Order Payment
            amountDouble = pendingAmount;
            request.setAttribute("quickOrderId", orderId);
            request.setAttribute("itemName", session.getAttribute("pendingItemName"));
            request.setAttribute("quantity", session.getAttribute("pendingQuantity"));
        } else if (session.getAttribute("cart") != null) {
            // Cart Payment
            Cart cart = (Cart) session.getAttribute("cart");
            amountDouble = cart.getTotalPrice();
        } else {
            response.sendRedirect("home");
            return;
        }
        
        // Razorpay checks amount in paise (multiply by 100)
        int amountInPaise = (int) Math.round(amountDouble * 100);

        try {
            // Initialize Razorpay Client
            RazorpayClient client = new RazorpayClient(KEY_ID, KEY_SECRET);

            // Create Order Request
            JSONObject orderRequest = new JSONObject();
            orderRequest.put("amount", amountInPaise);
            orderRequest.put("currency", "INR");
            orderRequest.put("receipt", "txn_" + System.currentTimeMillis());
            orderRequest.put("payment_capture", 1); // Auto-capture enabled for instant settlement

            // Create Order
            Order order = client.orders.create(orderRequest);
            String razorpayOrderId = order.get("id");

            // Pass details to JSP
            request.setAttribute("razorpayOrderId", razorpayOrderId);
            request.setAttribute("razorpayKeyId", KEY_ID);
            request.setAttribute("currency", "INR");
            request.setAttribute("amount", amountInPaise);
            request.setAttribute("amountDisplay", amountDouble);
            
            request.getRequestDispatcher("/WEB-INF/views/payment.jsp").forward(request, response);

        } catch (RazorpayException e) {
            // FALLBACK FOR DEVELOPMENT / INVALID KEYS
            // Since valid keys are not available, we switch to Mock Mode for testing
            System.err.println("Razorpay Init Failed: " + e.getMessage() + ". Switching to MOCK MODE.");
            
            request.setAttribute("isMockMode", true);
            request.setAttribute("razorpayOrderId", "order_mock_" + System.currentTimeMillis());
            request.setAttribute("razorpayKeyId", "test_mock_key");
            request.setAttribute("currency", "INR");
            request.setAttribute("amount", amountInPaise);
            request.setAttribute("amountDisplay", amountDouble);
            
            request.getRequestDispatcher("/WEB-INF/views/payment.jsp").forward(request, response);
        }
    }
}


