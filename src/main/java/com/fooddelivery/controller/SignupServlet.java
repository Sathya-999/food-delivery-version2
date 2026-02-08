package com.fooddelivery.controller;

import com.fooddelivery.dao.OtpDao;
import com.fooddelivery.dao.UserDao;
import com.fooddelivery.dao.impl.OtpDaoImpl;
import com.fooddelivery.dao.impl.UserDaoImpl;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/signup")
public class SignupServlet extends HttpServlet {

    private UserDao userDao;
    private OtpDao otpDao;

    @Override
    public void init() throws ServletException {
        userDao = new UserDaoImpl();
        otpDao = new OtpDaoImpl();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String mobile = request.getParameter("mobile");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        if (password == null || !password.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match");
            request.setAttribute("showSignup", true);
            request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
            return;
        }

        if (userDao.fetchByEmail(email) != null) {
            request.setAttribute("error", "Email already exists");
            request.setAttribute("showSignup", true); 
            request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
            return;
        }

        long mobileNum = 0;
        try {
            mobileNum = Long.parseLong(mobile);
            if (userDao.fetchByMobile(mobileNum) != null) {
                request.setAttribute("error", "Mobile number already exists");
                request.setAttribute("showSignup", true);
                request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
                return;
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid mobile number");
            request.setAttribute("showSignup", true);
            request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
            return;
        }

        // Direct Insert
        com.tap.fooddelivery.model.User newUser = new com.tap.fooddelivery.model.User(name, email, password, mobileNum);
        userDao.insert(newUser);
        
        // Auto Login? Or Redirect to Login?
        // Let's redirect to login for now to keep it simple, or we can auto-login provided we fetch the generated ID.
        // Since insert(User) uses void, we might not get the ID back immediately unless we assume successful insert.
        // Ideally UserDao.insert should return int.
        // But for now, let's just assume success and ask user to login.
        
        response.sendRedirect(request.getContextPath() + "/login");
    }
}

