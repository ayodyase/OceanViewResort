package com.oceanviewresort.security;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public final class AccessUtil {
    private AccessUtil() {
    }

    public static boolean ensureLoggedIn(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect(request.getContextPath() + "/login?error=1");
            return false;
        }
        return true;
    }

    public static boolean ensureCanEdit(HttpServletRequest request, HttpServletResponse response) throws IOException {
        if (!ensureLoggedIn(request, response)) {
            return false;
        }
        HttpSession session = request.getSession(false);
        if (!canEdit(session)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access denied");
            return false;
        }
        return true;
    }

    public static boolean canEdit(HttpSession session) {
        String role = getRole(session);
        return "admin".equalsIgnoreCase(role)
                || "manager".equalsIgnoreCase(role)
                || "it executive".equalsIgnoreCase(role);
    }

    public static String getRole(HttpSession session) {
        if (session == null) {
            return null;
        }
        Object role = session.getAttribute("role");
        if (role instanceof String && !((String) role).trim().isEmpty()) {
            return ((String) role).trim();
        }
        Object username = session.getAttribute("username");
        if (username instanceof String && "admin".equalsIgnoreCase((String) username)) {
            return "Admin";
        }
        return null;
    }
}
