package com.oceanviewresort.controller;

import com.oceanviewresort.model.Booking;
import com.oceanviewresort.model.BookingDao;
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

@Controller
@RequestMapping("/bookings")
public class BookingsController {
    private final BookingDao bookingDao;

    public BookingsController(BookingDao bookingDao) {
        this.bookingDao = bookingDao;
    }

    @GetMapping({"", "/"})
    public String bookingsPage(@RequestParam(value = "editId", required = false) Integer editId,
                               Model model,
                               HttpServletRequest request,
                               HttpServletResponse response) throws IOException {
        if (!AccessUtil.ensureLoggedIn(request, response)) {
            return null;
        }

        HttpSession session = request.getSession(false);
        model.addAttribute("canEdit", AccessUtil.canEdit(session));

        Booking form = new Booking();
        if (editId != null) {
            Booking existing = bookingDao.findById(editId);
            if (existing != null) {
                form = existing;
            } else {
                model.addAttribute("errorMessage", "Selected booking was not found.");
            }
        }

        model.addAttribute("bookingForm", form);
        model.addAttribute("bookingList", bookingDao.findAll());
        return "bookings";
    }

    @PostMapping("/save")
    public String saveBooking(Booking booking,
                              Model model,
                              HttpServletRequest request,
                              HttpServletResponse response) throws IOException {
        if (!AccessUtil.ensureCanEdit(request, response)) {
            return null;
        }

        List<String> errors = validate(booking);
        if (!errors.isEmpty()) {
            model.addAttribute("bookingForm", booking);
            model.addAttribute("bookingList", bookingDao.findAll());
            model.addAttribute("errorMessage", String.join(" ", errors));
            return "bookings";
        }

        if (booking.getId() == null) {
            bookingDao.create(booking);
        } else {
            bookingDao.update(booking);
        }
        return "redirect:/bookings";
    }

    @PostMapping("/delete")
    public String deleteBooking(@RequestParam("id") int id,
                                HttpServletRequest request,
                                HttpServletResponse response) throws IOException {
        if (!AccessUtil.ensureCanEdit(request, response)) {
            return null;
        }
        bookingDao.delete(id);
        return "redirect:/bookings";
    }

    private List<String> validate(Booking booking) {
        List<String> errors = new ArrayList<>();
        if (isBlank(booking.getGuestName())) {
            errors.add("Guest name is required.");
        }
        if (isBlank(booking.getGuestEmail())) {
            errors.add("Guest email is required.");
        }
        if (isBlank(booking.getRoomNumber())) {
            errors.add("Room number is required.");
        }
        if (isBlank(booking.getCheckInDate()) || isBlank(booking.getCheckOutDate())) {
            errors.add("Check-in and check-out dates are required.");
        }
        if (isBlank(booking.getStatus())) {
            errors.add("Status is required.");
        }
        return errors;
    }

    private boolean isBlank(String value) {
        return value == null || value.trim().isEmpty();
    }
}
