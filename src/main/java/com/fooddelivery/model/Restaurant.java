package com.fooddelivery.model;

import java.io.Serializable;
import java.sql.Time;

public class Restaurant implements Serializable {
    private static final long serialVersionUID = 1L;

    private int restaurantId;
    private String name;
    private String cuisineType;
    private String address;
    private float ratings;
    private Time deliveryTime;
    private boolean isActive;
    // Assuming image path was meant to be there or generally valid
    private String imagePath; 

    public Restaurant() {}

    public Restaurant(int restaurantId, String name, String cuisineType, String address, float ratings, Time deliveryTime, boolean isActive, String imagePath) {
        this.restaurantId = restaurantId;
        this.name = name;
        this.cuisineType = cuisineType;
        this.address = address;
        this.ratings = ratings;
        this.deliveryTime = deliveryTime;
        this.isActive = isActive;
        this.imagePath = imagePath;
    }

    public int getRestaurantId() { return restaurantId; }
    public void setRestaurantId(int restaurantId) { this.restaurantId = restaurantId; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getCuisineType() { return cuisineType; }
    public void setCuisineType(String cuisineType) { this.cuisineType = cuisineType; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public float getRatings() { return ratings; }
    public void setRatings(float ratings) { this.ratings = ratings; }

    public Time getDeliveryTime() { return deliveryTime; }
    public void setDeliveryTime(Time deliveryTime) { this.deliveryTime = deliveryTime; }

    public boolean isActive() { return isActive; }
    public void setActive(boolean active) { isActive = active; }

    public String getImagePath() { return imagePath; }
    public void setImagePath(String imagePath) { this.imagePath = imagePath; }
}

