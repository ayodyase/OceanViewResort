package com.oceanviewresort.model;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Repository
public class StaffDao {
    private final JdbcTemplate jdbcTemplate;

    public StaffDao(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    public List<StaffMember> findAll() {
        String sql = "SELECT id, name, email, gender, nic, employee_id, role, hours_start, hours_end, status " +
                "FROM staff ORDER BY id DESC";
        return jdbcTemplate.query(sql, staffRowMapper());
    }

    public StaffMember findById(int id) {
        String sql = "SELECT id, name, email, gender, nic, employee_id, role, hours_start, hours_end, status " +
                "FROM staff WHERE id = ?";
        List<StaffMember> results = jdbcTemplate.query(sql, staffRowMapper(), id);
        return results.isEmpty() ? null : results.get(0);
    }

    public StaffMember findByEmployeeId(String employeeId) {
        String sql = "SELECT id, name, email, gender, nic, employee_id, role, hours_start, hours_end, status " +
                "FROM staff WHERE employee_id = ?";
        List<StaffMember> results = jdbcTemplate.query(sql, staffRowMapper(), employeeId);
        return results.isEmpty() ? null : results.get(0);
    }

    public void create(StaffMember staff) {
        String sql = "INSERT INTO staff (name, email, gender, nic, employee_id, role, hours_start, hours_end, status, password_hash) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        String passwordHash = PasswordUtil.hashPassword(staff.getPassword());
        jdbcTemplate.update(sql,
                trim(staff.getName()),
                trim(staff.getEmail()),
                trim(staff.getGender()),
                trim(staff.getNic()),
                trim(staff.getEmployeeId()),
                trim(staff.getRole()),
                trim(staff.getHoursStart()),
                trim(staff.getHoursEnd()),
                trim(staff.getStatus()),
                passwordHash
        );
    }

    public void update(StaffMember staff) {
        if (hasText(staff.getPassword())) {
            String sql = "UPDATE staff SET name = ?, email = ?, gender = ?, nic = ?, employee_id = ?, role = ?, " +
                    "hours_start = ?, hours_end = ?, status = ?, password_hash = ? WHERE id = ?";
            String passwordHash = PasswordUtil.hashPassword(staff.getPassword());
            jdbcTemplate.update(sql,
                    trim(staff.getName()),
                    trim(staff.getEmail()),
                    trim(staff.getGender()),
                    trim(staff.getNic()),
                    trim(staff.getEmployeeId()),
                    trim(staff.getRole()),
                    trim(staff.getHoursStart()),
                    trim(staff.getHoursEnd()),
                    trim(staff.getStatus()),
                    passwordHash,
                    staff.getId()
            );
            return;
        }

        String sql = "UPDATE staff SET name = ?, email = ?, gender = ?, nic = ?, employee_id = ?, role = ?, " +
                "hours_start = ?, hours_end = ?, status = ? WHERE id = ?";
        jdbcTemplate.update(sql,
                trim(staff.getName()),
                trim(staff.getEmail()),
                trim(staff.getGender()),
                trim(staff.getNic()),
                trim(staff.getEmployeeId()),
                trim(staff.getRole()),
                trim(staff.getHoursStart()),
                trim(staff.getHoursEnd()),
                trim(staff.getStatus()),
                staff.getId()
        );
    }

    public void delete(int id) {
        jdbcTemplate.update("DELETE FROM staff WHERE id = ?", id);
    }

    public void updatePasswordHash(int id, String passwordHash) {
        String sql = "UPDATE staff SET password_hash = ? WHERE id = ?";
        jdbcTemplate.update(sql, passwordHash, id);
    }

    private RowMapper<StaffMember> staffRowMapper() {
        return new RowMapper<StaffMember>() {
            @Override
            public StaffMember mapRow(ResultSet rs, int rowNum) throws SQLException {
                StaffMember staff = new StaffMember();
                staff.setId(rs.getInt("id"));
                staff.setName(rs.getString("name"));
                staff.setEmail(rs.getString("email"));
                staff.setGender(rs.getString("gender"));
                staff.setNic(rs.getString("nic"));
                staff.setEmployeeId(rs.getString("employee_id"));
                staff.setRole(rs.getString("role"));
                staff.setHoursStart(rs.getString("hours_start"));
                staff.setHoursEnd(rs.getString("hours_end"));
                staff.setStatus(rs.getString("status"));
                return staff;
            }
        };
    }

    private String trim(String value) {
        return value == null ? "" : value.trim();
    }

    private boolean hasText(String value) {
        return value != null && !value.trim().isEmpty();
    }
}
