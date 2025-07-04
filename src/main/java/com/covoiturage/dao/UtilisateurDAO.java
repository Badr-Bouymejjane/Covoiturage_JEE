package com.covoiturage.dao;
import com.covoiturage.model.Role;
import com.covoiturage.model.Utilisateur;
import com.covoiturage.util.DatabaseManager;
import com.covoiturage.util.PasswordUtils;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UtilisateurDAO {
    public void creer(Utilisateur user) throws SQLException {
        String sql = "INSERT INTO Utilisateur (Nom, Prenom, Email, MotDePasse, Role) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DatabaseManager.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, user.getNom());
            pstmt.setString(2, user.getPrenom());
            pstmt.setString(3, user.getEmail());
            pstmt.setString(4, PasswordUtils.hashPassword(user.getMotDePasse()));
            pstmt.setString(5, user.getRole().name());
            pstmt.executeUpdate();
        }
    }

    public Utilisateur findByEmail(String email) {
        String sql = "SELECT * FROM Utilisateur WHERE Email = ?";
        Utilisateur user = null;
        try (Connection conn = DatabaseManager.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, email);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                user = new Utilisateur();
                user.setId(rs.getInt("Id"));
                user.setNom(rs.getString("Nom"));
                user.setPrenom(rs.getString("Prenom"));
                user.setEmail(rs.getString("Email"));
                user.setMotDePasse(rs.getString("MotDePasse"));
                user.setRole(Role.valueOf(rs.getString("Role")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }
    
    public boolean updateUser(Utilisateur user) throws SQLException {
        String sql = "UPDATE utilisateur SET Nom = ?, Prenom = ?, Email = ?, Telephone = ? WHERE Id = ?";
        
        try (Connection conn = DatabaseManager.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, user.getNom());
            pstmt.setString(2, user.getPrenom());
            pstmt.setString(3, user.getEmail());
            pstmt.setString(4, user.getTelephone());
            pstmt.setInt(5, user.getId());

            int affectedRows = pstmt.executeUpdate();
            return affectedRows > 0;
        }
    }
    
    public Utilisateur findById(int id) {
        String sql = "SELECT * FROM utilisateur WHERE Id = ?";
        Utilisateur user = null;

        try (Connection conn = DatabaseManager.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, id);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                user = new Utilisateur();
                user.setId(rs.getInt("Id"));
                user.setNom(rs.getString("Nom"));
                user.setPrenom(rs.getString("Prenom"));
                user.setEmail(rs.getString("Email"));
                user.setMotDePasse(rs.getString("MotDePasse")); // Important de garder le mdp
                user.setRole(Role.valueOf(rs.getString("Role")));
                user.setTelephone(rs.getString("Telephone"));
                user.setDateInscription(rs.getTimestamp("DateInscription"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }
}