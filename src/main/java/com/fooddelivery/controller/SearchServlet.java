package com.fooddelivery.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fooddelivery.dao.MenuDao;
import com.fooddelivery.dao.RestaurantDao;
import com.fooddelivery.dao.impl.MenuDaoImpl;
import com.fooddelivery.dao.impl.RestaurantDaoImpl;
import com.fooddelivery.model.Menu;
import com.fooddelivery.model.Restaurant;

@WebServlet("/search")
public class SearchServlet extends HttpServlet {
    
    private MenuDao menuDao;
    private RestaurantDao restaurantDao;
    
    @Override
    public void init() throws ServletException {
        menuDao = new MenuDaoImpl();
        restaurantDao = new RestaurantDaoImpl();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String query = request.getParameter("q");
        
        if (query == null || query.trim().length() < 2) {
            response.sendRedirect("home");
            return;
        }
        
        query = query.trim().toLowerCase();
        
        // Get all restaurants and create a map for lookup
        List<Restaurant> allRestaurants = restaurantDao.getAllRestaurants();
        Map<Integer, String> restaurantNames = new HashMap<>();
        List<Restaurant> matchedRestaurants = new ArrayList<>();
        
        for (Restaurant r : allRestaurants) {
            restaurantNames.put(r.getRestaurantId(), r.getName());
            
            String name = r.getName() != null ? r.getName().toLowerCase() : "";
            String cuisine = r.getCuisineType() != null ? r.getCuisineType().toLowerCase() : "";
            String address = r.getAddress() != null ? r.getAddress().toLowerCase() : "";
            
            if (name.contains(query) || cuisine.contains(query) || address.contains(query)) {
                matchedRestaurants.add(r);
            }
        }
        
        // Search menu items - ONLY include items with valid imagePath
        List<Menu> allMenuItems = menuDao.getAllMenuItems();
        List<Menu> matchedMenuItems = new ArrayList<>();
        
        for (Menu m : allMenuItems) {
            // Skip items without images
            String imagePath = m.getImagePath();
            if (imagePath == null || imagePath.trim().isEmpty()) {
                continue;
            }
            
            String itemName = m.getItemName() != null ? m.getItemName().toLowerCase() : "";
            String description = m.getDescription() != null ? m.getDescription().toLowerCase() : "";
            String category = m.getCategory() != null ? m.getCategory().toLowerCase() : "";
            
            if (itemName.contains(query) || description.contains(query) || category.contains(query)) {
                matchedMenuItems.add(m);
            }
        }
        
        request.setAttribute("searchQuery", query);
        request.setAttribute("restaurants", matchedRestaurants);
        request.setAttribute("menuItems", matchedMenuItems);
        request.setAttribute("restaurantNames", restaurantNames);
        request.setAttribute("totalResults", matchedRestaurants.size() + matchedMenuItems.size());
        
        request.getRequestDispatcher("/WEB-INF/views/search.jsp").forward(request, response);
    }
}

