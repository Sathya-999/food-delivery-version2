package com.fooddelivery.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

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

@WebServlet("/searchSuggest")
public class SearchSuggestServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private RestaurantDao restaurantDao = new RestaurantDaoImpl();
    private MenuDao menuDao = new MenuDaoImpl();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        String query = request.getParameter("q");
        PrintWriter out = response.getWriter();
        
        if (query == null || query.trim().isEmpty() || query.trim().length() < 2) {
            out.print("[]");
            return;
        }
        
        query = query.trim().toLowerCase();
        List<String> suggestions = new ArrayList<>();
        
        // Search restaurants
        List<Restaurant> restaurants = restaurantDao.getAllRestaurants();
        for (Restaurant r : restaurants) {
            if (suggestions.size() >= 8) break;
            String name = r.getName();
            String cuisine = r.getCuisineType();
            String address = r.getAddress();
            
            if (name != null && name.toLowerCase().contains(query)) {
                String suggestion = "{\"type\":\"restaurant\",\"id\":" + r.getRestaurantId() + 
                    ",\"name\":\"" + escapeJson(name) + "\",\"sub\":\"" + escapeJson(cuisine) + "\"}";
                if (!suggestions.contains(suggestion)) suggestions.add(suggestion);
            }
            if (cuisine != null && cuisine.toLowerCase().contains(query) && suggestions.size() < 8) {
                String suggestion = "{\"type\":\"cuisine\",\"id\":0,\"name\":\"" + escapeJson(cuisine) + 
                    "\",\"sub\":\"Cuisine\"}";
                if (!containsName(suggestions, cuisine)) suggestions.add(suggestion);
            }
        }
        
        // Search menu items - only show items with valid images
        List<Menu> menuItems = menuDao.getAllMenuItems();
        for (Menu m : menuItems) {
            if (suggestions.size() >= 10) break;
            String itemName = m.getItemName();
            String category = m.getCategory();
            String imagePath = m.getImagePath();
            
            // Only include items with valid images
            if (itemName != null && itemName.toLowerCase().contains(query) && imagePath != null && !imagePath.trim().isEmpty()) {
                // Get restaurant name
                String restaurantName = "";
                for (Restaurant r : restaurants) {
                    if (r.getRestaurantId() == m.getRestaurantId()) {
                        restaurantName = r.getName();
                        break;
                    }
                }
                String suggestion = "{\"type\":\"food\",\"id\":" + m.getRestaurantId() + 
                    ",\"menuId\":" + m.getMenuId() +
                    ",\"name\":\"" + escapeJson(itemName) + 
                    "\",\"image\":\"" + escapeJson(imagePath) + 
                    "\",\"price\":\"₹" + m.getPrice() + 
                    "\",\"restaurant\":\"" + escapeJson(restaurantName) + 
                    "\",\"sub\":\"" + escapeJson(restaurantName) + " • ₹" + m.getPrice() + "\"}";
                if (!containsName(suggestions, itemName)) suggestions.add(suggestion);
            }
            if (category != null && category.toLowerCase().contains(query) && suggestions.size() < 10) {
                String suggestion = "{\"type\":\"category\",\"id\":0,\"name\":\"" + escapeJson(category) + 
                    "\",\"sub\":\"Category\"}";
                if (!containsName(suggestions, category)) suggestions.add(suggestion);
            }
        }
        
        out.print("[" + String.join(",", suggestions) + "]");
    }
    
    private boolean containsName(List<String> suggestions, String name) {
        for (String s : suggestions) {
            if (s.contains("\"name\":\"" + escapeJson(name) + "\"")) return true;
        }
        return false;
    }
    
    private String escapeJson(String str) {
        if (str == null) return "";
        return str.replace("\\", "\\\\")
                  .replace("\"", "\\\"")
                  .replace("\n", "\\n")
                  .replace("\r", "\\r")
                  .replace("\t", "\\t");
    }
}

