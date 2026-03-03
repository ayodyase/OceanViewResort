package com.oceanviewresort.model;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Repository
public class RoomRateDao {
    private final JdbcTemplate jdbcTemplate;

    public RoomRateDao(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    public List<RoomRate> findAll() {
        String sql = "SELECT id, room_type, season, nightly_rate, package_name, status " +
                "FROM room_rates ORDER BY id DESC";
        return jdbcTemplate.query(sql, rateRowMapper());
    }

    public RoomRate findById(int id) {
        String sql = "SELECT id, room_type, season, nightly_rate, package_name, status " +
                "FROM room_rates WHERE id = ?";
        List<RoomRate> results = jdbcTemplate.query(sql, rateRowMapper(), id);
        return results.isEmpty() ? null : results.get(0);
    }

    public void create(RoomRate rate) {
        String sql = "INSERT INTO room_rates (room_type, season, nightly_rate, package_name, status) " +
                "VALUES (?, ?, ?, ?, ?)";
        jdbcTemplate.update(sql,
                trim(rate.getRoomType()),
                trim(rate.getSeason()),
                rate.getNightlyRate(),
                trim(rate.getPackageName()),
                trim(rate.getStatus())
        );
    }

    public void update(RoomRate rate) {
        String sql = "UPDATE room_rates SET room_type = ?, season = ?, nightly_rate = ?, package_name = ?, status = ? " +
                "WHERE id = ?";
        jdbcTemplate.update(sql,
                trim(rate.getRoomType()),
                trim(rate.getSeason()),
                rate.getNightlyRate(),
                trim(rate.getPackageName()),
                trim(rate.getStatus()),
                rate.getId()
        );
    }

    public void delete(int id) {
        jdbcTemplate.update("DELETE FROM room_rates WHERE id = ?", id);
    }

    private RowMapper<RoomRate> rateRowMapper() {
        return new RowMapper<RoomRate>() {
            @Override
            public RoomRate mapRow(ResultSet rs, int rowNum) throws SQLException {
                RoomRate rate = new RoomRate();
                rate.setId(rs.getInt("id"));
                rate.setRoomType(rs.getString("room_type"));
                rate.setSeason(rs.getString("season"));
                rate.setNightlyRate(rs.getDouble("nightly_rate"));
                rate.setPackageName(rs.getString("package_name"));
                rate.setStatus(rs.getString("status"));
                return rate;
            }
        };
    }

    private String trim(String value) {
        return value == null ? "" : value.trim();
    }
}
