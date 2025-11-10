package com.libman.dao;

import com.libman.model.Member;
import com.libman.model.Reader;
import com.libman.model.Manager;
import java.sql.*;

/**
 * MemberDAO class for Member-related database operations
 */
public class MemberDAO extends DAO {
    
    /**
     * Authenticate member login
     * @param username Username
     * @param password Password
     * @return Member object if authentication successful, null otherwise
     */
    public Member authenticateMember(String username, String password) {
        String sql = "SELECT * FROM tblMember WHERE username = ? AND password = ?";
        
        try {
            PreparedStatement ps = getConnection().prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, password);
            
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                Member member = new Member();
                member.setId(rs.getInt("id"));
                member.setUsername(rs.getString("username"));
                member.setPassword(rs.getString("password"));
                member.setName(rs.getString("name"));
                member.setGender(rs.getString("gender"));
                member.setEmail(rs.getString("email"));
                member.setPhoneNumber(rs.getString("phone_number"));
                member.setBirthOfDate(rs.getDate("birth_of_date"));
                member.setAddress(rs.getString("address"));
                
                return member;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return null;
    }
    
    /**
     * Check if member is a Reader
     * @param memberId Member ID
     * @return Reader object if member is a reader, null otherwise
     */
    public Reader getReaderByMemberId(int memberId) {
        String sql = "SELECT m.*, r.rating " +
                     "FROM tblMember m " +
                     "INNER JOIN tblReader r ON m.id = r.tblMemberid " +
                     "WHERE m.id = ?";
        
        try {
            PreparedStatement ps = getConnection().prepareStatement(sql);
            ps.setInt(1, memberId);
            
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                Reader reader = new Reader();
                reader.setId(rs.getInt("id"));
                reader.setMemberId(rs.getInt("id"));
                reader.setUsername(rs.getString("username"));
                reader.setPassword(rs.getString("password"));
                reader.setName(rs.getString("name"));
                reader.setGender(rs.getString("gender"));
                reader.setEmail(rs.getString("email"));
                reader.setPhoneNumber(rs.getString("phone_number"));
                reader.setBirthOfDate(rs.getDate("birth_of_date"));
                reader.setAddress(rs.getString("address"));
                reader.setRating(rs.getInt("rating"));
                
                return reader;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return null;
    }
    
    /**
     * Check if member is a Manager
     * @param memberId Member ID
     * @return Manager object if member is a manager, null otherwise
     */
    public Manager getManagerByMemberId(int memberId) {
        String sql = "SELECT m.*, s.position, mg.role " +
                     "FROM tblMember m " +
                     "INNER JOIN tblStaff s ON m.id = s.tblMemberid " +
                     "INNER JOIN tblManager mg ON s.tblMemberid = mg.tblMemberid " +
                     "WHERE m.id = ?";
        
        try {
            PreparedStatement ps = getConnection().prepareStatement(sql);
            ps.setInt(1, memberId);
            
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                Manager manager = new Manager();
                manager.setId(rs.getInt("id"));
                manager.setMemberId(rs.getInt("id"));
                manager.setUsername(rs.getString("username"));
                manager.setPassword(rs.getString("password"));
                manager.setName(rs.getString("name"));
                manager.setGender(rs.getString("gender"));
                manager.setEmail(rs.getString("email"));
                manager.setPhoneNumber(rs.getString("phone_number"));
                manager.setBirthOfDate(rs.getDate("birth_of_date"));
                manager.setAddress(rs.getString("address"));
                manager.setPosition(rs.getString("position"));
                manager.setRole(rs.getString("role"));
                
                return manager;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return null;
    }
    
    /**
     * Get member type (READER or MANAGER)
     * @param memberId Member ID
     * @return String "READER", "MANAGER", or null
     */
    public String getMemberType(int memberId) {
        // Check if Reader
        if (getReaderByMemberId(memberId) != null) {
            return "READER";
        }
        
        // Check if Manager
        if (getManagerByMemberId(memberId) != null) {
            return "MANAGER";
        }
        
        return null;
    }
}







