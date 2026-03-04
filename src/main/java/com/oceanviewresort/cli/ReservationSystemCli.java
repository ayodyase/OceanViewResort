package com.oceanviewresort.cli;

import com.oceanviewresort.model.UserDAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.HashMap;
import java.util.Map;
import java.util.Scanner;

public class ReservationSystemCli {
    private static final String DEFAULT_DB_URL =
            "jdbc:mysql://localhost:3306/ocean_view_resort?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
    private static final String DEFAULT_DB_USER = "root";
    private static final String DEFAULT_DB_PASSWORD = "";

    private static final Map<String, Double> ROOM_RATES = new HashMap<>();

    static {
        ROOM_RATES.put("Standard", 100.0);
        ROOM_RATES.put("Deluxe", 150.0);
        ROOM_RATES.put("Family", 200.0);
    }

    private final String dbUrl;
    private final String dbUser;
    private final String dbPassword;
    private final Scanner scanner;

    public ReservationSystemCli(String dbUrl, String dbUser, String dbPassword) {
        this.dbUrl = dbUrl;
        this.dbUser = dbUser;
        this.dbPassword = dbPassword;
        this.scanner = new Scanner(System.in);
    }

    public static void main(String[] args) {
        String dbUrl = readEnv("DB_URL", DEFAULT_DB_URL);
        String dbUser = readEnv("DB_USER", DEFAULT_DB_USER);
        String dbPassword = readEnv("DB_PASSWORD", DEFAULT_DB_PASSWORD);
        ReservationSystemCli app = new ReservationSystemCli(dbUrl, dbUser, dbPassword);
        app.run();
    }

    private static String readEnv(String key, String fallback) {
        String value = System.getenv(key);
        return value == null || value.trim().isEmpty() ? fallback : value.trim();
    }

    public void run() {
        System.out.println("Ocean View Resort - Reservation System");
        if (!login()) {
            return;
        }

        while (true) {
            System.out.println("\nMain Menu");
            System.out.println("1. Add New Reservation");
            System.out.println("2. Display Reservation Details");
            System.out.println("3. Calculate and Print Bill");
            System.out.println("4. Help");
            System.out.println("5. Exit");
            System.out.print("Choose an option: ");
            String choice = scanner.nextLine().trim();

            switch (choice) {
                case "1":
                    addReservation();
                    break;
                case "2":
                    displayReservation();
                    break;
                case "3":
                    calculateBill();
                    break;
                case "4":
                    printHelp();
                    break;
                case "5":
                    System.out.println("Exiting system. Goodbye.");
                    return;
                default:
                    System.out.println("Invalid option.");
            }
        }
    }

    private boolean login() {
        UserDAO userDAO = new UserDAO(dbUrl, dbUser, dbPassword);
        for (int attempts = 0; attempts < 3; attempts++) {
            System.out.print("Username: ");
            String username = scanner.nextLine().trim();
            System.out.print("Password: ");
            String password = scanner.nextLine().trim();
            if (userDAO.validateUser(username, password)) {
                System.out.println("Login successful.");
                return true;
            }
            System.out.println("Invalid username or password.");
        }
        System.out.println("Too many failed attempts.");
        return false;
    }

    private void addReservation() {
        System.out.println("\nAdd New Reservation");
        String reservationNumber = prompt("Reservation number");
        String guestName = prompt("Guest name");
        String address = prompt("Address");
        String contactNumber = prompt("Contact number");
        String roomType = prompt("Room type (Standard/Deluxe/Family)");
        String checkIn = prompt("Check-in date (YYYY-MM-DD)");
        String checkOut = prompt("Check-out date (YYYY-MM-DD)");

        String sql = "INSERT INTO reservations (reservation_number, guest_name, address, contact_number, " +
                "room_type, check_in_date, check_out_date) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection connection = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, reservationNumber);
            statement.setString(2, guestName);
            statement.setString(3, address);
            statement.setString(4, contactNumber);
            statement.setString(5, roomType);
            statement.setString(6, checkIn);
            statement.setString(7, checkOut);
            statement.executeUpdate();
            System.out.println("Reservation saved.");
        } catch (SQLException ex) {
            System.out.println("Failed to save reservation: " + ex.getMessage());
        }
    }

    private void displayReservation() {
        System.out.println("\nDisplay Reservation Details");
        String reservationNumber = prompt("Reservation number");
        String sql = "SELECT reservation_number, guest_name, address, contact_number, room_type, " +
                "check_in_date, check_out_date FROM reservations WHERE reservation_number = ?";
        try (Connection connection = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, reservationNumber);
            try (ResultSet rs = statement.executeQuery()) {
                if (rs.next()) {
                    System.out.println("Reservation Number: " + rs.getString("reservation_number"));
                    System.out.println("Guest Name: " + rs.getString("guest_name"));
                    System.out.println("Address: " + rs.getString("address"));
                    System.out.println("Contact Number: " + rs.getString("contact_number"));
                    System.out.println("Room Type: " + rs.getString("room_type"));
                    System.out.println("Check-in: " + rs.getString("check_in_date"));
                    System.out.println("Check-out: " + rs.getString("check_out_date"));
                } else {
                    System.out.println("Reservation not found.");
                }
            }
        } catch (SQLException ex) {
            System.out.println("Failed to retrieve reservation: " + ex.getMessage());
        }
    }

    private void calculateBill() {
        System.out.println("\nCalculate and Print Bill");
        String reservationNumber = prompt("Reservation number");
        String sql = "SELECT guest_name, room_type, check_in_date, check_out_date FROM reservations " +
                "WHERE reservation_number = ?";
        try (Connection connection = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, reservationNumber);
            try (ResultSet rs = statement.executeQuery()) {
                if (!rs.next()) {
                    System.out.println("Reservation not found.");
                    return;
                }
                String guestName = rs.getString("guest_name");
                String roomType = rs.getString("room_type");
                LocalDate checkIn = LocalDate.parse(rs.getString("check_in_date"));
                LocalDate checkOut = LocalDate.parse(rs.getString("check_out_date"));
                long nights = ChronoUnit.DAYS.between(checkIn, checkOut);
                if (nights < 1) {
                    System.out.println("Invalid dates. Check-out must be after check-in.");
                    return;
                }
                double rate = ROOM_RATES.getOrDefault(roomType, 0.0);
                double total = rate * nights;
                System.out.println("Guest: " + guestName);
                System.out.println("Room Type: " + roomType);
                System.out.println("Nights: " + nights);
                System.out.println("Rate per night: " + rate);
                System.out.println("Total bill: " + total);
            }
        } catch (SQLException ex) {
            System.out.println("Failed to calculate bill: " + ex.getMessage());
        }
    }

    private void printHelp() {
        System.out.println("\nHelp");
        System.out.println("1. Login using your username and password.");
        System.out.println("2. Use Add New Reservation to record guest bookings.");
        System.out.println("3. Display Reservation Details to view a booking by reservation number.");
        System.out.println("4. Calculate and Print Bill to compute total charges based on nights and room rate.");
        System.out.println("5. Exit to close the system safely.");
    }

    private String prompt(String label) {
        System.out.print(label + ": ");
        return scanner.nextLine().trim();
    }
}
