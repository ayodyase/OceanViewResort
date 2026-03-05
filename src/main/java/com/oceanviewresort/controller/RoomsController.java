package com.oceanviewresort.controller;

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
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import com.oceanviewresort.security.AccessUtil;

@Controller
@RequestMapping("/rooms")
public class RoomsController {
    private final com.oceanviewresort.model.RoomDao roomDao;
    private final com.oceanviewresort.model.RoomRateDao roomRateDao;
    private final com.oceanviewresort.model.RoomAvailabilityDao roomAvailabilityDao;

    public RoomsController(com.oceanviewresort.model.RoomDao roomDao,
                           com.oceanviewresort.model.RoomRateDao roomRateDao,
                           com.oceanviewresort.model.RoomAvailabilityDao roomAvailabilityDao) {
        this.roomDao = roomDao;
        this.roomRateDao = roomRateDao;
        this.roomAvailabilityDao = roomAvailabilityDao;
    }

    @GetMapping({"", "/"})
    public String roomsPage(HttpServletRequest request, HttpServletResponse response) throws IOException {
        if (!AccessUtil.ensureLoggedIn(request, response)) {
            return null;
        }
        return "rooms";
    }

    @GetMapping("/inventory")
    public String roomInventoryPage(@RequestParam(value = "editId", required = false) Integer editId,
                                    Model model,
                                    HttpServletRequest request,
                                    HttpServletResponse response) throws IOException {
        if (!AccessUtil.ensureLoggedIn(request, response)) {
            return null;
        }
        HttpSession session = request.getSession(false);
        model.addAttribute("canEdit", AccessUtil.canEdit(session));
        com.oceanviewresort.model.Room form = new com.oceanviewresort.model.Room();
        if (editId != null) {
            com.oceanviewresort.model.Room existing = roomDao.findById(editId);
            if (existing != null) {
                form = existing;
            } else {
                model.addAttribute("errorMessage", "Selected room was not found.");
            }
        }
        model.addAttribute("roomForm", form);
        model.addAttribute("roomList", roomDao.findAll());
        return "room-inventory";
    }

    @GetMapping("/rates")
    public String roomRatesPage(@RequestParam(value = "editId", required = false) Integer editId,
                                Model model,
                                HttpServletRequest request,
                                HttpServletResponse response) throws IOException {
        if (!AccessUtil.ensureLoggedIn(request, response)) {
            return null;
        }
        HttpSession session = request.getSession(false);
        model.addAttribute("canEdit", AccessUtil.canEdit(session));
        com.oceanviewresort.model.RoomRate form = new com.oceanviewresort.model.RoomRate();
        if (editId != null) {
            com.oceanviewresort.model.RoomRate existing = roomRateDao.findById(editId);
            if (existing != null) {
                form = existing;
            } else {
                model.addAttribute("errorMessage", "Selected rate was not found.");
            }
        }
        model.addAttribute("rateForm", form);
        model.addAttribute("rateList", roomRateDao.findAll());
        return "room-rates";
    }

    @PostMapping("/rates/save")
    public String saveRoomRate(com.oceanviewresort.model.RoomRate rate,
                               Model model,
                               HttpServletRequest request,
                               HttpServletResponse response) throws IOException {
        if (!AccessUtil.ensureCanEdit(request, response)) {
            return null;
        }
        List<String> errors = validateRate(rate);
        if (!errors.isEmpty()) {
            model.addAttribute("rateForm", rate);
            model.addAttribute("rateList", roomRateDao.findAll());
            model.addAttribute("errorMessage", String.join(" ", errors));
            return "room-rates";
        }
        if (rate.getId() == null) {
            roomRateDao.create(rate);
        } else {
            roomRateDao.update(rate);
        }
        return "redirect:/rooms/rates";
    }

    @PostMapping("/rates/delete")
    public String deleteRoomRate(@RequestParam("id") int id,
                                 HttpServletRequest request,
                                 HttpServletResponse response) throws IOException {
        if (!AccessUtil.ensureCanEdit(request, response)) {
            return null;
        }
        roomRateDao.delete(id);
        return "redirect:/rooms/rates";
    }

    @GetMapping("/availability")
    public String roomAvailabilityPage(@RequestParam(value = "editId", required = false) Integer editId,
                                       Model model,
                                       HttpServletRequest request,
                                       HttpServletResponse response) throws IOException {
        if (!AccessUtil.ensureLoggedIn(request, response)) {
            return null;
        }
        HttpSession session = request.getSession(false);
        model.addAttribute("canEdit", AccessUtil.canEdit(session));
        com.oceanviewresort.model.RoomAvailability form = new com.oceanviewresort.model.RoomAvailability();
        if (editId != null) {
            com.oceanviewresort.model.RoomAvailability existing = roomAvailabilityDao.findById(editId);
            if (existing != null) {
                form = existing;
            } else {
                model.addAttribute("errorMessage", "Selected availability record was not found.");
            }
        }
        String dbUrl = getConfigValue(request, "DB_URL");
        String dbUser = getConfigValue(request, "DB_USER");
        String dbPassword = getConfigValue(request, "DB_PASSWORD");

        model.addAttribute("availableRoomsCount", fetchCount(dbUrl, dbUser, dbPassword,
                "SELECT COUNT(*) FROM rooms WHERE status = 'Available'"));
        model.addAttribute("bookedRoomsCount", fetchCount(dbUrl, dbUser, dbPassword,
                "SELECT COUNT(*) FROM bookings WHERE status = 'Confirmed'"));

        model.addAttribute("availabilityForm", form);
        model.addAttribute("availabilityList", roomAvailabilityDao.findAll());
        return "room-availability";
    }

    @PostMapping("/availability/save")
    public String saveAvailability(com.oceanviewresort.model.RoomAvailability availability,
                                   Model model,
                                   HttpServletRequest request,
                                   HttpServletResponse response) throws IOException {
        if (!AccessUtil.ensureCanEdit(request, response)) {
            return null;
        }
        List<String> errors = validateAvailability(availability);
        if (!errors.isEmpty()) {
            model.addAttribute("availabilityForm", availability);
            model.addAttribute("availabilityList", roomAvailabilityDao.findAll());
            model.addAttribute("errorMessage", String.join(" ", errors));
            return "room-availability";
        }
        if (availability.getId() == null) {
            roomAvailabilityDao.create(availability);
        } else {
            roomAvailabilityDao.update(availability);
        }
        return "redirect:/rooms/availability";
    }

    @PostMapping("/availability/delete")
    public String deleteAvailability(@RequestParam("id") int id,
                                     HttpServletRequest request,
                                     HttpServletResponse response) throws IOException {
        if (!AccessUtil.ensureCanEdit(request, response)) {
            return null;
        }
        roomAvailabilityDao.delete(id);
        return "redirect:/rooms/availability";
    }

    @PostMapping("/inventory/save")
    public String saveRoom(com.oceanviewresort.model.Room room,
                           Model model,
                           HttpServletRequest request,
                           HttpServletResponse response) throws IOException {
        if (!AccessUtil.ensureCanEdit(request, response)) {
            return null;
        }

        List<String> errors = validate(room);
        if (!errors.isEmpty()) {
            model.addAttribute("roomForm", room);
            model.addAttribute("roomList", roomDao.findAll());
            model.addAttribute("errorMessage", String.join(" ", errors));
            return "room-inventory";
        }

        if (room.getId() == null) {
            roomDao.create(room);
        } else {
            roomDao.update(room);
        }
        return "redirect:/rooms/inventory";
    }

    @PostMapping("/inventory/delete")
    public String deleteRoom(@RequestParam("id") int id,
                             HttpServletRequest request,
                             HttpServletResponse response) throws IOException {
        if (!AccessUtil.ensureCanEdit(request, response)) {
            return null;
        }
        roomDao.delete(id);
        return "redirect:/rooms/inventory";
    }

    private List<String> validate(com.oceanviewresort.model.Room room) {
        List<String> errors = new ArrayList<>();
        if (isBlank(room.getRoomNumber())) {
            errors.add("Room number is required.");
        }
        if (isBlank(room.getRoomType())) {
            errors.add("Room type is required.");
        }
        if (room.getCapacity() == null || room.getCapacity() < 1) {
            errors.add("Capacity must be at least 1.");
        }
        if (isBlank(room.getStatus())) {
            errors.add("Status is required.");
        }
        return errors;
    }

    private List<String> validateRate(com.oceanviewresort.model.RoomRate rate) {
        List<String> errors = new ArrayList<>();
        if (isBlank(rate.getRoomType())) {
            errors.add("Room type is required.");
        }
        if (isBlank(rate.getSeason())) {
            errors.add("Season is required.");
        }
        if (rate.getNightlyRate() == null || rate.getNightlyRate() <= 0) {
            errors.add("Nightly rate must be greater than 0.");
        }
        if (isBlank(rate.getStatus())) {
            errors.add("Status is required.");
        }
        return errors;
    }

    private List<String> validateAvailability(com.oceanviewresort.model.RoomAvailability availability) {
        List<String> errors = new ArrayList<>();
        if (isBlank(availability.getRoomNumber())) {
            errors.add("Room number is required.");
        }
        if (isBlank(availability.getAvailabilityStatus())) {
            errors.add("Availability status is required.");
        }
        return errors;
    }

    private boolean isBlank(String value) {
        return value == null || value.trim().isEmpty();
    }

    private String getConfigValue(HttpServletRequest request, String key) {
        String envValue = System.getenv(key);
        if (envValue != null && !envValue.trim().isEmpty()) {
            return envValue.trim();
        }
        String ctxValue = request.getServletContext().getInitParameter(key);
        return ctxValue == null ? "" : ctxValue.trim();
    }

    private int fetchCount(String dbUrl, String dbUser, String dbPassword, String sql) {
        if (dbUrl == null || dbUrl.trim().isEmpty()) {
            return 0;
        }
        try (Connection connection = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {
            if (resultSet.next()) {
                return resultSet.getInt(1);
            }
        } catch (SQLException ex) {
            return 0;
        }
        return 0;
    }
}
