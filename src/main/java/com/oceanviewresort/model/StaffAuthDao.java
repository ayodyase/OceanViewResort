package com.oceanviewresort.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class StaffAuthDao {
    private static final int EMPLOYEE_ID_MAX = 50;
    private static final int PASSWORD_MAX = 72;
    private static final Logger LOGGER = Logger.getLogger(StaffAuthDao.class.getName());

    private final String dbUrl;
    private final String dbUser;
    private final String dbPassword;

    public StaffAuthDao(String dbUrl, String dbUser, String dbPassword) {
        this.dbUrl = dbUrl;
        this.dbUser = dbUser;
        this.dbPassword = dbPassword;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException ex) {
            LOGGER.log(Level.SEVERE, "MySQL JDBC driver not found on classpath", ex);
        }
    }

    public StaffAuthResult validateStaff(String employeeId, String password) {
        if (employeeId == null || password == null) {
            return null;
        }
        if (employeeId.length() > EMPLOYEE_ID_MAX || password.length() > PASSWORD_MAX) {
            return null;
        }
        if (dbUrl == null || dbUrl.trim().isEmpty()) {
            return null;
        }

        String sql = "SELECT name, role, password_hash FROM staff WHERE employee_id = ? AND status = 'Active'";
        try (Connection connection = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, employeeId);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (!resultSet.next()) {
                    return null;
                }
                String storedHash = resultSet.getString("password_hash");
                if (!PasswordUtil.verifyPassword(password, storedHash)) {
                    return null;
                }
                String name = resultSet.getString("name");
                String role = resultSet.getString("role");
                return new StaffAuthResult(employeeId, name, role);
            }
        } catch (SQLException | IllegalArgumentException ex) {
            LOGGER.log(Level.WARNING, "Staff validation failed", ex);
            return null;
        }
    }
}
