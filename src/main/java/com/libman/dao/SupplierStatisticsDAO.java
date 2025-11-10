package com.libman.dao;

import com.libman.model.SupplierStatistics;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * SupplierStatisticsDAO class for supplier statistics operations
 */
public class SupplierStatisticsDAO extends DAO {
    
    /**
     * Generate supplier statistics for a date range
     * @param startDate Start date
     * @param endDate End date
     * @return List of SupplierStatistics objects
     */
    public List<SupplierStatistics> generateStatistics(Date startDate, Date endDate) {
        List<SupplierStatistics> statisticsList = new ArrayList<>();
        
        String sql = "SELECT s.id, s.name, " +
                     "SUM(id.quantity) as total_quantity, " +
                     "SUM(id.quantity * id.price) as total_amount " +
                     "FROM tblSupplier s " +
                     "INNER JOIN tblImportDocument id ON s.id = id.tblSupplierid " +
                     "INNER JOIN tblInvoice i ON id.tblInvoiceid = i.id " +
                     "WHERE i.create_date BETWEEN ? AND ? " +
                     "GROUP BY s.id, s.name " +
                     "ORDER BY total_quantity DESC";
        
        try {
            PreparedStatement ps = getConnection().prepareStatement(sql);
            ps.setDate(1, startDate);
            ps.setDate(2, endDate);
            
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                SupplierStatistics stats = new SupplierStatistics();
                stats.setSupplierId(rs.getInt("id"));
                stats.setSupplierName(rs.getString("name"));
                stats.setQuantity(rs.getInt("total_quantity"));
                stats.setTotalAmount(rs.getInt("total_amount"));
                
                statisticsList.add(stats);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return statisticsList;
    }
}







