package com.oceanviewresort.model;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Repository
public class ReportDao {
    private final JdbcTemplate jdbcTemplate;

    public ReportDao(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    public List<Report> findAll() {
        String sql = "SELECT id, report_name, report_type, period_start, period_end, status, generated_by " +
                "FROM reports ORDER BY id DESC";
        return jdbcTemplate.query(sql, reportRowMapper());
    }

    public Report findById(int id) {
        String sql = "SELECT id, report_name, report_type, period_start, period_end, status, generated_by " +
                "FROM reports WHERE id = ?";
        List<Report> results = jdbcTemplate.query(sql, reportRowMapper(), id);
        return results.isEmpty() ? null : results.get(0);
    }

    public void create(Report report) {
        String sql = "INSERT INTO reports (report_name, report_type, period_start, period_end, status, generated_by) " +
                "VALUES (?, ?, ?, ?, ?, ?)";
        jdbcTemplate.update(sql,
                trim(report.getReportName()),
                trim(report.getReportType()),
                trim(report.getPeriodStart()),
                trim(report.getPeriodEnd()),
                trim(report.getStatus()),
                trim(report.getGeneratedBy())
        );
    }

    public void update(Report report) {
        String sql = "UPDATE reports SET report_name = ?, report_type = ?, period_start = ?, period_end = ?, " +
                "status = ?, generated_by = ? WHERE id = ?";
        jdbcTemplate.update(sql,
                trim(report.getReportName()),
                trim(report.getReportType()),
                trim(report.getPeriodStart()),
                trim(report.getPeriodEnd()),
                trim(report.getStatus()),
                trim(report.getGeneratedBy()),
                report.getId()
        );
    }

    public void delete(int id) {
        jdbcTemplate.update("DELETE FROM reports WHERE id = ?", id);
    }

    private RowMapper<Report> reportRowMapper() {
        return new RowMapper<Report>() {
            @Override
            public Report mapRow(ResultSet rs, int rowNum) throws SQLException {
                Report report = new Report();
                report.setId(rs.getInt("id"));
                report.setReportName(rs.getString("report_name"));
                report.setReportType(rs.getString("report_type"));
                report.setPeriodStart(rs.getString("period_start"));
                report.setPeriodEnd(rs.getString("period_end"));
                report.setStatus(rs.getString("status"));
                report.setGeneratedBy(rs.getString("generated_by"));
                return report;
            }
        };
    }

    private String trim(String value) {
        return value == null ? "" : value.trim();
    }
}
