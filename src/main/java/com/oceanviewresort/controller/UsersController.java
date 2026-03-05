package com.oceanviewresort.controller;

import com.oceanviewresort.model.StaffDao;
import com.oceanviewresort.model.StaffMember;
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
import java.util.ArrayList;
import java.util.List;
import com.oceanviewresort.security.AccessUtil;
import com.oceanviewresort.model.PasswordUtil;

@Controller
@RequestMapping("/users")
public class UsersController {
    private final StaffDao staffDao;

    public UsersController(StaffDao staffDao) {
        this.staffDao = staffDao;
    }

    @GetMapping({"", "/"})
    public String usersPage(@RequestParam(value = "editId", required = false) Integer editId,
                            Model model,
                            HttpServletRequest request,
                            HttpServletResponse response) throws IOException {
        if (!AccessUtil.ensureLoggedIn(request, response)) {
            return null;
        }

        HttpSession session = request.getSession(false);
        model.addAttribute("canEdit", AccessUtil.canEdit(session));

        StaffMember form = new StaffMember();
        if (editId != null) {
            StaffMember existing = staffDao.findById(editId);
            if (existing != null) {
                form = existing;
            } else {
                model.addAttribute("errorMessage", "Selected staff entry was not found.");
            }
        }

        model.addAttribute("staffForm", form);
        model.addAttribute("staffList", staffDao.findAll());
        if (session != null) {
            Object flash = session.getAttribute("flashMessage");
            if (flash instanceof String) {
                model.addAttribute("successMessage", flash);
                session.removeAttribute("flashMessage");
            }
        }
        return "users";
    }

    @PostMapping("/save")
    public String saveStaff(StaffMember staff,
                            Model model,
                            HttpServletRequest request,
                            HttpServletResponse response) throws IOException {
        if (!AccessUtil.ensureCanEdit(request, response)) {
            return null;
        }

        List<String> errors = validate(staff);
        if (!errors.isEmpty()) {
            model.addAttribute("staffForm", staff);
            model.addAttribute("staffList", staffDao.findAll());
            model.addAttribute("errorMessage", String.join(" ", errors));
            return "users";
        }

        if (staff.getId() == null) {
            staffDao.create(staff);
        } else {
            staffDao.update(staff);
        }
        return "redirect:/users";
    }

    @PostMapping("/delete")
    public String deleteStaff(@RequestParam("id") int id,
                              HttpServletRequest request,
                              HttpServletResponse response) throws IOException {
        if (!AccessUtil.ensureCanEdit(request, response)) {
            return null;
        }
        staffDao.delete(id);
        return "redirect:/users";
    }

    @PostMapping("/reset-password")
    public String resetPassword(@RequestParam("id") int id,
                                @RequestParam(value = "newPassword", required = false) String newPassword,
                                HttpServletRequest request,
                                HttpServletResponse response,
                                Model model) throws IOException {
        if (!AccessUtil.ensureCanEdit(request, response)) {
            return null;
        }
        StaffMember staff = staffDao.findById(id);
        if (staff == null || isBlank(staff.getEmployeeId())) {
            model.addAttribute("staffForm", new StaffMember());
            model.addAttribute("staffList", staffDao.findAll());
            model.addAttribute("errorMessage", "Unable to reset password for the selected staff member.");
            return "users";
        }
        String passwordValue = isBlank(newPassword) ? staff.getEmployeeId() : newPassword.trim();
        String newHash = PasswordUtil.hashPassword(passwordValue);
        staffDao.updatePasswordHash(id, newHash);
        HttpSession session = request.getSession(false);
        if (session != null) {
            if (isBlank(newPassword)) {
                session.setAttribute("flashMessage", "Password reset to Employee ID for " + staff.getName() + ".");
            } else {
                session.setAttribute("flashMessage", "Password updated for " + staff.getName() + ".");
            }
        }
        return "redirect:/users";
    }

    private List<String> validate(StaffMember staff) {
        List<String> errors = new ArrayList<>();
        if (isBlank(staff.getName())) {
            errors.add("Name is required.");
        }
        if (isBlank(staff.getEmail())) {
            errors.add("Email is required.");
        }
        if (isBlank(staff.getEmployeeId())) {
            errors.add("Employee ID is required.");
        }
        if (isBlank(staff.getRole())) {
            errors.add("Role is required.");
        }
        if (isBlank(staff.getHoursStart()) || isBlank(staff.getHoursEnd())) {
            errors.add("Working hours start and end are required.");
        }
        if (isBlank(staff.getStatus())) {
            errors.add("Activation status is required.");
        }
        if (staff.getId() == null && isBlank(staff.getPassword())) {
            errors.add("Password is required for new staff.");
        }
        return errors;
    }

    private boolean isBlank(String value) {
        return value == null || value.trim().isEmpty();
    }
}
