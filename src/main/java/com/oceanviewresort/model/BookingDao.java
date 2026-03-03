package com.oceanviewresort.model;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Repository
public class BookingDao {
    private final JdbcTemplate jdbcTemplate;

    public BookingDao(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    public List<Booking> findAll() {
        String sql = "SELECT id, guest_name, guest_email, room_number, check_in_date, check_out_date, status " +
                "FROM bookings ORDER BY id DESC";
        return jdbcTemplate.query(sql, bookingRowMapper());
    }

    public Booking findById(int id) {
        String sql = "SELECT id, guest_name, guest_email, room_number, check_in_date, check_out_date, status " +
                "FROM bookings WHERE id = ?";
        List<Booking> results = jdbcTemplate.query(sql, bookingRowMapper(), id);
        return results.isEmpty() ? null : results.get(0);
    }

    public void create(Booking booking) {
        String sql = "INSERT INTO bookings (guest_name, guest_email, room_number, check_in_date, check_out_date, status) " +
                "VALUES (?, ?, ?, ?, ?, ?)";
        jdbcTemplate.update(sql,
                trim(booking.getGuestName()),
                trim(booking.getGuestEmail()),
                trim(booking.getRoomNumber()),
                trim(booking.getCheckInDate()),
                trim(booking.getCheckOutDate()),
                trim(booking.getStatus())
        );
    }

    public void update(Booking booking) {
        String sql = "UPDATE bookings SET guest_name = ?, guest_email = ?, room_number = ?, check_in_date = ?, " +
                "check_out_date = ?, status = ? WHERE id = ?";
        jdbcTemplate.update(sql,
                trim(booking.getGuestName()),
                trim(booking.getGuestEmail()),
                trim(booking.getRoomNumber()),
                trim(booking.getCheckInDate()),
                trim(booking.getCheckOutDate()),
                trim(booking.getStatus()),
                booking.getId()
        );
    }

    public void delete(int id) {
        jdbcTemplate.update("DELETE FROM bookings WHERE id = ?", id);
    }

    private RowMapper<Booking> bookingRowMapper() {
        return new RowMapper<Booking>() {
            @Override
            public Booking mapRow(ResultSet rs, int rowNum) throws SQLException {
                Booking booking = new Booking();
                booking.setId(rs.getInt("id"));
                booking.setGuestName(rs.getString("guest_name"));
                booking.setGuestEmail(rs.getString("guest_email"));
                booking.setRoomNumber(rs.getString("room_number"));
                booking.setCheckInDate(rs.getString("check_in_date"));
                booking.setCheckOutDate(rs.getString("check_out_date"));
                booking.setStatus(rs.getString("status"));
                return booking;
            }
        };
    }

    private String trim(String value) {
        return value == null ? "" : value.trim();
    }
}
