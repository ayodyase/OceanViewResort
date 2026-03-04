package com.oceanviewresort.model;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Repository
public class RoomAvailabilityDao {
    private final JdbcTemplate jdbcTemplate;

    public RoomAvailabilityDao(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    public List<RoomAvailability> findAll() {
        String sql = "SELECT id, room_number, availability_status, notes " +
                "FROM room_availability ORDER BY id DESC";
        return jdbcTemplate.query(sql, availabilityRowMapper());
    }

    public RoomAvailability findById(int id) {
        String sql = "SELECT id, room_number, availability_status, notes " +
                "FROM room_availability WHERE id = ?";
        List<RoomAvailability> results = jdbcTemplate.query(sql, availabilityRowMapper(), id);
        return results.isEmpty() ? null : results.get(0);
    }

    public void create(RoomAvailability availability) {
        String sql = "INSERT INTO room_availability (room_number, availability_status, notes) " +
                "VALUES (?, ?, ?)";
        jdbcTemplate.update(sql,
                trim(availability.getRoomNumber()),
                trim(availability.getAvailabilityStatus()),
                trim(availability.getNotes())
        );
    }

    public void update(RoomAvailability availability) {
        String sql = "UPDATE room_availability SET room_number = ?, availability_status = ?, " +
                "notes = ? WHERE id = ?";
        jdbcTemplate.update(sql,
                trim(availability.getRoomNumber()),
                trim(availability.getAvailabilityStatus()),
                trim(availability.getNotes()),
                availability.getId()
        );
    }

    public void delete(int id) {
        jdbcTemplate.update("DELETE FROM room_availability WHERE id = ?", id);
    }

    private RowMapper<RoomAvailability> availabilityRowMapper() {
        return new RowMapper<RoomAvailability>() {
            @Override
            public RoomAvailability mapRow(ResultSet rs, int rowNum) throws SQLException {
                RoomAvailability availability = new RoomAvailability();
                availability.setId(rs.getInt("id"));
                availability.setRoomNumber(rs.getString("room_number"));
                availability.setAvailabilityStatus(rs.getString("availability_status"));
                availability.setNotes(rs.getString("notes"));
                return availability;
            }
        };
    }

    private String trim(String value) {
        return value == null ? "" : value.trim();
    }
}
