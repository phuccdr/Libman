package com.libman.model;

import java.sql.Date;

/**
 * Manager entity class representing tblManager table
 * Manager is a specialized Staff
 */
public class Manager extends Member {
    private String role;
    private String position;
    private int memberId;
    
    // Constructors
    public Manager() {
        super();
    }
    
    public Manager(int memberId, String username, String password, String name, 
                   String gender, String email, String phoneNumber, 
                   Date birthOfDate, String address, String position, String role) {
        super(username, password, name, gender, email, phoneNumber, birthOfDate, address);
        this.memberId = memberId;
        this.position = position;
        this.role = role;
    }
    
    // Getters and Setters
    public String getRole() {
        return role;
    }
    
    public void setRole(String role) {
        this.role = role;
    }
    
    public String getPosition() {
        return position;
    }
    
    public void setPosition(String position) {
        this.position = position;
    }
    
    public int getMemberId() {
        return memberId;
    }
    
    public void setMemberId(int memberId) {
        this.memberId = memberId;
    }
}







