package com.covoiturage.controller;
import com.covoiturage.dao.ReservationDAO;
import com.covoiturage.model.Utilisateur;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/reservation")
public class ReservationServlet extends HttpServlet {
    private ReservationDAO reservationDAO = new ReservationDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("utilisateur") == null) {
            response.sendRedirect("connexion.jsp");
            return;
        }

        String action = request.getParameter("action");
        try {
            if ("request".equals(action)) {
                int trajetId = Integer.parseInt(request.getParameter("trajetId"));
                Utilisateur passager = (Utilisateur) session.getAttribute("utilisateur");
                reservationDAO.creerDemande(passager.getId(), trajetId, 1);
                response.sendRedirect("mes-trajets?demande=succes");
            }
            else if ("confirm".equals(action)) {
                int reservationId = Integer.parseInt(request.getParameter("resId"));
                int trajetId = Integer.parseInt(request.getParameter("trajetId"));
                int nbrPlaces = Integer.parseInt(request.getParameter("places"));
                reservationDAO.confirmerReservation(reservationId, trajetId, nbrPlaces);
                response.sendRedirect("gerer-trajet?id=" + trajetId);
            }
            else if ("refuse".equals(action)) {
                int reservationId = Integer.parseInt(request.getParameter("resId"));
                int trajetId = Integer.parseInt(request.getParameter("trajetId"));
                reservationDAO.refuserReservation(reservationId);
                response.sendRedirect("gerer-trajet?id=" + trajetId);
            }
	        else if ("cancel".equals(action)) {
	            int reservationId = Integer.parseInt(request.getParameter("id"));
	            // Idéalement, on vérifierait ici si l'utilisateur connecté a le droit d'annuler cette réservation.
	            reservationDAO.annulerReservation(reservationId);
	            response.sendRedirect("mes-trajets?cancel=success"); // Redirection vers le tableau de bord
	            return; // Important pour ne pas continuer l'exécution
	        }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("index.jsp?erreur=true");
        }
    }
}