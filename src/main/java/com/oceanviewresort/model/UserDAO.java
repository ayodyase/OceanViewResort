package com.oceanviewresort.model;

import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Base64;
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
                return verifyPassword(password, storedHash);
            }
        } catch (SQLException | IllegalArgumentException ex) {
            LOGGER.log(Level.WARNING, "User validation failed", ex);
            return false;
        }
    }

    private boolean verifyPassword(String password, String stored) {
        if (stored == null || stored.trim().isEmpty()) {
            return false;
        }
        String[] parts = stored.split(":");
        if (parts.length != 3) {
            return false;
        }

        int iterations = Integer.parseInt(parts[0]);
        byte[] salt = Base64.getDecoder().decode(parts[1]);
        byte[] expected = Base64.getDecoder().decode(parts[2]);
        byte[] actual = pbkdf2(password.toCharArray(), salt, iterations, expected.length * 8);
        return MessageDigest.isEqual(expected, actual);
    }

    private byte[] pbkdf2(char[] password, byte[] salt, int iterations, int keyLength) {
        try {
            PBEKeySpec spec = new PBEKeySpec(password, salt, iterations, keyLength);
            SecretKeyFactory factory = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA256");
            return factory.generateSecret(spec).getEncoded();
        } catch (NoSuchAlgorithmException | InvalidKeySpecException ex) {
            throw new IllegalArgumentException("Password verification failed", ex);
        }
    }
}
