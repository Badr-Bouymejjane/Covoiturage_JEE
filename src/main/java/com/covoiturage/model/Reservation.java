package com.covoiturage.model;
import java.time.LocalDateTime;
public class Reservation {
    private int id;
    private LocalDateTime dateReservation;
    private int nbrPlaces;
    private StatusReservation statusReservation;
    
    // IDs pour la base de données
    private int passagerId;
    private int trajetId;

    // Objets pour un affichage facile des données
    private Utilisateur passager; 
    private Trajet trajet;       

    // Getters & Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public LocalDateTime getDateReservation() { return dateReservation; }
    public void setDateReservation(LocalDateTime d) { this.dateReservation = d; }
    public int getNbrPlaces() { return nbrPlaces; }
    public void setNbrPlaces(int n) { this.nbrPlaces = n; }
    public StatusReservation getStatusReservation() { return statusReservation; }
    public void setStatusReservation(StatusReservation s) { this.statusReservation = s; }
    public int getPassagerId() { return passagerId; }
    public void setPassagerId(int id) { this.passagerId = id; }
    public int getTrajetId() { return trajetId; }
    public void setTrajetId(int id) { this.trajetId = id; }
    public Utilisateur getPassager() { return passager; }
    public void setPassager(Utilisateur p) { this.passager = p; }
    public Trajet getTrajet() { return trajet; }
    public void setTrajet(Trajet t) { this.trajet = t; }
}