package com.oceanviewresort.controller;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class AdminServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        String username = session == null ? null : (String) session.getAttribute("username");
        if (username == null) {
            response.sendRedirect(request.getContextPath() + "/login?error=1");
            return;
        }
        if (!"admin".equalsIgnoreCase(username)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access denied");
            return;
        }

        request.getRequestDispatcher("/admin.jsp").forward(request, response);
    }
}
