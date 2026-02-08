package com.fooddelivery.dao;

import com.fooddelivery.model.OrderHistory;
import java.util.List;

public interface OrderHistoryDao {
    void addOrderHistory(OrderHistory history);
    List<OrderHistory> getOrderHistoryByUser(int userId);
}

