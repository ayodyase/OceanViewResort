package com.oceanviewresort.model;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Repository
public class HousekeepingStatusDao {
    private final JdbcTemplate jdbcTemplate;

    public HousekeepingStatusDao(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    public List<HousekeepingStatus> findAll() {
        String sql = "SELECT id, housekeeper_name, customer_rating, hours_start, hours_end, " +
                "availability_status, assigned_room FROM housekeeping_status ORDER BY id DESC";
        return jdbcTemplate.query(sql, housekeepingRowMapper());
    }

    public HousekeepingStatus findById(int id) {
        String sql = "SELECT id, housekeeper_name, customer_rating, hours_start, hours_end, " +
                "availability_status, assigned_room FROM housekeeping_status WHERE id = ?";
        List<HousekeepingStatus> results = jdbcTemplate.query(sql, housekeepingRowMapper(), id);
        return results.isEmpty() ? null : results.get(0);
    }

    public void create(HousekeepingStatus status) {
        String sql = "INSERT INTO housekeeping_status (housekeeper_name, customer_rating, hours_start, hours_end, " +
                "availability_status, assigned_room) VALUES (?, ?, ?, ?, ?, ?)";
        jdbcTemplate.update(sql,
                trim(status.getHousekeeperName()),
                status.getCustomerRating(),
                trim(status.getHoursStart()),
                trim(status.getHoursEnd()),
                trim(status.getAvailabilityStatus()),
                trim(status.getAssignedRoom())
        );
    }

    public void update(HousekeepingStatus status) {
        String sql = "UPDATE housekeeping_status SET housekeeper_name = ?, customer_rating = ?, hours_start = ?, " +
                "hours_end = ?, availability_status = ?, assigned_room = ? WHERE id = ?";
        jdbcTemplate.update(sql,
                trim(status.getHousekeeperName()),
                status.getCustomerRating(),
                trim(status.getHoursStart()),
                trim(status.getHoursEnd()),
                trim(status.getAvailabilityStatus()),
                trim(status.getAssignedRoom()),
                status.getId()
        );
    }

    public void delete(int id) {
        jdbcTemplate.update("DELETE FROM housekeeping_status WHERE id = ?", id);
    }

    private RowMapper<HousekeepingStatus> housekeepingRowMapper() {
        return new RowMapper<HousekeepingStatus>() {
            @Override
            public HousekeepingStatus mapRow(ResultSet rs, int rowNum) throws SQLException {
                HousekeepingStatus status = new HousekeepingStatus();
                status.setId(rs.getInt("id"));
                status.setHousekeeperName(rs.getString("housekeeper_name"));
                status.setCustomerRating(rs.getDouble("customer_rating"));
                status.setHoursStart(rs.getString("hours_start"));
                status.setHoursEnd(rs.getString("hours_end"));
                status.setAvailabilityStatus(rs.getString("availability_status"));
                status.setAssignedRoom(rs.getString("assigned_room"));
                return status;
            }
        };
    }

    private String trim(String value) {
        return value == null ? "" : value.trim();
    }
}
