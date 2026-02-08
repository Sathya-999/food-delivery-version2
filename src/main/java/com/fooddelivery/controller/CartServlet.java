package com.fooddelivery.controller;

import com.fooddelivery.dao.MenuDao;
import com.fooddelivery.dao.impl.MenuDaoImpl;
import com.fooddelivery.model.Cart;
import com.fooddelivery.model.CartItem;
import com.fooddelivery.model.Menu;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {

    private MenuDao menuDao;

    @Override
    public void init() throws ServletException {
        menuDao = new MenuDaoImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/cart.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null) {
            cart = new Cart();
            session.setAttribute("cart", cart);
        }

        String action = request.getParameter("action");
        if ("add".equals(action)) {
            addToCart(request, cart);
        } else if ("update".equals(action)) {
            updateCart(request, cart);
        } else if ("remove".equals(action)) {
            removeFromCart(request, cart);
        }

        String redirect = request.getParameter("redirect");
        if ("checkout".equals(redirect)) {
            response.sendRedirect("checkout");
        } else {
            response.sendRedirect("cart");
        }
    }

    private void addToCart(HttpServletRequest request, Cart cart) {
        int menuId = Integer.parseInt(request.getParameter("menuId"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        // Fetch menu details to populate CartItem
        Menu menu = menuDao.getMenu(menuId);
        if (menu != null) {
            CartItem item = new CartItem(
                menu.getMenuId(),
                menu.getRestaurantId(),
                menu.getItemName(),
                menu.getPrice(),
                quantity,
                menu.getImagePath()
            );
            cart.addItem(item);
        }
    }

    private void updateCart(HttpServletRequest request, Cart cart) {
        int itemId = Integer.parseInt(request.getParameter("itemId"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        cart.updateItem(itemId, quantity);
    }
    
    private void removeFromCart(HttpServletRequest request, Cart cart) {
        int itemId = Integer.parseInt(request.getParameter("itemId"));
        cart.removeItem(itemId);
    }
}

