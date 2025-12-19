package com.ecommerce.dao;

import com.ecommerce.model.User;
import com.ecommerce.util.DBUtil;

import java.sql.*;

public class UserDAO {

    public boolean createUser(User user) throws SQLException {
        String sql = "INSERT INTO users (username, password, email, is_admin) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, user.getUsername());
            ps.setString(2, user.getPassword()); // in prod, hash this
            ps.setString(3, user.getEmail());
            ps.setBoolean(4, user.isAdmin());
            int rows = ps.executeUpdate();
            if (rows > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) user.setId(rs.getInt(1));
                }
                return true;
            }
            return false;
        }
    }

    public User findByUsernameAndPassword(String username, String password) throws SQLException {
        String sql = "SELECT id, username, password, email, is_admin FROM users WHERE username = ? AND password = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, password); // in prod, compare hashes
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    User u = new User();
                    u.setId(rs.getInt("id"));
                    u.setUsername(rs.getString("username"));
                    u.setPassword(rs.getString("password"));
                    u.setEmail(rs.getString("email"));
                    u.setAdmin(rs.getBoolean("is_admin"));
                    return u;
                }
                return null;
            }
        }
    }

    public User findByUsername(String username) throws SQLException {
        String sql = "SELECT id, username, password, email, is_admin FROM users WHERE username = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    User u = new User();
                    u.setId(rs.getInt("id"));
                    u.setUsername(rs.getString("username"));
                    u.setPassword(rs.getString("password"));
                    u.setEmail(rs.getString("email"));
                    u.setAdmin(rs.getBoolean("is_admin"));
                    return u;
                }
                return null;
            }
        }
    }
}