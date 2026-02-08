package com.fooddelivery.controller;

import com.fooddelivery.dao.MenuDao;
import com.fooddelivery.dao.impl.MenuDaoImpl;
import com.fooddelivery.model.Menu;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/menu")
public class MenuServlet extends HttpServlet {

    private MenuDao menuDao;

    @Override
    public void init() throws ServletException {
        menuDao = new MenuDaoImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String resIdStr = request.getParameter("restaurantId");
        if (resIdStr != null) {
            try {
                int restaurantId = Integer.parseInt(resIdStr);
                List<Menu> menuList = menuDao.getAllMenusByRestaurant(restaurantId);
                request.setAttribute("menus", menuList);
                request.setAttribute("restaurantId", restaurantId); // Keep track
                
                request.getRequestDispatcher("/WEB-INF/views/menu.jsp").forward(request, response);
            } catch (NumberFormatException e) {
                response.sendRedirect("home");
            }
        } else {
            response.sendRedirect("home");
        }
    }
}

