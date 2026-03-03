package com.oceanviewresort.controller;

import com.oceanviewresort.model.ResortSetting;
import com.oceanviewresort.model.ResortSettingDao;
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

@Controller
@RequestMapping("/settings")
public class SettingsController {
    private final ResortSettingDao resortSettingDao;

    public SettingsController(ResortSettingDao resortSettingDao) {
        this.resortSettingDao = resortSettingDao;
    }

    @GetMapping({"", "/"})
    public String settingsPage(@RequestParam(value = "editId", required = false) Integer editId,
                               Model model,
                               HttpServletRequest request,
                               HttpServletResponse response) throws IOException {
        if (!ensureAdmin(request, response)) {
            return null;
        }

        ResortSetting form = new ResortSetting();
        if (editId != null) {
            ResortSetting existing = resortSettingDao.findById(editId);
            if (existing != null) {
                form = existing;
            } else {
                model.addAttribute("errorMessage", "Selected setting was not found.");
            }
        }

        model.addAttribute("settingForm", form);
        model.addAttribute("settingList", resortSettingDao.findAll());
        return "settings";
    }

    @PostMapping("/save")
    public String saveSetting(ResortSetting setting,
                              Model model,
                              HttpServletRequest request,
                              HttpServletResponse response) throws IOException {
        if (!ensureAdmin(request, response)) {
            return null;
        }

        List<String> errors = validate(setting);
        if (!errors.isEmpty()) {
            model.addAttribute("settingForm", setting);
            model.addAttribute("settingList", resortSettingDao.findAll());
            model.addAttribute("errorMessage", String.join(" ", errors));
            return "settings";
        }

        if (setting.getId() == null) {
            resortSettingDao.create(setting);
        } else {
            resortSettingDao.update(setting);
        }
        return "redirect:/settings";
    }

    @PostMapping("/delete")
    public String deleteSetting(@RequestParam("id") int id,
                                HttpServletRequest request,
                                HttpServletResponse response) throws IOException {
        if (!ensureAdmin(request, response)) {
            return null;
        }
        resortSettingDao.delete(id);
        return "redirect:/settings";
    }

    private boolean ensureAdmin(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        String username = session == null ? null : (String) session.getAttribute("username");
        if (username == null) {
            response.sendRedirect(request.getContextPath() + "/login?error=1");
            return false;
        }
        if (!"admin".equalsIgnoreCase(username)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access denied");
            return false;
        }
        return true;
    }

    private List<String> validate(ResortSetting setting) {
        List<String> errors = new ArrayList<>();
        if (isBlank(setting.getSettingKey())) {
            errors.add("Setting key is required.");
        }
        if (isBlank(setting.getSettingValue())) {
            errors.add("Setting value is required.");
        }
        if (isBlank(setting.getCategory())) {
            errors.add("Category is required.");
        }
        if (isBlank(setting.getStatus())) {
            errors.add("Status is required.");
        }
        if (isBlank(setting.getUpdatedBy())) {
            errors.add("Updated by is required.");
        }
        return errors;
    }

    private boolean isBlank(String value) {
        return value == null || value.trim().isEmpty();
    }
}
