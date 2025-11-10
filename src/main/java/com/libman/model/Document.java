package com.libman.model;

/**
 * Document entity class representing tblDocument table
 */
public class Document {
    private int id;
    private String name;
    private String author;
    private String status;
    private String note;
    
    // Constructors
    public Document() {
    }
    
    public Document(String name, String author, String status, String note) {
        this.name = name;
        this.author = author;
        this.status = status;
        this.note = note;
    }
    
    // Getters and Setters
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public String getName() {
        return name;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    
    public String getAuthor() {
        return author;
    }
    
    public void setAuthor(String author) {
        this.author = author;
    }
    
    public String getStatus() {
        return status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    
    public String getNote() {
        return note;
    }
    
    public void setNote(String note) {
        this.note = note;
    }
}







