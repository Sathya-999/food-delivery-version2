package com.fooddelivery.controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

import com.fooddelivery.dao.OrderDao;
import com.fooddelivery.dao.impl.OrderDaoImpl;

@WebServlet("/orderSuccess")
public class OrderSuccessServlet extends HttpServlet {
    
    private OrderDao orderDao;
    
    @Override
    public void init() throws ServletException {
        orderDao = new OrderDaoImpl();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        
        // Check if there's a pending order to confirm
        if (session != null && session.getAttribute("pendingOrderId") != null) {
            int orderId = (Integer) session.getAttribute("pendingOrderId");
            String paymentMode = request.getParameter("paymentMode");
            if (paymentMode == null) paymentMode = "Online";
            
            // Update order status to CONFIRMED
            try {
                orderDao.updateOrderStatus(orderId, "Confirmed");
                System.out.println("[OrderSuccess] Order #" + orderId + " CONFIRMED after payment!");
                
                // Clear pending order from session
                session.removeAttribute("pendingOrderId");
                session.removeAttribute("pendingOrderAmount");
                session.removeAttribute("pendingItemName");
                session.removeAttribute("pendingQuantity");
                
                // Redirect to order history with success
                response.sendRedirect("history?success=payment_completed&orderId=" + orderId);
                return;
                
            } catch (Exception e) {
                System.err.println("[OrderSuccess] Failed to confirm order: " + e.getMessage());
            }
        }
        
        // Default: show success page
        request.getRequestDispatcher("/WEB-INF/views/order_success.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Handle POST same as GET
        doGet(request, response);
    }
}

