package com.libman.model;

/**
 * SupplierStatistics model for supplier import statistics
 */
public class SupplierStatistics {
    private int supplierId;
    private String supplierName;
    private int quantity;
    private int totalAmount;
    
    // Constructors
    public SupplierStatistics() {
    }
    
    public SupplierStatistics(int supplierId, String supplierName, int quantity, int totalAmount) {
        this.supplierId = supplierId;
        this.supplierName = supplierName;
        this.quantity = quantity;
        this.totalAmount = totalAmount;
    }
    
    // Getters and Setters
    public int getSupplierId() {
        return supplierId;
    }
    
    public void setSupplierId(int supplierId) {
        this.supplierId = supplierId;
    }
    
    public String getSupplierName() {
        return supplierName;
    }
    
    public void setSupplierName(String supplierName) {
        this.supplierName = supplierName;
    }
    
    public int getQuantity() {
        return quantity;
    }
    
    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
    
    public int getTotalAmount() {
        return totalAmount;
    }
    
    public void setTotalAmount(int totalAmount) {
        this.totalAmount = totalAmount;
    }
}







