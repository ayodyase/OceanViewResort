package com.oceanviewresort.model;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Repository
public class PaymentDao {
    private final JdbcTemplate jdbcTemplate;

    public PaymentDao(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    public List<Payment> findAll() {
        String sql = "SELECT id, booking_reference, guest_name, amount, method, payment_date, status " +
                "FROM payments ORDER BY id DESC";
        return jdbcTemplate.query(sql, paymentRowMapper());
    }

    public Payment findById(int id) {
        String sql = "SELECT id, booking_reference, guest_name, amount, method, payment_date, status " +
                "FROM payments WHERE id = ?";
        List<Payment> results = jdbcTemplate.query(sql, paymentRowMapper(), id);
        return results.isEmpty() ? null : results.get(0);
    }

    public void create(Payment payment) {
        String sql = "INSERT INTO payments (booking_reference, guest_name, amount, method, payment_date, status) " +
                "VALUES (?, ?, ?, ?, ?, ?)";
        jdbcTemplate.update(sql,
                trim(payment.getBookingReference()),
                trim(payment.getGuestName()),
                payment.getAmount(),
                trim(payment.getMethod()),
                trim(payment.getPaymentDate()),
                trim(payment.getStatus())
        );
    }

    public void update(Payment payment) {
        String sql = "UPDATE payments SET booking_reference = ?, guest_name = ?, amount = ?, method = ?, " +
                "payment_date = ?, status = ? WHERE id = ?";
        jdbcTemplate.update(sql,
                trim(payment.getBookingReference()),
                trim(payment.getGuestName()),
                payment.getAmount(),
                trim(payment.getMethod()),
                trim(payment.getPaymentDate()),
                trim(payment.getStatus()),
                payment.getId()
        );
    }

    public void delete(int id) {
        jdbcTemplate.update("DELETE FROM payments WHERE id = ?", id);
    }

    private RowMapper<Payment> paymentRowMapper() {
        return new RowMapper<Payment>() {
            @Override
            public Payment mapRow(ResultSet rs, int rowNum) throws SQLException {
                Payment payment = new Payment();
                payment.setId(rs.getInt("id"));
                payment.setBookingReference(rs.getString("booking_reference"));
                payment.setGuestName(rs.getString("guest_name"));
                payment.setAmount(rs.getDouble("amount"));
                payment.setMethod(rs.getString("method"));
                payment.setPaymentDate(rs.getString("payment_date"));
                payment.setStatus(rs.getString("status"));
                return payment;
            }
        };
    }

    private String trim(String value) {
        return value == null ? "" : value.trim();
    }
}
