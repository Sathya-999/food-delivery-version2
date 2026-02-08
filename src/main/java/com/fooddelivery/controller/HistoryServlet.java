package com.fooddelivery.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.fooddelivery.dao.OrderDao;
import com.fooddelivery.dao.impl.OrderDaoImpl;
import com.fooddelivery.model.Order;
import com.fooddelivery.model.User;

@WebServlet("/history")
public class HistoryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private OrderDao orderDao;

    @Override
    public void init() throws ServletException {
        orderDao = new OrderDaoImpl();
        System.out.println("[HistoryServlet] Initialized successfully");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        
        // Check if user is logged in
        if (session == null || session.getAttribute("user") == null) {
            System.out.println("[HistoryServlet] No user session found, redirecting to login");
            response.sendRedirect("login");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        System.out.println("[HistoryServlet] User logged in: " + user.getUsername() + " (ID: " + user.getUserId() + ")");
        
        String orderIdParam = request.getParameter("orderId");
        
        // If orderId is provided, show single order details
        if (orderIdParam != null && !orderIdParam.trim().isEmpty()) {
            try {
                int orderId = Integer.parseInt(orderIdParam);
                System.out.println("[HistoryServlet] Fetching order details for orderId: " + orderId);
                Order order = orderDao.getOrder(orderId);
                
                // Verify the order belongs to this user
                if (order != null && order.getUserId() == user.getUserId()) {
                    System.out.println("[HistoryServlet] Order found and belongs to user");
                    request.setAttribute("order", order);
                    request.getRequestDispatcher("/WEB-INF/views/order_details.jsp").forward(request, response);
                } else {
                    System.out.println("[HistoryServlet] Order not found or doesn't belong to user");
                    response.sendRedirect("history");
                }
            } catch (NumberFormatException e) {
                System.out.println("[HistoryServlet] Invalid orderId format: " + orderIdParam);
                response.sendRedirect("history");
            }
        } else {
            // Show all orders for this specific user only
            System.out.println("[HistoryServlet] Fetching all orders for userId: " + user.getUserId());
            List<Order> historyList = orderDao.getAllOrdersByUser(user.getUserId());
            System.out.println("[HistoryServlet] Found " + historyList.size() + " orders for user: " + user.getUsername());
            
            request.setAttribute("history", historyList);
            request.getRequestDispatcher("/WEB-INF/views/history.jsp").forward(request, response);
        }
    }
}


