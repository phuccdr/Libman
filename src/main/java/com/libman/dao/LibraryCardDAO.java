package com.libman.dao;

import com.libman.model.LibraryCard;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * LibraryCardDAO class for LibraryCard-related database operations
 */
public class LibraryCardDAO extends DAO {
    
    /**
     * Create a new library card
     * @param libraryCard LibraryCard object to create
     * @return true if creation successful, false otherwise
     */
    public boolean createCard(LibraryCard libraryCard) {
        String sql = "INSERT INTO tblLibraryCard (expiration_date, note, image, tblReaderid) " +
                     "VALUES (?, ?, ?, ?)";
        
        try {
            PreparedStatement ps = getConnection().prepareStatement(sql);
            ps.setDate(1, libraryCard.getExpirationDate());
            ps.setString(2, libraryCard.getNote());
            ps.setString(3, libraryCard.getImage());
            ps.setInt(4, libraryCard.getReaderId());
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Get all library cards for a specific reader
     * @param readerId Reader ID
     * @return List of LibraryCard objects
     */
    public List<LibraryCard> getLibraryCardsByReaderId(int readerId) {
        List<LibraryCard> cards = new ArrayList<>();
        String sql = "SELECT lc.*, m.name as reader_name " +
                     "FROM tblLibraryCard lc " +
                     "INNER JOIN tblMember m ON lc.tblReaderid = m.id " +
                     "WHERE lc.tblReaderid = ?";
        
        try {
            PreparedStatement ps = getConnection().prepareStatement(sql);
            ps.setInt(1, readerId);
            
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                LibraryCard card = new LibraryCard();
                card.setId(rs.getInt("id"));
                card.setExpirationDate(rs.getDate("expiration_date"));
                card.setNote(rs.getString("note"));
                card.setImage(rs.getString("image"));
                card.setReaderId(rs.getInt("tblReaderid"));
                card.setReaderName(rs.getString("reader_name"));
                
                cards.add(card);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return cards;
    }
    
    /**
     * Get library card by ID
     * @param cardId Library card ID
     * @return LibraryCard object or null
     */
    public LibraryCard getLibraryCardById(int cardId) {
        String sql = "SELECT lc.*, m.name as reader_name " +
                     "FROM tblLibraryCard lc " +
                     "INNER JOIN tblMember m ON lc.tblReaderid = m.id " +
                     "WHERE lc.id = ?";
        
        try {
            PreparedStatement ps = getConnection().prepareStatement(sql);
            ps.setInt(1, cardId);
            
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                LibraryCard card = new LibraryCard();
                card.setId(rs.getInt("id"));
                card.setExpirationDate(rs.getDate("expiration_date"));
                card.setNote(rs.getString("note"));
                card.setImage(rs.getString("image"));
                card.setReaderId(rs.getInt("tblReaderid"));
                card.setReaderName(rs.getString("reader_name"));
                
                return card;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return null;
    }
    
    /**
     * Check if reader already has a valid library card
     * @param readerId Reader ID
     * @return true if reader has valid card, false otherwise
     */
    public boolean hasValidCard(int readerId) {
        String sql = "SELECT COUNT(*) as count FROM tblLibraryCard " +
                     "WHERE tblReaderid = ? AND expiration_date >= CURDATE()";
        
        try {
            PreparedStatement ps = getConnection().prepareStatement(sql);
            ps.setInt(1, readerId);
            
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                return rs.getInt("count") > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return false;
    }
}




