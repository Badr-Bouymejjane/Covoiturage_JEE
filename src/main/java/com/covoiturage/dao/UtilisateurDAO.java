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
}