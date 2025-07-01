package com.covoiturage.controller;

import com.covoiturage.dao.ReservationDAO;
import com.covoiturage.model.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/reservation")
public class ReservationServlet extends HttpServlet {
    private ReservationDAO reservationDAO = new ReservationDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("utilisateur") == null) {
            response.sendRedirect("connexion.jsp");
            return;
        }

        if ("request".equals(action)) {
            creerDemandeReservation(request, response, session);
        } else if ("update".equals(action)) {
            updateStatutReservation(request, response);
        }
    }

    private void creerDemandeReservation(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws IOException {
        try {
            int trajetId = Integer.parseInt(request.getParameter("trajetId"));
            Utilisateur passager = (Utilisateur) session.getAttribute("utilisateur");

            Reservation reservation = new Reservation();
            reservation.setTrajetId(trajetId);
            reservation.setPassagerId(passager.getId());
            reservation.setNbrPlaces(1); // Pour l'instant, on réserve 1 place

            reservationDAO.creerDemande(reservation);
            response.sendRedirect("mes-trajets"); // Redirige vers la page de confirmation
        } catch (Exception e) {
            e.printStackTrace();
            // Gérer l'erreur, peut-être avec un message
            response.sendRedirect("index.jsp?erreur=reservation");
        }
    }

    private void updateStatutReservation(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            int reservationId = Integer.parseInt(request.getParameter("id"));
            StatusReservation status = StatusReservation.valueOf(request.getParameter("status"));
            
            reservationDAO.updateStatus(reservationId, status);
            response.sendRedirect("mes-trajets");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("mes-trajets?erreur=update");
        }
    }
}