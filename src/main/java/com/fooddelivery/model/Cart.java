package com.fooddelivery.model;

import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;

public class Cart implements Serializable {
    private Map<Integer, CartItem> items;

    public Cart() {
        this.items = new HashMap<>();
    }

    public void addItem(CartItem item) {
        if (items.containsKey(item.getItemId())) {
            CartItem existing = items.get(item.getItemId());
            existing.setQuantity(existing.getQuantity() + item.getQuantity());
        } else {
            items.put(item.getItemId(), item);
        }
    }

    public void updateItem(int itemId, int quantity) {
        if (items.containsKey(itemId)) {
            if (quantity <= 0) {
                items.remove(itemId);
            } else {
                items.get(itemId).setQuantity(quantity);
            }
        }
    }

    public void removeItem(int itemId) {
        items.remove(itemId);
    }

    public Map<Integer, CartItem> getItems() {
        return items;
    }

    public void clear() {
        items.clear();
    }
    
    // Total Price Calculation (Assuming CartItem has price data)
    public float getTotalPrice() {
        float total = 0;
        for (CartItem item : items.values()) {
            total += item.getPrice() * item.getQuantity();
        }
        return total;
    }
}

