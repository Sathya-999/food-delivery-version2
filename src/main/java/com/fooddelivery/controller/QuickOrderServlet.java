package com.fooddelivery.controller;

import java.io.IOException;
import java.sql.Timestamp;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.fooddelivery.dao.MenuDao;
import com.fooddelivery.dao.OrderDao;
import com.fooddelivery.dao.impl.MenuDaoImpl;
import com.fooddelivery.dao.impl.OrderDaoImpl;
import com.fooddelivery.model.Menu;
import com.fooddelivery.model.Order;
import com.fooddelivery.model.User;

@WebServlet("/quickOrder")
public class QuickOrderServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private MenuDao menuDao;
    private OrderDao orderDao;

    @Override
    public void init() throws ServletException {
        menuDao = new MenuDaoImpl();
        orderDao = new OrderDaoImpl();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        
        // Check login
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        
        try {
            int menuId = Integer.parseInt(request.getParameter("menuId"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            if (quantity < 1) quantity = 1;
            
            // Get menu item details
            Menu menu = menuDao.getMenu(menuId);
            if (menu == null) {
                response.sendRedirect("home?error=item_not_found");
                return;
            }
            
            // Calculate total
            float totalAmount = menu.getPrice() * quantity;
            
            // Create order with PENDING status (not confirmed until payment)
            Order order = new Order();
            order.setUserId(user.getUserId());
            order.setRestaurantId(menu.getRestaurantId());
            order.setTotalAmount(totalAmount);
            order.setStatus("Pending Payment"); // Changed from "Confirmed"
            order.setPaymentMode("Online"); // Will be set after payment
            order.setOrderDate(new Timestamp(System.currentTimeMillis()));
            order.setMenuId(menuId);
            order.setQuantity(quantity);
            
            // Save pending order
            int orderId = orderDao.addOrder(order);
            
            if (orderId > 0) {
                System.out.println("[QuickOrder] Pending Order #" + orderId + " created for user: " + user.getUsername());
                
                // Store order details in session for payment page
                session.setAttribute("pendingOrderId", orderId);
                session.setAttribute("pendingOrderAmount", (double) totalAmount);
                session.setAttribute("pendingItemName", menu.getItemName());
                session.setAttribute("pendingQuantity", quantity);
                
                // Forward to PAYMENT page (using POST - info hidden from URL)
                request.getRequestDispatcher("/paymentPage").forward(request, response);
            } else {
                response.sendRedirect("home?error=order_failed");
            }
            
        } catch (NumberFormatException e) {
            response.sendRedirect("home?error=invalid_input");
        }
    }
}

