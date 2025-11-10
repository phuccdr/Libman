package com.libman.model;

import java.sql.Date;

/**
 * LibraryCard entity class representing tblLibraryCard table
 */
public class LibraryCard {
    private int id;
    private Date expirationDate;
    private String note;
    private String image;
    private int readerId;
    
    // For display purposes
    private String readerName;
    
    // Constructors
    public LibraryCard() {
    }
    
    public LibraryCard(Date expirationDate, String note, String image, int readerId) {
        this.expirationDate = expirationDate;
        this.note = note;
        this.image = image;
        this.readerId = readerId;
    }
    
    // Getters and Setters
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public Date getExpirationDate() {
        return expirationDate;
    }
    
    public void setExpirationDate(Date expirationDate) {
        this.expirationDate = expirationDate;
    }
    
    public String getNote() {
        return note;
    }
    
    public void setNote(String note) {
        this.note = note;
    }
    
    public String getImage() {
        return image;
    }
    
    public void setImage(String image) {
        this.image = image;
    }
    
    public int getReaderId() {
        return readerId;
    }
    
    public void setReaderId(int readerId) {
        this.readerId = readerId;
    }
    
    public String getReaderName() {
        return readerName;
    }
    
    public void setReaderName(String readerName) {
        this.readerName = readerName;
    }
}




