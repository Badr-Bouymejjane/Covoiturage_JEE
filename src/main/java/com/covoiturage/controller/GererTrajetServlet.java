package com.covoiturage.controller;

import com.covoiturage.dao.ReservationDAO;
import com.covoiturage.dao.TrajetDAO;
import com.covoiturage.model.Reservation;
import com.covoiturage.model.Trajet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/gerer-trajet")
public class GererTrajetServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private TrajetDAO trajetDAO = new TrajetDAO();
    private ReservationDAO reservationDAO = new ReservationDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int trajetId = Integer.parseInt(request.getParameter("id"));
            Trajet trajet = trajetDAO.findTrajetById(trajetId);
            List<Reservation> reservations = reservationDAO.findByTrajetId(trajetId);

            request.setAttribute("trajet", trajet);
            request.setAttribute("reservations", reservations);

            request.getRequestDispatcher("gerer-trajet.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("mes-trajets?erreur=gestion");
        }
    }
}