package com.libman.model;

import java.sql.Date;
import java.util.List;

/**
 * Invoice entity class representing tblInvoice table
 */
public class Invoice {
    private int id;
    private int totalPrice;
    private Date createDate;
    private int managerId;
    private int libraryStaffId;
    
    // For display purposes
    private String managerName;
    private String staffName;
    private Supplier supplier;
    private List<ImportDocument> documentImports;
    
    // Constructors
    public Invoice() {
    }
    
    public Invoice(int totalPrice, Date createDate, int managerId, int libraryStaffId) {
        this.totalPrice = totalPrice;
        this.createDate = createDate;
        this.managerId = managerId;
        this.libraryStaffId = libraryStaffId;
    }
    
    // Getters and Setters
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public int getTotalPrice() {
        return totalPrice;
    }
    
    public void setTotalPrice(int totalPrice) {
        this.totalPrice = totalPrice;
    }
    
    public Date getCreateDate() {
        return createDate;
    }
    
    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }
    
    public int getManagerId() {
        return managerId;
    }
    
    public void setManagerId(int managerId) {
        this.managerId = managerId;
    }
    
    public int getLibraryStaffId() {
        return libraryStaffId;
    }
    
    public void setLibraryStaffId(int libraryStaffId) {
        this.libraryStaffId = libraryStaffId;
    }
    
    public String getManagerName() {
        return managerName;
    }
    
    public void setManagerName(String managerName) {
        this.managerName = managerName;
    }
    
    public String getStaffName() {
        return staffName;
    }
    
    public void setStaffName(String staffName) {
        this.staffName = staffName;
    }
    
    public Supplier getSupplier() {
        return supplier;
    }
    
    public void setSupplier(Supplier supplier) {
        this.supplier = supplier;
    }
    
    public List<ImportDocument> getDocumentImports() {
        return documentImports;
    }
    
    public void setDocumentImports(List<ImportDocument> documentImports) {
        this.documentImports = documentImports;
    }
}







