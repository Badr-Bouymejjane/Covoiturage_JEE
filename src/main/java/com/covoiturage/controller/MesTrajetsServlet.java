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
import java.util.List;

@WebServlet("/mes-trajets")
public class MesTrajetsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private TrajetDAO trajetDAO = new TrajetDAO();
    private ReservationDAO reservationDAO = new ReservationDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("utilisateur") == null) {
            response.sendRedirect("connexion.jsp");
            return;
        }

        Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateur");

        if (utilisateur.getRole() == Role.Conducteur) {
            List<Trajet> offres = trajetDAO.findByConducteurId(utilisateur.getId());
            request.setAttribute("listeOffres", offres);
            // Rediriger le conducteur vers sa page de gestion de trajets
            request.getRequestDispatcher("mes-trajets.jsp").forward(request, response);
        } else if (utilisateur.getRole() == Role.Passager) {
            List<Reservation> reservations = reservationDAO.findByPassagerId(utilisateur.getId());
            request.setAttribute("listeReservations", reservations);
            // Rediriger le passager vers sa page de réservations
            request.getRequestDispatcher("mes-reservations.jsp").forward(request, response);
        } else {
            // Pour l'admin ou autre, rediriger vers l'accueil
            response.sendRedirect("index.jsp");
        }
    }
}
