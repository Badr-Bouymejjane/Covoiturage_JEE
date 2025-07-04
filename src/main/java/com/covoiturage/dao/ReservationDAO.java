package com.covoiturage.dao;
import com.covoiturage.model.*;
import com.covoiturage.util.DatabaseManager;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ReservationDAO {

    public void creerDemande(int passagerId, int trajetId, int nbrPlaces) throws SQLException {
        String sql = "INSERT INTO Reservation (PassagerId, TrajetId, NbrPlaces, StatusReservation) VALUES (?, ?, ?, 'DEMANDEE')";
        try (Connection conn = DatabaseManager.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, passagerId);
            pstmt.setInt(2, trajetId);
            pstmt.setInt(3, nbrPlaces);
            pstmt.executeUpdate();
        }
    }

    public void confirmerReservation(int reservationId, int trajetId, int nbrPlaces) throws SQLException {
        String sqlUpdateRes = "UPDATE Reservation SET StatusReservation = 'CONFIRMEE' WHERE Id = ?";
        String sqlUpdateTrajet = "UPDATE Trajet SET PlacesDisponibles = PlacesDisponibles - ? WHERE Id = ? AND PlacesDisponibles >= ?";
        Connection conn = null;
        try {
            conn = DatabaseManager.getConnection();
            conn.setAutoCommit(false); // Transaction

            try (PreparedStatement pstmtTrajet = conn.prepareStatement(sqlUpdateTrajet)) {
                pstmtTrajet.setInt(1, nbrPlaces);
                pstmtTrajet.setInt(2, trajetId);
                pstmtTrajet.setInt(3, nbrPlaces);
                if (pstmtTrajet.executeUpdate() == 0) throw new SQLException("Pas assez de places.");
            }

            try (PreparedStatement pstmtRes = conn.prepareStatement(sqlUpdateRes)) {
                pstmtRes.setInt(1, reservationId);
                pstmtRes.executeUpdate();
            }
            conn.commit();
        } catch (SQLException e) {
            if (conn != null) conn.rollback();
            throw e;
        } finally {
            if (conn != null) { conn.setAutoCommit(true); conn.close(); }
        }
    }

    public void refuserReservation(int reservationId) throws SQLException {
        String sql = "UPDATE Reservation SET StatusReservation = 'REFUSEE' WHERE Id = ?";
        try (Connection conn = DatabaseManager.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, reservationId);
            pstmt.executeUpdate();
        }
    }
    
    public List<Reservation> findDemandesByConducteurId(int conducteurId) {
        List<Reservation> demandes = new ArrayList<>();
        String sql = "SELECT r.*, t.Id as trajetId, t.VilleDepart, t.VilleArrivee, u.Prenom, u.Nom, u.Email " +
                     "FROM Reservation r " +
                     "JOIN Trajet t ON r.TrajetId = t.Id " +
                     "JOIN Utilisateur u ON r.PassagerId = u.Id " +
                     "WHERE t.ConducteurId = ? AND r.StatusReservation = 'DEMANDEE'";
        try (Connection conn = DatabaseManager.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, conducteurId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Reservation r = new Reservation();
                Trajet t = new Trajet();
                Utilisateur p = new Utilisateur();
                
                r.setId(rs.getInt("Id"));
                r.setNbrPlaces(rs.getInt("NbrPlaces"));
                
                p.setPrenom(rs.getString("Prenom")); p.setNom(rs.getString("Nom")); p.setEmail(rs.getString("Email"));
                r.setPassager(p);
                
                t.setId(rs.getInt("trajetId")); // Important pour le lien de confirmation
                t.setVilleDepart(rs.getString("VilleDepart")); t.setVilleArrivee(rs.getString("VilleArrivee"));
                r.setTrajet(t);
                
                demandes.add(r);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return demandes;
    }
    
    public List<Reservation> findByTrajetId(int trajetId) {
        List<Reservation> reservations = new ArrayList<>();
        String sql = "SELECT r.*, u.Prenom, u.Nom, u.Email FROM Reservation r " +
                     "JOIN Utilisateur u ON r.PassagerId = u.Id " +
                     "WHERE r.TrajetId = ?";
        try (Connection conn = DatabaseManager.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, trajetId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Reservation r = new Reservation();
                r.setId(rs.getInt("Id"));
                r.setNbrPlaces(rs.getInt("NbrPlaces"));
                r.setStatusReservation(StatusReservation.valueOf(rs.getString("StatusReservation")));
                
                Utilisateur p = new Utilisateur();
                p.setId(rs.getInt("PassagerId"));
                p.setPrenom(rs.getString("Prenom"));
                p.setNom(rs.getString("Nom"));
                p.setEmail(rs.getString("Email"));
                r.setPassager(p);
                
                reservations.add(r);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return reservations;
    }

    public List<Reservation> findByPassagerId(int passagerId) {
        List<Reservation> reservations = new ArrayList<>();
        String sql = "SELECT r.*, " +
                "t.VilleDepart, t.VilleArrivee, t.DateDepart, t.HeureDepart, " +
                "c.Prenom as ConducteurPrenom, c.Nom as ConducteurNom " + // On récupère le nom du conducteur
                "FROM Reservation r " +
                "JOIN Trajet t ON r.TrajetId = t.Id " +
                "JOIN Utilisateur c ON t.ConducteurId = c.Id " + // On joint la table Utilisateur pour le conducteur
                "WHERE r.PassagerId = ? ORDER BY t.DateDepart DESC";
        try (Connection conn = DatabaseManager.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, passagerId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Reservation r = new Reservation();
                Trajet t = new Trajet();
                Utilisateur conducteur = new Utilisateur();
                r.setId(rs.getInt("Id"));
                r.setDateReservation(rs.getTimestamp("DateReservation").toLocalDateTime());
                r.setStatusReservation(StatusReservation.valueOf(rs.getString("StatusReservation")));
                t.setVilleDepart(rs.getString("VilleDepart")); t.setVilleArrivee(rs.getString("VilleArrivee"));
                t.setDateDepart(rs.getDate("DateDepart").toLocalDate()); t.setHeureDepart(rs.getTime("HeureDepart").toLocalTime());
                conducteur.setPrenom(rs.getString("ConducteurPrenom"));
                conducteur.setNom(rs.getString("ConducteurNom"));
                t.setConducteur(conducteur);
                r.setTrajet(t);
                reservations.add(r);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return reservations;
    }
    
    public void annulerReservation(int reservationId) throws SQLException {
        String sqlSelect = "SELECT TrajetId, NbrPlaces, StatusReservation FROM reservation WHERE Id = ?";
        String sqlUpdateTrajet = "UPDATE trajet SET PlacesDisponibles = PlacesDisponibles + ? WHERE Id = ?";
        String sqlUpdateRes = "UPDATE reservation SET StatusReservation = 'ANNULEE' WHERE Id = ?";

        Connection conn = null;
        try {
            conn = DatabaseManager.getConnection();
            conn.setAutoCommit(false); // Début de la transaction

            // 1. Récupérer les informations de la réservation
            int trajetId = -1;
            int nbrPlaces = 0;
            StatusReservation currentStatus = null;

            try (PreparedStatement pstmt = conn.prepareStatement(sqlSelect)) {
                pstmt.setInt(1, reservationId);
                try (ResultSet rs = pstmt.executeQuery()) {
                    if (rs.next()) {
                        trajetId = rs.getInt("TrajetId");
                        nbrPlaces = rs.getInt("NbrPlaces");
                        currentStatus = StatusReservation.valueOf(rs.getString("StatusReservation"));
                    }
                }
            }

            if (trajetId != -1) {
                // 2. Si la réservation était confirmée, on remet les places
                if (currentStatus == StatusReservation.CONFIRMEE) {
                    try (PreparedStatement pstmt = conn.prepareStatement(sqlUpdateTrajet)) {
                        pstmt.setInt(1, nbrPlaces);
                        pstmt.setInt(2, trajetId);
                        pstmt.executeUpdate();
                    }
                }
                
                // 3. On met à jour le statut de la réservation à ANNULEE
                try (PreparedStatement pstmt = conn.prepareStatement(sqlUpdateRes)) {
                    pstmt.setInt(1, reservationId);
                    pstmt.executeUpdate();
                }
            }
            conn.commit(); // Fin de la transaction
        } catch (SQLException e) {
            if (conn != null) conn.rollback();
            throw e;
        } finally {
            if (conn != null) {
                conn.setAutoCommit(true);
                conn.close();
            }
        }
    }
}