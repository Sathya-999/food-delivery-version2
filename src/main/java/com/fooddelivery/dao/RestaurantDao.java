package com.fooddelivery.dao;

import com.fooddelivery.model.Restaurant;
import java.util.List;

public interface RestaurantDao {
    int addRestaurant(Restaurant restaurant);
    Restaurant getRestaurant(int restaurantId);
    List<Restaurant> getAllRestaurants();
    void updateRestaurant(Restaurant restaurant);
    void deleteRestaurant(int restaurantId);
}

