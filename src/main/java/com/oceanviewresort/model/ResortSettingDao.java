package com.oceanviewresort.model;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Repository
public class ResortSettingDao {
    private final JdbcTemplate jdbcTemplate;

    public ResortSettingDao(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    public List<ResortSetting> findAll() {
        String sql = "SELECT id, setting_key, setting_value, category, status, updated_by " +
                "FROM resort_settings ORDER BY id DESC";
        return jdbcTemplate.query(sql, settingRowMapper());
    }

    public ResortSetting findById(int id) {
        String sql = "SELECT id, setting_key, setting_value, category, status, updated_by " +
                "FROM resort_settings WHERE id = ?";
        List<ResortSetting> results = jdbcTemplate.query(sql, settingRowMapper(), id);
        return results.isEmpty() ? null : results.get(0);
    }

    public void create(ResortSetting setting) {
        String sql = "INSERT INTO resort_settings (setting_key, setting_value, category, status, updated_by) " +
                "VALUES (?, ?, ?, ?, ?)";
        jdbcTemplate.update(sql,
                trim(setting.getSettingKey()),
                trim(setting.getSettingValue()),
                trim(setting.getCategory()),
                trim(setting.getStatus()),
                trim(setting.getUpdatedBy())
        );
    }

    public void update(ResortSetting setting) {
        String sql = "UPDATE resort_settings SET setting_key = ?, setting_value = ?, category = ?, status = ?, " +
                "updated_by = ? WHERE id = ?";
        jdbcTemplate.update(sql,
                trim(setting.getSettingKey()),
                trim(setting.getSettingValue()),
                trim(setting.getCategory()),
                trim(setting.getStatus()),
                trim(setting.getUpdatedBy()),
                setting.getId()
        );
    }

    public void delete(int id) {
        jdbcTemplate.update("DELETE FROM resort_settings WHERE id = ?", id);
    }

    private RowMapper<ResortSetting> settingRowMapper() {
        return new RowMapper<ResortSetting>() {
            @Override
            public ResortSetting mapRow(ResultSet rs, int rowNum) throws SQLException {
                ResortSetting setting = new ResortSetting();
                setting.setId(rs.getInt("id"));
                setting.setSettingKey(rs.getString("setting_key"));
                setting.setSettingValue(rs.getString("setting_value"));
                setting.setCategory(rs.getString("category"));
                setting.setStatus(rs.getString("status"));
                setting.setUpdatedBy(rs.getString("updated_by"));
                return setting;
            }
        };
    }

    private String trim(String value) {
        return value == null ? "" : value.trim();
    }
}
