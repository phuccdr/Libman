package com.libman.model;

import java.sql.Date;

/**
 * Member entity class representing tblMember table
 */
public class Member {
    private int id;
    private String username;
    private String password;
    private String name;
    private String gender;
    private String email;
    private String phoneNumber;
    private Date birthOfDate;
    private String address;
    
    // Constructors
    public Member() {
    }
    
    public Member(String username, String password, String name, String gender, 
                  String email, String phoneNumber, Date birthOfDate, String address) {
        this.username = username;
        this.password = password;
        this.name = name;
        this.gender = gender;
        this.email = email;
        this.phoneNumber = phoneNumber;
        this.birthOfDate = birthOfDate;
        this.address = address;
    }
    
    // Getters and Setters
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public String getUsername() {
        return username;
    }
    
    public void setUsername(String username) {
        this.username = username;
    }
    
    public String getPassword() {
        return password;
    }
    
    public void setPassword(String password) {
        this.password = password;
    }
    
    public String getName() {
        return name;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    
    public String getGender() {
        return gender;
    }
    
    public void setGender(String gender) {
        this.gender = gender;
    }
    
    public String getEmail() {
        return email;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }
    
    public String getPhoneNumber() {
        return phoneNumber;
    }
    
    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }
    
    public Date getBirthOfDate() {
        return birthOfDate;
    }
    
    public void setBirthOfDate(Date birthOfDate) {
        this.birthOfDate = birthOfDate;
    }
    
    public String getAddress() {
        return address;
    }
    
    public void setAddress(String address) {
        this.address = address;
    }
}







