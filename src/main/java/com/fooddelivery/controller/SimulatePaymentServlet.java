package com.fooddelivery.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;

import com.fooddelivery.config.DBConnection;
import com.fooddelivery.model.User;

/**
 * DEMO/TEST ONLY: Simulates receiving a UPI payment
 * In production, this would be replaced by a webhook from PhonePe/GPay/Paytm
 * 
 * This endpoint records a payment in the database as if it was received via UPI
 */
@WebServlet("/simulatePayment")
public class SimulatePaymentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

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
            Double amount = (Double) session.getAttribute("pendingOrderAmount");
            
            if (amount == null) {
                result.put("success", false);
                result.put("message", "No pending payment amount found.");
                out.print(result.toString());
                return;
            }
            
            // Generate a unique payment ID
            String paymentId = "UPI" + System.currentTimeMillis() + "_" + user.getUserId();
            
            // Record the payment in database
            boolean success = recordPayment(paymentId, user.getUserId(), amount);
            
            if (success) {
                result.put("success", true);
                result.put("message", "Payment of Rs." + amount + " received successfully!");
                result.put("paymentId", paymentId);
                System.out.println("[SimulatePayment] Payment recorded: " + paymentId + " for user: " + user.getUserId() + " amount: " + amount);
            } else {
                result.put("success", false);
                result.put("message", "Failed to record payment. Please try again.");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            result.put("success", false);
            result.put("message", "Error: " + e.getMessage());
        }
        
        out.print(result.toString());
    }
    
    private boolean recordPayment(String paymentId, int userId, double amount) {
        String sql = "INSERT INTO payments (paymentId, userId, amount, status, provider) VALUES (?, ?, ?, ?, ?)";
        
        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql)) {
            
            pstmt.setString(1, paymentId);
            pstmt.setInt(2, userId);
            pstmt.setDouble(3, amount);
            pstmt.setString(4, "Success");
            pstmt.setString(5, "UPI_QR");
            
            int rows = pstmt.executeUpdate();
            return rows > 0;
            
        } catch (SQLException e) {
            System.err.println("[SimulatePayment] Database error: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}

