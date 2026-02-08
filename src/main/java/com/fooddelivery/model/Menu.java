package com.fooddelivery.model;

import java.io.Serializable;

public class Menu implements Serializable {
    private static final long serialVersionUID = 1L;

    private int menuId;
    private int restaurantId;
    private String itemName;
    private String category;
    private float price;
    private boolean isAvailable; // Mapped from availability
    private String spiceLevel;
    private String imagePath;
    private String description;

    public Menu() {}

    public Menu(int menuId, int restaurantId, String itemName, String category, float price, boolean isAvailable, String spiceLevel, String imagePath, String description) {
        this.menuId = menuId;
        this.restaurantId = restaurantId;
        this.itemName = itemName;
        this.category = category;
        this.price = price;
        this.isAvailable = isAvailable;
        this.spiceLevel = spiceLevel;
        this.imagePath = imagePath;
        this.description = description;
    }

    public int getMenuId() { return menuId; }
    public void setMenuId(int menuId) { this.menuId = menuId; }

    public int getRestaurantId() { return restaurantId; }
    public void setRestaurantId(int restaurantId) { this.restaurantId = restaurantId; }

    public String getItemName() { return itemName; }
    public void setItemName(String itemName) { this.itemName = itemName; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public float getPrice() { return price; }
    public void setPrice(float price) { this.price = price; }

    public boolean isAvailable() { return isAvailable; }
    public void setAvailable(boolean available) { isAvailable = available; }

    public String getSpiceLevel() { return spiceLevel; }
    public void setSpiceLevel(String spiceLevel) { this.spiceLevel = spiceLevel; }
    
    public String getImagePath() { return imagePath; }
    public void setImagePath(String imagePath) { this.imagePath = imagePath; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
}

