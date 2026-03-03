package com.oceanviewresort.model;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Repository
public class RoomDao {
    private final JdbcTemplate jdbcTemplate;

    public RoomDao(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    public List<Room> findAll() {
        String sql = "SELECT id, room_number, room_type, capacity, status FROM rooms ORDER BY id DESC";
        return jdbcTemplate.query(sql, roomRowMapper());
    }

    public Room findById(int id) {
        String sql = "SELECT id, room_number, room_type, capacity, status FROM rooms WHERE id = ?";
        List<Room> results = jdbcTemplate.query(sql, roomRowMapper(), id);
        return results.isEmpty() ? null : results.get(0);
    }

    public void create(Room room) {
        String sql = "INSERT INTO rooms (room_number, room_type, capacity, status) VALUES (?, ?, ?, ?)";
        jdbcTemplate.update(sql,
                trim(room.getRoomNumber()),
                trim(room.getRoomType()),
                room.getCapacity(),
                trim(room.getStatus())
        );
    }

    public void update(Room room) {
        String sql = "UPDATE rooms SET room_number = ?, room_type = ?, capacity = ?, status = ? WHERE id = ?";
        jdbcTemplate.update(sql,
                trim(room.getRoomNumber()),
                trim(room.getRoomType()),
                room.getCapacity(),
                trim(room.getStatus()),
                room.getId()
        );
    }

    public void delete(int id) {
        jdbcTemplate.update("DELETE FROM rooms WHERE id = ?", id);
    }

    private RowMapper<Room> roomRowMapper() {
        return new RowMapper<Room>() {
            @Override
            public Room mapRow(ResultSet rs, int rowNum) throws SQLException {
                Room room = new Room();
                room.setId(rs.getInt("id"));
                room.setRoomNumber(rs.getString("room_number"));
                room.setRoomType(rs.getString("room_type"));
                room.setCapacity(rs.getInt("capacity"));
                room.setStatus(rs.getString("status"));
                return room;
            }
        };
    }

    private String trim(String value) {
        return value == null ? "" : value.trim();
    }
}
