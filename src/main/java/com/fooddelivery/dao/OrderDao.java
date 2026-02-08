package com.fooddelivery.dao;

import java.util.List;

import com.fooddelivery.model.Order;

public interface OrderDao {
    int addOrder(Order order);
    Order getOrder(int orderId);
    List<Order> getAllOrdersByUser(int userId);
    void updateOrderStatus(int orderId, String status);
    
    // Check if transaction ID already used (prevent duplicate/replay attacks)
    boolean isTransactionIdUsed(String transactionId);
    
    // New transactional method
    boolean placeOrder(Order order, com.tap.fooddelivery.model.Cart cart, String paymentId, String paymentStatus);
}

