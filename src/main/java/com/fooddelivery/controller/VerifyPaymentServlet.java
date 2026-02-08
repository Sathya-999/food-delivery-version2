package com.fooddelivery.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;

import com.fooddelivery.config.DBConnection;
import com.fooddelivery.dao.OrderDao;
import com.fooddelivery.dao.impl.OrderDaoImpl;
import com.fooddelivery.model.Order;
import com.fooddelivery.model.User;

/**
 * Servlet to verify UPI payment completion
 * Checks if payment is genuinely recorded in database before confirming order
 */
@WebServlet("/verifyPayment")
public class VerifyPaymentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private OrderDao orderDao;

    @Override
    public void init() throws ServletException {
        orderDao = new OrderDaoImpl();
    }

    /**
     * Check if a payment record exists in the payments table for the given user and amount
     * Returns the payment ID if found, null otherwise
     */
    private String checkPaymentInDatabase(int userId, double expectedAmount) {
        String sql = "SELECT paymentId, amount FROM payments WHERE userId = ? AND status = 'Success' ORDER BY timestamp DESC LIMIT 1";
        
        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql)) {
            
            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                String paymentId = rs.getString("paymentId");
                double paidAmount = rs.getDouble("amount");
                
                // Verify the amount matches (with small tolerance for floating point)
                if (Math.abs(paidAmount - expectedAmount) < 0.01) {
                    System.out.println("[PaymentVerify] Found valid payment: " + paymentId + " for amount: " + paidAmount);
                    return paymentId;
                } else {
                    System.out.println("[PaymentVerify] Amount mismatch. Expected: " + expectedAmount + ", Found: " + paidAmount);
                }
            }
        } catch (SQLException e) {
            System.err.println("[PaymentVerify] Database error checking payment: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        JSONObject result = new JSONObject();
        
        try {
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("user") == null) {
                result.put("success", false);
                result.put("message", "Session expired. Please login again.");
                out.print(result.toString());
                return;
            }
            
            User user = (User) session.getAttribute("user");
            Integer orderId = (Integer) session.getAttribute("pendingOrderId");
            Double amount = (Double) session.getAttribute("pendingOrderAmount");
            
            if (orderId == null) {
                result.put("success", false);
                result.put("message", "No pending order found.");
                out.print(result.toString());
                return;
            }
            
            // Get the order from database
            Order order = orderDao.getOrder(orderId);
            
            if (order == null) {
                result.put("success", false);
                result.put("message", "Order not found in database.");
                out.print(result.toString());
                return;
            }
            
            // Verify the order belongs to this user
            if (order.getUserId() != user.getUserId()) {
                result.put("success", false);
                result.put("message", "Order does not belong to this user.");
                out.print(result.toString());
                return;
            }
            
            double orderAmount = order.getTotalAmount();
            
            // CRITICAL: Check if payment actually exists in the payments table
            String verifiedPaymentId = checkPaymentInDatabase(user.getUserId(), orderAmount);
            
            if (verifiedPaymentId == null) {
                // NO GENUINE PAYMENT FOUND - Reject the verification
                result.put("success", false);
                result.put("message", "Payment not received yet. Please complete the payment via UPI and try again.");
                System.out.println("[PaymentVerify] REJECTED - No payment found in database for user: " + user.getUserId() + " amount: " + orderAmount);
                out.print(result.toString());
                return;
            }
            
            // PAYMENT VERIFIED - Update order status to Confirmed
            orderDao.updateOrderStatus(orderId, "Confirmed");
            
            // Clear pending order from session
            session.removeAttribute("pendingOrderId");
            session.removeAttribute("pendingOrderAmount");
            session.removeAttribute("pendingItemName");
            session.removeAttribute("pendingQuantity");
            
            // Store confirmed order ID for success page
            session.setAttribute("confirmedOrderId", orderId);
            
            // Return success response with verified payment ID
            result.put("success", true);
            result.put("message", "Payment verified successfully!");
            result.put("orderId", orderId);
            result.put("amount", orderAmount);
            result.put("transactionId", verifiedPaymentId);
            
            System.out.println("[PaymentVerify] SUCCESS - Order #" + orderId + " confirmed for user: " + user.getUsername() + " Amount: Rs." + orderAmount + " PaymentId: " + verifiedPaymentId);
            
        } catch (Exception e) {
            e.printStackTrace();
            result.put("success", false);
            result.put("message", "Error: " + e.getMessage());
        }
        
        out.print(result.toString());
    }
}

