package com.libman.model;

/**
 * ImportDocument entity class representing tblImportDocument table
 */
public class ImportDocument {
    private int id;
    private int quantity;
    private int price;
    private int invoiceId;
    private int documentId;
    private int supplierId;
    
    // For display purposes
    private String documentName;
    private String supplierName;
    
    // Constructors
    public ImportDocument() {
    }
    
    public ImportDocument(int quantity, int price, int invoiceId, int documentId, int supplierId) {
        this.quantity = quantity;
        this.price = price;
        this.invoiceId = invoiceId;
        this.documentId = documentId;
        this.supplierId = supplierId;
    }
    
    // Getters and Setters
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public int getQuantity() {
        return quantity;
    }
    
    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
    
    public int getPrice() {
        return price;
    }
    
    public void setPrice(int price) {
        this.price = price;
    }
    
    public int getInvoiceId() {
        return invoiceId;
    }
    
    public void setInvoiceId(int invoiceId) {
        this.invoiceId = invoiceId;
    }
    
    public int getDocumentId() {
        return documentId;
    }
    
    public void setDocumentId(int documentId) {
        this.documentId = documentId;
    }
    
    public int getSupplierId() {
        return supplierId;
    }
    
    public void setSupplierId(int supplierId) {
        this.supplierId = supplierId;
    }
    
    public String getDocumentName() {
        return documentName;
    }
    
    public void setDocumentName(String documentName) {
        this.documentName = documentName;
    }
    
    public String getSupplierName() {
        return supplierName;
    }
    
    public void setSupplierName(String supplierName) {
        this.supplierName = supplierName;
    }
}









