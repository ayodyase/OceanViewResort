package com.oceanviewresort.controller;

import com.oceanviewresort.model.PasswordUtil;
import com.oceanviewresort.model.StaffDao;
import com.oceanviewresort.model.StaffMember;
import com.oceanviewresort.model.UserDAO;
import com.oceanviewresort.security.AccessUtil;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@Controller
@RequestMapping("/profile")
public class ProfileController {
    private final StaffDao staffDao;

    public ProfileController(StaffDao staffDao) {
        this.staffDao = staffDao;
    }

    @GetMapping({"", "/"})
    public String profilePage(Model model,
                              HttpServletRequest request,
                              HttpServletResponse response) throws IOException {
        if (!AccessUtil.ensureLoggedIn(request, response)) {
            return null;
        }
        populateProfile(model, request.getSession(false));
        return "profile";
    }

    @PostMapping("/password")
    public String changePassword(@RequestParam("currentPassword") String currentPassword,
                                 @RequestParam("newPassword") String newPassword,
                                 @RequestParam("confirmPassword") String confirmPassword,
                                 Model model,
                                 HttpServletRequest request,
                                 HttpServletResponse response) throws IOException {
        if (!AccessUtil.ensureLoggedIn(request, response)) {
            return null;
        }
        HttpSession session = request.getSession(false);
        String username = session == null ? null : (String) session.getAttribute("username");
        if (isBlank(currentPassword) || isBlank(newPassword) || isBlank(confirmPassword)) {
            model.addAttribute("errorMessage", "All password fields are required.");
            populateProfile(model, session);
            return "profile";
        }
        if (!newPassword.equals(confirmPassword)) {
            model.addAttribute("errorMessage", "New password and confirmation do not match.");
            populateProfile(model, session);
            return "profile";
        }
        if (newPassword.length() < 6) {
            model.addAttribute("errorMessage", "New password must be at least 6 characters.");
            populateProfile(model, session);
            return "profile";
        }

        String role = AccessUtil.getRole(session);
        if ("Admin".equalsIgnoreCase(role) || "admin".equalsIgnoreCase(username)) {
            UserDAO userDAO = buildUserDao(request);
            if (userDAO == null || !userDAO.validateUser(username, currentPassword)) {
                model.addAttribute("errorMessage", "Current password is incorrect.");
                populateProfile(model, session);
                return "profile";
            }
            String hash = PasswordUtil.hashPassword(newPassword);
            userDAO.updatePasswordHash(username, hash);
        } else {
            com.oceanviewresort.model.StaffAuthDao staffAuthDao = buildStaffAuthDao(request);
            if (staffAuthDao == null || staffAuthDao.validateStaff(username, currentPassword) == null) {
                model.addAttribute("errorMessage", "Current password is incorrect.");
                populateProfile(model, session);
                return "profile";
            }
            StaffMember staff = staffDao.findByEmployeeId(username);
            if (staff == null) {
                model.addAttribute("errorMessage", "Staff record not found.");
                populateProfile(model, session);
                return "profile";
            }
            String hash = PasswordUtil.hashPassword(newPassword);
            staffDao.updatePasswordHash(staff.getId(), hash);
        }

        model.addAttribute("successMessage", "Password updated successfully.");
        populateProfile(model, session);
        return "profile";
    }

    private void populateProfile(Model model, HttpSession session) {
        String username = session == null ? null : (String) session.getAttribute("username");
        String role = AccessUtil.getRole(session);

        if ("Admin".equalsIgnoreCase(role) || "admin".equalsIgnoreCase(username)) {
            model.addAttribute("profileName", "System Administrator");
            model.addAttribute("profileRole", "Admin");
            model.addAttribute("profileUsername", "admin");
            model.addAttribute("profileEmail", "admin@oceanviewresort.local");
            model.addAttribute("profileGender", "N/A");
            model.addAttribute("profileNic", "N/A");
            model.addAttribute("profileEmployeeId", "N/A");
            model.addAttribute("profileHours", "N/A");
            model.addAttribute("profileStatus", "Active");
            return;
        }

        StaffMember staff = staffDao.findByEmployeeId(username);
        if (staff == null) {
            model.addAttribute("profileName", username == null ? "Unknown" : username);
            model.addAttribute("profileRole", role == null ? "Staff" : role);
            model.addAttribute("profileUsername", username);
            model.addAttribute("profileEmail", "N/A");
            model.addAttribute("profileGender", "N/A");
            model.addAttribute("profileNic", "N/A");
            model.addAttribute("profileEmployeeId", username);
            model.addAttribute("profileHours", "N/A");
            model.addAttribute("profileStatus", "N/A");
            return;
        }

        model.addAttribute("profileName", staff.getName());
        model.addAttribute("profileRole", staff.getRole());
        model.addAttribute("profileUsername", staff.getEmployeeId());
        model.addAttribute("profileEmail", staff.getEmail());
        model.addAttribute("profileGender", emptyOr(staff.getGender(), "N/A"));
        model.addAttribute("profileNic", emptyOr(staff.getNic(), "N/A"));
        model.addAttribute("profileEmployeeId", staff.getEmployeeId());
        model.addAttribute("profileHours", staff.getHoursStart() + " - " + staff.getHoursEnd());
        model.addAttribute("profileStatus", staff.getStatus());
    }

    private UserDAO buildUserDao(HttpServletRequest request) {
        String dbUrl = getConfigValue(request, "DB_URL");
        String dbUser = getConfigValue(request, "DB_USER");
        String dbPassword = getConfigValue(request, "DB_PASSWORD");
        if (isBlank(dbUrl)) {
            return null;
        }
        return new UserDAO(dbUrl, dbUser, dbPassword);
    }

    private com.oceanviewresort.model.StaffAuthDao buildStaffAuthDao(HttpServletRequest request) {
        String dbUrl = getConfigValue(request, "DB_URL");
        String dbUser = getConfigValue(request, "DB_USER");
        String dbPassword = getConfigValue(request, "DB_PASSWORD");
        if (isBlank(dbUrl)) {
            return null;
        }
        return new com.oceanviewresort.model.StaffAuthDao(dbUrl, dbUser, dbPassword);
    }

    private String getConfigValue(HttpServletRequest request, String key) {
        String envValue = System.getenv(key);
        if (envValue != null && !envValue.trim().isEmpty()) {
            return envValue.trim();
        }
        String ctxValue = request.getServletContext().getInitParameter(key);
        return ctxValue == null ? "" : ctxValue.trim();
    }

    private String emptyOr(String value, String fallback) {
        return isBlank(value) ? fallback : value.trim();
    }

    private boolean isBlank(String value) {
        return value == null || value.trim().isEmpty();
    }
}
