package com.libman.model;

/**
 * SupplierStatistics model for supplier import statistics
 */
public class SupplierStatistics {
    private int supplierId;
    private String supplierName;
    private int quantity;
 
    // Constructors
    public SupplierStatistics() {
    }
    
    public SupplierStatistics(int supplierId, String supplierName, int quantity) {
        this.supplierId = supplierId;
        this.supplierName = supplierName;
        this.quantity = quantity;
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
}









