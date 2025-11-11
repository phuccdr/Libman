package com.libman.dao;

import com.libman.model.Invoice;
import com.libman.model.ImportDocument;
import com.libman.model.Supplier;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * InvoiceDAO class for Invoice-related database operations
 */
public class InvoiceDAO extends DAO {
    
    /**
     * Get all invoices for a specific supplier within date range
     * @param supplierId Supplier ID
     * @param startDate Start date
     * @param endDate End date
     * @return List of Invoice objects
     */
    public List<Invoice> getSupplierImportDocument(int supplierId, Date startDate, Date endDate) {
        List<Invoice> invoices = new ArrayList<>();
        
        String sql = "SELECT DISTINCT i.*, " +
                     "m1.name as manager_name, " +
                     "m2.name as staff_name, " +
                     "s.id as supplier_id, s.name as supplier_name, " +
                     "s.phone_number as supplier_phone, s.email as supplier_email, " +
                     "s.address as supplier_address " +
                     "FROM tblInvoice i " +
                     "INNER JOIN tblMember m1 ON i.tblManagerid = m1.id " +
                     "INNER JOIN tblMember m2 ON i.tblLibraryStaffid = m2.id " +
                     "INNER JOIN tblImportDocument id ON i.id = id.tblInvoiceid " +
                     "INNER JOIN tblSupplier s ON id.tblSupplierid = s.id " +
                     "WHERE id.tblSupplierid = ? " +
                     "AND i.create_date BETWEEN ? AND ? " +
                     "ORDER BY i.create_date DESC";
        
        try {
            PreparedStatement ps = getConnection().prepareStatement(sql);
            ps.setInt(1, supplierId);
            ps.setDate(2, startDate);
            ps.setDate(3, endDate);
            
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                Invoice invoice = new Invoice();
                invoice.setId(rs.getInt("id"));
                invoice.setTotalPrice(rs.getInt("total_price"));
                invoice.setCreateDate(rs.getDate("create_date"));
                invoice.setManagerId(rs.getInt("tblManagerid"));
                invoice.setLibraryStaffId(rs.getInt("tblLibraryStaffid"));
                invoice.setManagerName(rs.getString("manager_name"));
                invoice.setStaffName(rs.getString("staff_name"));
                
                // Create Supplier object
                Supplier supplier = new Supplier();
                supplier.setId(rs.getInt("supplier_id"));
                supplier.setName(rs.getString("supplier_name"));
                supplier.setPhoneNumber(rs.getString("supplier_phone"));
                supplier.setEmail(rs.getString("supplier_email"));
                supplier.setAddress(rs.getString("supplier_address"));
                invoice.setSupplier(supplier);
                
                invoices.add(invoice);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return invoices;
    }
    
    /**
     * Get invoice information with all import documents
     * @param invoiceId Invoice ID
     * @return Invoice object with document imports
     */
    public Invoice getInvoiceInfo(int invoiceId) {
        Invoice invoice = null;
        
        // Get invoice basic info
        String invoiceSql = "SELECT i.*, " +
                           "m1.name as manager_name, " +
                           "m2.name as staff_name " +
                           "FROM tblInvoice i " +
                           "INNER JOIN tblMember m1 ON i.tblManagerid = m1.id " +
                           "INNER JOIN tblMember m2 ON i.tblLibraryStaffid = m2.id " +
                           "WHERE i.id = ?";
        
        try {
            PreparedStatement ps = getConnection().prepareStatement(invoiceSql);
            ps.setInt(1, invoiceId);
            
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                invoice = new Invoice();
                invoice.setId(rs.getInt("id"));
                invoice.setTotalPrice(rs.getInt("total_price"));
                invoice.setCreateDate(rs.getDate("create_date"));
                invoice.setManagerId(rs.getInt("tblManagerid"));
                invoice.setLibraryStaffId(rs.getInt("tblLibraryStaffid"));
                invoice.setManagerName(rs.getString("manager_name"));
                invoice.setStaffName(rs.getString("staff_name"));
                
                // Get import documents for this invoice
                List<ImportDocument> importDocs = getImportDocumentsByInvoiceId(invoiceId);
                invoice.setDocumentImports(importDocs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return invoice;
    }
    
    /**
     * Get all import documents for a specific invoice
     * @param invoiceId Invoice ID
     * @return List of ImportDocument objects
     */
    private List<ImportDocument> getImportDocumentsByInvoiceId(int invoiceId) {
        List<ImportDocument> importDocs = new ArrayList<>();
        
        String sql = "SELECT id.*, " +
                     "d.name as document_name, " +
                     "s.name as supplier_name " +
                     "FROM tblImportDocument id " +
                     "INNER JOIN tblDocument d ON id.tblDocumentid = d.id " +
                     "INNER JOIN tblSupplier s ON id.tblSupplierid = s.id " +
                     "WHERE id.tblInvoiceid = ?";
        
        try {
            PreparedStatement ps = getConnection().prepareStatement(sql);
            ps.setInt(1, invoiceId);
            
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                ImportDocument importDoc = new ImportDocument();
                importDoc.setId(rs.getInt("id"));
                importDoc.setQuantity(rs.getInt("quantity"));
                importDoc.setPrice(rs.getInt("price"));
                importDoc.setInvoiceId(rs.getInt("tblInvoiceid"));
                importDoc.setDocumentId(rs.getInt("tblDocumentid"));
                importDoc.setSupplierId(rs.getInt("tblSupplierid"));
                importDoc.setDocumentName(rs.getString("document_name"));
                importDoc.setSupplierName(rs.getString("supplier_name"));
                
                importDocs.add(importDoc);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return importDocs;
    }
}









