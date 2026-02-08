package com.fooddelivery.dao;

import com.fooddelivery.model.OrderItem;
import java.util.List;

public interface OrderItemDao {
    void addOrderItem(OrderItem orderItem);
    List<OrderItem> getOrderItemsByOrder(int orderId);
}

