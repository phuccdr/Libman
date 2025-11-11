package com.libman.model;

import java.sql.Date;

/**
 * Reader entity class representing tblReader table
 * Reader is a specialized Member
 */
public class Reader extends Member {
    private int rating;
    private int memberId;
    
    // Constructors
    public Reader() {
        super();
    }
    
    public Reader(int memberId, String username, String password, String name, 
                  String gender, String email, String phoneNumber, 
                  Date birthOfDate, String address, int rating) {
        super(username, password, name, gender, email, phoneNumber, birthOfDate, address);
        this.memberId = memberId;
        this.rating = rating;
    }
    
    // Getters and Setters
    public int getRating() {
        return rating;
    }
    
    public void setRating(int rating) {
        this.rating = rating;
    }
    
    public int getMemberId() {
        return memberId;
    }
    
    public void setMemberId(int memberId) {
        this.memberId = memberId;
    }
}









