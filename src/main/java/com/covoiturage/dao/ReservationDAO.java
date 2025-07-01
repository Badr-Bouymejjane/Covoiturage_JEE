package com.covoiturage.dao;

import com.covoiturage.model.*;
import com.covoiturage.util.DatabaseManager;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import com.covoiturage.model.StatusReservation;
import com.covoiturage.model.Trajet;
import com.covoiturage.model.Utilisateur;

public class ReservationDAO {
	
	public void creerDemande(Reservation reservation) throws SQLException {
        // La transaction garantit que les deux opérations réussissent ou échouent ensemble.
        String sqlUpdateTrajet = "UPDATE Trajet SET PlacesDisponibles = PlacesDisponibles - ? WHERE Id = ? AND PlacesDisponibles >= ?";
        String sqlInsertReservation = "INSERT INTO Reservation (PassagerId, TrajetId, NbrPlaces, StatusReservation) VALUES (?, ?, ?, 'DEMANDEE')";
        
        Connection conn = null;
        try {
            conn = DatabaseManager.getConnection();
            conn.setAutoCommit(false); // Début de la transaction

            // 1. Vérifier et décrémenter les places
            try (PreparedStatement pstmtUpdate = conn.prepareStatement(sqlUpdateTrajet)) {
                pstmtUpdate.setInt(1, reservation.getNbrPlaces());
                pstmtUpdate.setInt(2, reservation.getTrajetId());
                pstmtUpdate.setInt(3, reservation.getNbrPlaces());
                int rowsAffected = pstmtUpdate.executeUpdate();
                if (rowsAffected == 0) {
                    throw new SQLException("Pas assez de places disponibles.");
                }
            }

            // 2. Créer la demande de réservation
            try (PreparedStatement pstmtInsert = conn.prepareStatement(sqlInsertReservation)) {
                pstmtInsert.setInt(1, reservation.getPassagerId());
                pstmtInsert.setInt(2, reservation.getTrajetId());
                pstmtInsert.setInt(3, reservation.getNbrPlaces());
                pstmtInsert.executeUpdate();
            }
            conn.commit(); // Valider la transaction
        } catch (SQLException e) {
            if (conn != null) conn.rollback(); // Annuler en cas d'erreur
            throw e;
        } finally {
            if (conn != null) { conn.setAutoCommit(true); conn.close(); }
        }
    }

    public void updateStatus(int reservationId, StatusReservation status) throws SQLException {
        String sql = "UPDATE Reservation SET StatusReservation = ? WHERE Id = ?";
        try (Connection conn = DatabaseManager.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, status.name());
            pstmt.setInt(2, reservationId);
            pstmt.executeUpdate();
        }
    }
	
    public List<Reservation> findByPassagerId(int passagerId) {
        List<Reservation> reservations = new ArrayList<>();
        String sql = "SELECT r.*, t.VilleDepart, t.VilleArrivee, t.DateDepart, t.HeureDepart " +
                     "FROM Reservation r JOIN Trajet t ON r.TrajetId = t.Id " +
                     "WHERE r.PassagerId = ? ORDER BY t.DateDepart DESC";

        try (Connection conn = DatabaseManager.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, passagerId);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                Reservation reservation = new Reservation();
                reservation.setId(rs.getInt("Id"));
                reservation.setDateReservation(rs.getTimestamp("DateReservation").toLocalDateTime());
                reservation.setNbrPlaces(rs.getInt("NbrPlaces"));
                reservation.setStatusReservation(StatusReservation.valueOf(rs.getString("StatusReservation")));
                reservation.setPassagerId(rs.getInt("PassagerId"));
                reservation.setTrajetId(rs.getInt("TrajetId"));

                Trajet trajet = new Trajet();
                trajet.setVilleDepart(rs.getString("VilleDepart"));
                trajet.setVilleArrivee(rs.getString("VilleArrivee"));
                trajet.setDateDepart(rs.getDate("DateDepart").toLocalDate());
                trajet.setHeureDepart(rs.getTime("HeureDepart").toLocalTime());
                reservation.setTrajet(trajet);

                reservations.add(reservation);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return reservations;
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
}