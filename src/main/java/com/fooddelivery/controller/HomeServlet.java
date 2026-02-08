package com.fooddelivery.controller;

import com.fooddelivery.dao.RestaurantDao;
import com.fooddelivery.dao.impl.RestaurantDaoImpl;
import com.fooddelivery.model.Restaurant;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {

    private RestaurantDao restaurantDao;

    @Override
    public void init() throws ServletException {
        restaurantDao = new RestaurantDaoImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            
            List<Restaurant> restaurantList = restaurantDao.getAllRestaurants();
            request.setAttribute("restaurants", restaurantList);

            // Fetch menu items for Popular Dishes section
            com.tap.fooddelivery.dao.MenuDao menuDao = new com.tap.fooddelivery.dao.impl.MenuDaoImpl();
            java.util.List<com.tap.fooddelivery.model.Menu> menuList = menuDao.getAllMenuItems();
            // Limit to top 20 for display
            if (menuList.size() > 20) {
                menuList = menuList.subList(0, 20);
            }
            request.setAttribute("popularMenus", menuList);
            
            // Forward to the View
            request.getRequestDispatcher("/WEB-INF/views/home.jsp").forward(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/login");
        }
    }
}

