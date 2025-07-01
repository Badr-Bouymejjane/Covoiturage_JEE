package com.covoiturage.dao;

import com.covoiturage.model.StatusTrajet;
import com.covoiturage.model.Trajet;
import com.covoiturage.model.Utilisateur;
import com.covoiturage.util.DatabaseManager;
import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class TrajetDAO {

    public void creerTrajet(Trajet trajet) throws SQLException {
        String sql = "INSERT INTO Trajet (VilleDepart, VilleArrivee, DateDepart, HeureDepart, DateArrivee, HeureArrivee, PlacesDisponibles, PrixParPlace, Description, ConducteurId) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DatabaseManager.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, trajet.getVilleDepart());
            pstmt.setString(2, trajet.getVilleArrivee());
            pstmt.setDate(3, Date.valueOf(trajet.getDateDepart()));
            pstmt.setTime(4, Time.valueOf(trajet.getHeureDepart()));
            
            if (trajet.getDateArrivee() != null) {
                pstmt.setDate(5, Date.valueOf(trajet.getDateArrivee()));
            } else {
                pstmt.setNull(5, Types.DATE);
            }

            if (trajet.getHeureArrivee() != null) {
                pstmt.setTime(6, Time.valueOf(trajet.getHeureArrivee()));
            } else {
                pstmt.setNull(6, Types.TIME);
            }

            pstmt.setInt(7, trajet.getPlacesDisponibles());
            pstmt.setFloat(8, trajet.getPrixParPlace());
            pstmt.setString(9, trajet.getDescription());
            pstmt.setInt(10, trajet.getConducteur().getId());

            pstmt.executeUpdate();
        }
    }

    public List<Trajet> rechercherTrajets(String villeDepart, String villeArrivee, LocalDate dateDepart, int places) {
        List<Trajet> trajets = new ArrayList<>();
        String sql = "SELECT t.*, u.Nom, u.Prenom, u.Email FROM Trajet t " +
                     "JOIN Utilisateur u ON t.ConducteurId = u.Id " +
                     "WHERE t.VilleDepart LIKE ? AND t.VilleArrivee LIKE ? AND t.DateDepart = ? AND t.PlacesDisponibles >= ? AND t.StatusTrajet = 'ACTIF'";
        
        try (Connection conn = DatabaseManager.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, "%" + villeDepart + "%");
            pstmt.setString(2, "%" + villeArrivee + "%");
            pstmt.setDate(3, Date.valueOf(dateDepart));
            pstmt.setInt(4, places);
            
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Trajet trajet = new Trajet();
                trajet.setId(rs.getInt("Id"));
                trajet.setVilleDepart(rs.getString("VilleDepart"));
                trajet.setVilleArrivee(rs.getString("VilleArrivee"));
                trajet.setDateDepart(rs.getDate("DateDepart").toLocalDate());
                trajet.setHeureDepart(rs.getTime("HeureDepart").toLocalTime());
                trajet.setPrixParPlace(rs.getFloat("PrixParPlace"));
                trajet.setPlacesDisponibles(rs.getInt("PlacesDisponibles"));
                
                Utilisateur conducteur = new Utilisateur();
                conducteur.setId(rs.getInt("ConducteurId"));
                conducteur.setNom(rs.getString("Nom"));
                conducteur.setPrenom(rs.getString("Prenom"));
                conducteur.setEmail(rs.getString("Email"));
                trajet.setConducteur(conducteur);
                
                trajets.add(trajet);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return trajets;
    }

    public Trajet findTrajetById(int trajetId) {
        Trajet trajet = null;
        String sql = "SELECT t.*, u.Nom, u.Prenom, u.Email FROM Trajet t " +
                     "JOIN Utilisateur u ON t.ConducteurId = u.Id " +
                     "WHERE t.Id = ?";

        try (Connection conn = DatabaseManager.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, trajetId);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                trajet = new Trajet();
                trajet.setId(rs.getInt("Id"));
                trajet.setVilleDepart(rs.getString("VilleDepart"));
                trajet.setVilleArrivee(rs.getString("VilleArrivee"));
                trajet.setDateDepart(rs.getDate("DateDepart").toLocalDate());
                trajet.setHeureDepart(rs.getTime("HeureDepart").toLocalTime());
                trajet.setPrixParPlace(rs.getFloat("PrixParPlace"));
                trajet.setPlacesDisponibles(rs.getInt("PlacesDisponibles"));
                trajet.setDescription(rs.getString("Description"));

                Utilisateur conducteur = new Utilisateur();
                conducteur.setId(rs.getInt("ConducteurId"));
                conducteur.setNom(rs.getString("Nom"));
                conducteur.setPrenom(rs.getString("Prenom"));
                conducteur.setEmail(rs.getString("Email"));
                trajet.setConducteur(conducteur);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return trajet;
    }
    
    public List<Trajet> findByConducteurId(int conducteurId) {
        List<Trajet> trajets = new ArrayList<>();
        String sql = "SELECT * FROM Trajet WHERE ConducteurId = ? ORDER BY DateDepart DESC";
        
        try (Connection conn = DatabaseManager.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, conducteurId);
            
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Trajet trajet = new Trajet();
                trajet.setId(rs.getInt("Id"));
                trajet.setVilleDepart(rs.getString("VilleDepart"));
                trajet.setVilleArrivee(rs.getString("VilleArrivee"));
                trajet.setDateDepart(rs.getDate("DateDepart").toLocalDate());
                trajet.setHeureDepart(rs.getTime("HeureDepart").toLocalTime());
                trajet.setPrixParPlace(rs.getFloat("PrixParPlace"));
                trajet.setPlacesDisponibles(rs.getInt("PlacesDisponibles"));
                trajet.setStatusTrajet(StatusTrajet.valueOf(rs.getString("StatusTrajet")));
                
                trajets.add(trajet);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return trajets;
    }
    
    public void updateStatus(int trajetId, StatusTrajet status) throws SQLException {
        String sql = "UPDATE Trajet SET StatusTrajet = ? WHERE Id = ?";
        try (Connection conn = DatabaseManager.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, status.name());
            pstmt.setInt(2, trajetId);
            pstmt.executeUpdate();
        }
    }
}