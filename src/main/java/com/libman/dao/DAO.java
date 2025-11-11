package com.libman.dao;

import com.libman.utils.DBConnection;
import java.sql.Connection;
import java.sql.SQLException;

/**
 * Base DAO class with common database operations
 */
public abstract class DAO {
    protected Connection connection;
    
    /**
     * Constructor that initializes database connection
     */
    public DAO() {
        try {
            this.connection = DBConnection.getConnection();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    /**
     * Get the database connection
     * @return Connection object
     */
    protected Connection getConnection() throws SQLException {
        if (connection == null || connection.isClosed()) {
            connection = DBConnection.getConnection();
        }
        return connection;
    }
    
    /**
     * Close the database connection
     */
    protected void closeConnection() {
        DBConnection.closeConnection(connection);
    }
}









