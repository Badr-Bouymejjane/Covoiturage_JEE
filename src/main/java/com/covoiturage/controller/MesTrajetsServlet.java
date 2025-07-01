package com.covoiturage.controller;

import com.covoiturage.dao.ReservationDAO;
import com.covoiturage.dao.TrajetDAO;
import com.covoiturage.model.Reservation;
import com.covoiturage.model.Role;
import com.covoiturage.model.Trajet;
import com.covoiturage.model.Utilisateur;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.*;

@WebServlet("/mes-trajets")
public class MesTrajetsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private TrajetDAO trajetDAO;
    private ReservationDAO reservationDAO;

    public void init() {
        trajetDAO = new TrajetDAO();
        reservationDAO = new ReservationDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("utilisateur") == null) {
            response.sendRedirect("connexion.jsp");
            return;
        }
        Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateur");

        if (utilisateur.getRole() == Role.Conducteur) {
            List<Trajet> offres = trajetDAO.findByConducteurId(utilisateur.getId());
            // Pour chaque offre, on récupère les demandes de réservation
            Map<Integer, List<Reservation>> demandesParTrajet = new HashMap<>();
            for (Trajet trajet : offres) {
                List<Reservation> demandes = reservationDAO.findByTrajetId(trajet.getId());
                if (!demandes.isEmpty()) {
                    demandesParTrajet.put(trajet.getId(), demandes);
                }
            }
            request.setAttribute("listeOffres", offres);
            request.setAttribute("demandesParTrajet", demandesParTrajet);
        } else { // Passager
            List<Reservation> reservations = reservationDAO.findByPassagerId(utilisateur.getId());
            request.setAttribute("listeReservations", reservations);
        }
        request.getRequestDispatcher("mes-trajets.jsp").forward(request, response);
    }
}