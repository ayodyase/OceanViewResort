package com.oceanviewresort.controller;

import com.oceanviewresort.model.UserDAO;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class LoginServlet extends HttpServlet {
    private UserDAO userDAO;

    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        String dbUrl = getConfigValue(config, "DB_URL");
        String dbUser = getConfigValue(config, "DB_USER");
        String dbPassword = getConfigValue(config, "DB_PASSWORD");
        userDAO = new UserDAO(dbUrl, dbUser, dbPassword);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String username = trimToNull(request.getParameter("username"));
        String password = trimToNull(request.getParameter("password"));

        if (username == null || password == null) {
            request.setAttribute("error", "Invalid username or password.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        boolean valid = userDAO.validateUser(username, password);
        if (valid) {
            if (!"admin".equalsIgnoreCase(username)) {
                request.setAttribute("error", "Access denied.");
                request.getRequestDispatcher("/login.jsp").forward(request, response);
                return;
            }
            HttpSession existing = request.getSession(false);
            if (existing != null) {
                existing.invalidate();
            }

            HttpSession session = request.getSession(true);
            session.setAttribute("username", username);
            session.setMaxInactiveInterval(15 * 60);

            response.sendRedirect(request.getContextPath() + "/admin");
        } else {
            request.setAttribute("error", "Invalid username or password.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }

    private String getConfigValue(ServletConfig config, String key) {
        String envValue = System.getenv(key);
        if (envValue != null && !envValue.trim().isEmpty()) {
            return envValue;
        }
        String ctxValue = config.getServletContext().getInitParameter(key);
        return ctxValue == null ? "" : ctxValue.trim();
    }

    private String trimToNull(String value) {
        if (value == null) {
            return null;
        }
        String trimmed = value.trim();
        return trimmed.isEmpty() ? null : trimmed;
    }
}
