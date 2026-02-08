package com.fooddelivery.dao;

import java.util.List;

import com.fooddelivery.model.Menu;

public interface MenuDao {
    int addMenu(Menu menu);
    Menu getMenu(int menuId);
    List<Menu> getAllMenusByRestaurant(int restaurantId);
    List<Menu> getAllMenuItems();
    void updateMenu(Menu menu);
    void deleteMenu(int menuId);
}

