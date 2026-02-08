package com.fooddelivery.controller;

import java.io.IOException;
import java.sql.Timestamp;
import java.time.Instant;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;

import com.razorpay.RazorpayException;
import com.razorpay.Utils;
import com.fooddelivery.dao.OrderDao;
import com.fooddelivery.dao.OrderItemDao;
import com.fooddelivery.dao.impl.OrderDaoImpl;
import com.fooddelivery.dao.impl.OrderItemDaoImpl;
import com.fooddelivery.model.Cart;
import com.fooddelivery.model.CartItem;
import com.fooddelivery.model.Order;
import com.fooddelivery.model.User;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {

    private OrderDao orderDao;
    private OrderItemDao orderItemDao;
    private static final Logger LOGGER = Logger.getLogger(CheckoutServlet.class.getName());
    
    // Must match PaymentPageServlet's secret
    private static final String KEY_SECRET = "7xX9y5Y5Z5z5W5w5v5u5t5s5"; 

    @Override
    public void init() throws ServletException {
        orderDao = new OrderDaoImpl();
        orderItemDao = new OrderItemDaoImpl();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        Cart cart = (Cart) session.getAttribute("cart");

        if (user == null) {
            response.sendRedirect("login");
            return;
        }

        if (cart == null || cart.getItems().isEmpty()) {
            response.sendRedirect("cart");
            return;
        }

        // --- PAYMENT VALIDATION & VERIFICATION ---
        String paymentMode = request.getParameter("paymentMode");
        String transactionId = null;
        
        // Strict Razorpay Flow
        if ("Razorpay".equals(paymentMode)) {
            String razorpayPaymentId = request.getParameter("razorpay_payment_id");
            String razorpayOrderId = request.getParameter("razorpay_order_id");
            String razorpaySignature = request.getParameter("razorpay_signature");
            
            if (razorpayPaymentId == null || razorpayOrderId == null || razorpaySignature == null) {
                 LOGGER.warning("Missing Razorpay params");
                 response.sendRedirect("payment?error=PaymentFailed");
                 return;
            }

            // Verify Signature using Razorpay SDK
            try {
                // BYPASS FOR MOCK MODE
                if (razorpayOrderId != null && razorpayOrderId.startsWith("order_mock_")) {
                    LOGGER.info("Mock Payment Detected. Bypassing Signature Verification.");
                    transactionId = razorpayPaymentId; // Use the mock ID
                    // Proceed as valid
                } else {
                    JSONObject options = new JSONObject();
                    options.put("razorpay_order_id", razorpayOrderId);
                    options.put("razorpay_payment_id", razorpayPaymentId);
                    options.put("razorpay_signature", razorpaySignature);
    
                    // This throws RazorpayException if verification fails
                    boolean isValid = Utils.verifyPaymentSignature(options, KEY_SECRET);
                    
                    if (isValid) {
                       transactionId = razorpayPaymentId;
                       // Audit Log: Success
                       LOGGER.info("Payment Verification Success. Transaction ID: " + transactionId + " for User: " + user.getUserId());
                       
                       // ACID Transaction Order Placement
                       Order order = new Order();
                       order.setUserId(user.getUserId());
                       // Get Restaurant ID from first item (assuming single restaurant order)
                       if (!cart.getItems().isEmpty()) {
                           order.setRestaurantId(cart.getItems().values().iterator().next().getRestaurantId());
                       }
                       order.setTotalAmount(cart.getTotalPrice());
                       order.setStatus("Confirmed");
                       order.setPaymentMode("Razorpay");
                       order.setTransactionId(transactionId);
                       
                       // Legacy fields defaults
                       order.setMenuId(0); 
                       order.setQuantity(cart.getItems().size()); 

                       boolean success = orderDao.placeOrder(order, cart, transactionId, "Success");
                       
                       if (success) {
                           session.removeAttribute("cart");
                           LOGGER.info("Order Placed Successfully. Order ID: " + order.getOrderId());
                           response.sendRedirect("order_success.jsp");
                       } else {
                           LOGGER.severe("Order Placement Failed in DAO for Transaction: " + transactionId);
                           response.sendRedirect("payment?error=OrderCreationFailed");
                       }
                    } else {
                        // Audit Log: Failure (Signature Mismatch)
                        LOGGER.severe("Razorpay signature verification returned false. Potential tampering. Payment ID: " + razorpayPaymentId);
                        response.sendRedirect("payment?error=VerificationFailed");
                        return;
                    }
                }
            } catch (RazorpayException e) {
                 // Audit Log: Exception
                 LOGGER.severe("Razorpay signature verification failed: " + e.getMessage() + ". Payment ID: " + razorpayPaymentId);
                 response.sendRedirect("payment?error=SecurityViolation");
                 return;
            }
        } else {
             // Invalid mode or direct access attempt without proper gateway info
             response.sendRedirect("payment?error=InvalidMode");
             return;
        }

        // Create Order
        // Assuming all items from same restaurant? Or mixed?
        // Standard food delivery usually restricts cart to one restaurant.
        // For simplicity, we'll take the restaurant ID from the first item.
        CartItem firstItem = cart.getItems().values().iterator().next();
        int restaurantId = firstItem.getRestaurantId();
        
        Order order = new Order();
        order.setUserId(user.getUserId());
        order.setRestaurantId(restaurantId);
        order.setMenuId(firstItem.getItemId()); // Representative item for legacy schema
        order.setQuantity(cart.getItems().size()); // Representative quantity (count of distinct items)
        order.setTotalAmount(cart.getTotalPrice());
        order.setStatus("Confirmed"); // Payment Successful
        order.setPaymentMode(paymentMode); 
        order.setTransactionId(transactionId);
        order.setOrderDate(Timestamp.from(Instant.now()));

        // --- ATOMIC TRANSACTION ---
        // Replacing separate calls with single transactional method
        // int orderId = orderDao.addOrder(order);
        boolean success = orderDao.placeOrder(order, cart, transactionId, "Success");

        if (success) {
            int orderId = order.getOrderId(); // Retrieved from DAO population
            
            // Clear Cart
            cart.clear();
            
            session.setAttribute("lastOrderId", orderId);
            response.sendRedirect("orderSuccess");
        } else {
            response.sendRedirect("failure");
        }
    }
    
    // Legacy method removed
}

