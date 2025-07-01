package com.covoiturage.model;

import java.time.LocalDate;
import java.time.LocalTime;

public class Trajet {
    private int id;
    private String villeDepart;
    private String villeArrivee;
    private LocalDate dateDepart;
    private LocalTime heureDepart;
    private LocalDate dateArrivee;
    private LocalTime heureArrivee;
    private float prixParPlace;
    private int placesDisponibles;
    private String description;
    private StatusTrajet statusTrajet; // Attribut ajouté
    
    private Utilisateur conducteur;

    // Getters & Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getVilleDepart() { return villeDepart; }
    public void setVilleDepart(String villeDepart) { this.villeDepart = villeDepart; }
    public String getVilleArrivee() { return villeArrivee; }
    public void setVilleArrivee(String villeArrivee) { this.villeArrivee = villeArrivee; }
    public LocalDate getDateDepart() { return dateDepart; }
    public void setDateDepart(LocalDate dateDepart) { this.dateDepart = dateDepart; }
    public LocalTime getHeureDepart() { return heureDepart; }
    public void setHeureDepart(LocalTime heureDepart) { this.heureDepart = heureDepart; }
    public LocalDate getDateArrivee() { return dateArrivee; }
    public void setDateArrivee(LocalDate dateArrivee) { this.dateArrivee = dateArrivee; }
    public LocalTime getHeureArrivee() { return heureArrivee; }
    public void setHeureArrivee(LocalTime heureArrivee) { this.heureArrivee = heureArrivee; }
    public float getPrixParPlace() { return prixParPlace; }
    public void setPrixParPlace(float prixParPlace) { this.prixParPlace = prixParPlace; }
    public int getPlacesDisponibles() { return placesDisponibles; }
    public void setPlacesDisponibles(int placesDisponibles) { this.placesDisponibles = placesDisponibles; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public StatusTrajet getStatusTrajet() { return statusTrajet; } // Getter ajouté
    public void setStatusTrajet(StatusTrajet statusTrajet) { this.statusTrajet = statusTrajet; } // Setter ajouté
    public Utilisateur getConducteur() { return conducteur; }
    public void setConducteur(Utilisateur conducteur) { this.conducteur = conducteur; }
}