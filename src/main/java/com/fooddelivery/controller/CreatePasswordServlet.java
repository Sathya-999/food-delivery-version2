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

@WebServlet("/createPassword")
public class CreatePasswordServlet extends HttpServlet {

    private UserDao userDao;
    private OtpDao otpDao;

    @Override
    public void init() throws ServletException {
        userDao = new UserDaoImpl();
        otpDao = new OtpDaoImpl();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Integer userId = (session != null) ? (Integer) session.getAttribute("signupUserId") : null;

        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String otpStr = request.getParameter("otp");
        String password = request.getParameter("password");
        String confirm = request.getParameter("confirm");

        if (password == null || !password.equals(confirm)) {
            request.setAttribute("error", "Passwords do not match");
            request.setAttribute("showOtpForm", true);
            request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
            return;
        }

        int otp = 0;
        try {
            otp = Integer.parseInt(otpStr);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid OTP format");
             request.setAttribute("showOtpForm", true);
            request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
            return;
        }

        if (otpDao.validateOtp(userId, otp)) {
            userDao.updatePassword(userId, password);
            otpDao.markOtpUsed(userId, otp);
            session.removeAttribute("signupUserId");
            
            // Redirect to login with success message, but since login page is complex, maybe just redirect to login and let user sign in.
            // Or auto-login? Standard is usually redirect to login.
            response.sendRedirect(request.getContextPath() + "/login"); // User can now sign in users panel
        } else {
            request.setAttribute("error", "Invalid OTP");
            request.setAttribute("showOtpForm", true);
            request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
        }
    }
}

