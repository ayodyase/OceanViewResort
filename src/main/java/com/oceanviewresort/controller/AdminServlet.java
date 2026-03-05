package com.oceanviewresort.controller;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import com.oceanviewresort.model.Booking;

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

public class AdminServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        String username = session == null ? null : (String) session.getAttribute("username");
        if (username == null) {
            response.sendRedirect(request.getContextPath() + "/login?error=1");
            return;
        }

        String dbUrl = getConfigValue(request, "DB_URL");
        String dbUser = getConfigValue(request, "DB_USER");
        String dbPassword = getConfigValue(request, "DB_PASSWORD");

        request.setAttribute("availableRoomsCount", fetchCount(dbUrl, dbUser, dbPassword,
                "SELECT COUNT(*) FROM rooms WHERE status = 'Available'"));
        request.setAttribute("bookedRoomsCount", fetchCount(dbUrl, dbUser, dbPassword,
                "SELECT COUNT(DISTINCT room_number) FROM (" +
                        "SELECT room_number FROM bookings WHERE status = 'Confirmed' " +
                        "UNION " +
                        "SELECT room_number FROM room_availability WHERE availability_status = 'Booked'" +
                        ") AS booked_rooms"));
        request.setAttribute("unavailableRoomsCount", fetchCount(dbUrl, dbUser, dbPassword,
                "SELECT COUNT(*) FROM rooms WHERE status = 'Non-Available'"));
        request.setAttribute("unbookedRoomsCount", fetchCount(dbUrl, dbUser, dbPassword,
                "SELECT GREATEST((" +
                        "SELECT COUNT(*) FROM rooms" +
                        ") - (" +
                        "SELECT COUNT(DISTINCT room_number) FROM (" +
                        "SELECT room_number FROM bookings WHERE status = 'Confirmed' " +
                        "UNION " +
                        "SELECT room_number FROM room_availability WHERE availability_status = 'Booked'" +
                        ") AS booked_rooms" +
                        ") - (" +
                        "SELECT COUNT(*) FROM rooms WHERE status = 'Non-Available'" +
                        "), 0)"));
        request.setAttribute("reservationList", fetchReservations(dbUrl, dbUser, dbPassword));

        request.getRequestDispatcher("/admin.jsp").forward(request, response);
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

    private List<Booking> fetchReservations(String dbUrl, String dbUser, String dbPassword) {
        List<Booking> reservations = new ArrayList<>();
        if (dbUrl == null || dbUrl.trim().isEmpty()) {
            return reservations;
        }
        String sql = "SELECT guest_name, room_number, check_in_date, check_out_date, status " +
                "FROM bookings ORDER BY id DESC";
        try (Connection connection = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {
            while (resultSet.next()) {
                Booking booking = new Booking();
                booking.setGuestName(resultSet.getString("guest_name"));
                booking.setRoomNumber(resultSet.getString("room_number"));
                booking.setCheckInDate(resultSet.getString("check_in_date"));
                booking.setCheckOutDate(resultSet.getString("check_out_date"));
                booking.setStatus(resultSet.getString("status"));
                reservations.add(booking);
            }
        } catch (SQLException ex) {
            return reservations;
        }
        return reservations;
    }
}
