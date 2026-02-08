package com.fooddelivery.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.fooddelivery.model.Cart;

@WebServlet("/scan_pay")
public class ScanPaymentServlet extends HttpServlet {
    
    // Reuse keys/constants from PaymentPageServlet
    private static final String KEY_ID = "rzp_test_1DP5mmOlF5G5ag"; 
    private static final String KEY_SECRET = "7xX9y5Y5Z5z5W5w5v5u5t5s5"; 

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null && session.getAttribute("cart") != null) {
            
            Cart cart = (Cart) session.getAttribute("cart");
            double amountDouble = cart.getTotalPrice();
            int amountInPaise = (int) Math.round(amountDouble * 100);

            // Generate Order ID for the session (mock or real)
            String orderId = "order_mock_scan_" + System.currentTimeMillis();
            
            try {
                 // Try real if possible, fallback to mock
                 // RazorpayClient client = new RazorpayClient(KEY_ID, KEY_SECRET);
                 // ... create order ...
            } catch (Exception e) {}

            request.setAttribute("razorpayOrderId", orderId);
            request.setAttribute("razorpayKeyId", KEY_ID);
            request.setAttribute("currency", "INR");
            request.setAttribute("amount", amountInPaise); 
            
            request.getRequestDispatcher("/WEB-INF/views/scan_payment.jsp").forward(request, response);
            
        } else {
            response.sendRedirect("login");
        }
    }
}

