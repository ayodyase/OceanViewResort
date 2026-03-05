package com.oceanviewresort.model;

public class StaffAuthResult {
    private final String employeeId;
    private final String name;
    private final String role;

    public StaffAuthResult(String employeeId, String name, String role) {
        this.employeeId = employeeId;
        this.name = name;
        this.role = role;
    }

    public String getEmployeeId() {
        return employeeId;
    }

    public String getName() {
        return name;
    }

    public String getRole() {
        return role;
    }
}
