package com.fooddelivery.model;

import java.io.Serializable;

public class CartItem implements Serializable {
    private int itemId; // Menu ID
    private int restaurantId;
    private String name;
    private float price;
    private int quantity;
    private String imagePath;

    public CartItem() {}

    public CartItem(int itemId, int restaurantId, String name, float price, int quantity, String imagePath) {
        this.itemId = itemId;
        this.restaurantId = restaurantId;
        this.name = name;
        this.price = price;
        this.quantity = quantity;
        this.imagePath = imagePath;
    }

    public int getItemId() { return itemId; }
    public void setItemId(int itemId) { this.itemId = itemId; }

    public int getRestaurantId() { return restaurantId; }
    public void setRestaurantId(int restaurantId) { this.restaurantId = restaurantId; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public float getPrice() { return price; }
    public void setPrice(float price) { this.price = price; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }
    
    public String getImagePath() { return imagePath; } // For display in cart
    public void setImagePath(String imagePath) { this.imagePath = imagePath; }
    
    public float getTotal() {
        return price * quantity;
    }
}

