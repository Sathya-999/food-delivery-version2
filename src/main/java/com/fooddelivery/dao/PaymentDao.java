package com.fooddelivery.dao;

import com.fooddelivery.util.DBConnection;
import java.sql.*;

public class PaymentDao {
    
    /**
     * Record a payment in the database
     */
    public int recordPayment(int orderId, int userId, double amount, String paymentMethod, String transactionId) {
        String sql = "INSERT INTO payments (order_id, user_id, amount, payment_method, transaction_id, payment_status) VALUES (?, ?, ?, ?, ?, 'SUCCESS')";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            ps.setInt(1, orderId);
            ps.setInt(2, userId);
            ps.setDouble(3, amount);
            ps.setString(4, paymentMethod);
            ps.setString(5, transactionId);
            
            int rows = ps.executeUpdate();
            
            if (rows > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }
    
    /**
     * Check if payment exists and is successful for an order
     */
    public boolean isPaymentConfirmed(int orderId) {
        String sql = "SELECT payment_status FROM payments WHERE order_id = ? AND payment_status = 'SUCCESS'";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();
            
            return rs.next(); // If a row exists, payment is confirmed
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    /**
     * Check if payment exists by transaction ID
     */
    public boolean isPaymentExistsByTransactionId(String transactionId) {
        String sql = "SELECT payment_id FROM payments WHERE transaction_id = ? AND payment_status = 'SUCCESS'";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, transactionId);
            ResultSet rs = ps.executeQuery();
            
            return rs.next();
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    /**
     * Update payment status
     */
    public boolean updatePaymentStatus(int paymentId, String status) {
        String sql = "UPDATE payments SET payment_status = ? WHERE payment_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, status);
            ps.setInt(2, paymentId);
            
            return ps.executeUpdate() > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    /**
     * Get payment details for an order
     */
    public String getPaymentStatus(int orderId) {
        String sql = "SELECT payment_status FROM payments WHERE order_id = ? ORDER BY payment_date DESC LIMIT 1";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                return rs.getString("payment_status");
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
