package com.oceanviewresort.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class UserDAO {
    private static final int USERNAME_MAX = 100;
    private static final int PASSWORD_MAX = 72;
    private static final Logger LOGGER = Logger.getLogger(UserDAO.class.getName());

    private final String dbUrl;
    private final String dbUser;
    private final String dbPassword;

    public UserDAO(String dbUrl, String dbUser, String dbPassword) {
        this.dbUrl = dbUrl;
        this.dbUser = dbUser;
        this.dbPassword = dbPassword;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException ex) {
            LOGGER.log(Level.SEVERE, "MySQL JDBC driver not found on classpath", ex);
        }
    }

    public boolean validateUser(String username, String password) {
        if (username == null || password == null) {
            return false;
        }
        if (username.length() > USERNAME_MAX || password.length() > PASSWORD_MAX) {
            return false;
        }
        if (dbUrl == null || dbUrl.trim().isEmpty()) {
            return false;
        }

        String sql = "SELECT password_hash FROM users WHERE username = ? AND active = 1";
        try (Connection connection = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, username);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (!resultSet.next()) {
                    return false;
                }
                String storedHash = resultSet.getString("password_hash");
                return PasswordUtil.verifyPassword(password, storedHash);
            }
        } catch (SQLException | IllegalArgumentException ex) {
            LOGGER.log(Level.WARNING, "User validation failed", ex);
            return false;
        }
    }

    public void updatePasswordHash(String username, String passwordHash) {
        if (username == null || username.trim().isEmpty() || passwordHash == null || passwordHash.trim().isEmpty()) {
            return;
        }
        if (dbUrl == null || dbUrl.trim().isEmpty()) {
            return;
        }
        String sql = "UPDATE users SET password_hash = ? WHERE username = ?";
        try (Connection connection = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, passwordHash);
            statement.setString(2, username);
            statement.executeUpdate();
        } catch (SQLException ex) {
            LOGGER.log(Level.WARNING, "Failed to update user password hash", ex);
        }
    }
}
