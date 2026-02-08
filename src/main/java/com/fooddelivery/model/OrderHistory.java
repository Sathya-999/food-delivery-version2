package com.fooddelivery.model;

import java.io.Serializable;
import java.sql.Timestamp;

public class OrderHistory implements Serializable {
    private static final long serialVersionUID = 1L;

    private int orderHistoryId;
    private int orderId;
    private int userId;
    private float totalAmount;
    private String status;
    private Timestamp orderDate;

    public OrderHistory() {}

    public OrderHistory(int orderHistoryId, int orderId, int userId, float totalAmount, String status, Timestamp orderDate) {
        this.orderHistoryId = orderHistoryId;
        this.orderId = orderId;
        this.userId = userId;
        this.totalAmount = totalAmount;
        this.status = status;
        this.orderDate = orderDate;
    }

    public int getOrderHistoryId() { return orderHistoryId; }
    public void setOrderHistoryId(int orderHistoryId) { this.orderHistoryId = orderHistoryId; }

    public int getOrderId() { return orderId; }
    public void setOrderId(int orderId) { this.orderId = orderId; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public float getTotalAmount() { return totalAmount; }
    public void setTotalAmount(float totalAmount) { this.totalAmount = totalAmount; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public Timestamp getOrderDate() { return orderDate; }
    public void setOrderDate(Timestamp orderDate) { this.orderDate = orderDate; }
}

