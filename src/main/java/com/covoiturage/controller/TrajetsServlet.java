package com.covoiturage.controller;

import com.covoiturage.dao.TrajetDAO;
import com.covoiturage.model.Trajet;
import com.covoiturage.model.Utilisateur;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeParseException;
import java.util.List;

@WebServlet("/trajets")
public class TrajetsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private TrajetDAO trajetDAO;

    public void init() {
        trajetDAO = new TrajetDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) { action = "search"; }

        switch (action) {
            case "search":
                rechercherTrajets(request, response);
                break;
            case "details":
                afficherDetailsTrajet(request, response);
                break;
            default:
                response.sendRedirect("index.jsp");
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("create".equals(action)) {
            creerTrajet(request, response);
        } else {
            response.sendRedirect("index.jsp");
        }
    }

    private void creerTrajet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("utilisateur") == null) {
            response.sendRedirect("connexion.jsp");
            return;
        }

        try {
            Trajet trajet = new Trajet();
            trajet.setVilleDepart(request.getParameter("villeDepart"));
            trajet.setVilleArrivee(request.getParameter("villeArrivee"));
            trajet.setDateDepart(LocalDate.parse(request.getParameter("dateDepart")));
            trajet.setHeureDepart(LocalTime.parse(request.getParameter("heureDepart")));
            trajet.setPlacesDisponibles(Integer.parseInt(request.getParameter("placesDisponibles")));
            trajet.setPrixParPlace(Float.parseFloat(request.getParameter("prixParPlace")));
            trajet.setDescription(request.getParameter("description"));
            
            // MISE À JOUR : Gestion des champs optionnels pour l'arrivée
            String dateArriveeStr = request.getParameter("dateArrivee");
            if (dateArriveeStr != null && !dateArriveeStr.isEmpty()) {
                trajet.setDateArrivee(LocalDate.parse(dateArriveeStr));
            }

            String heureArriveeStr = request.getParameter("heureArrivee");
            if (heureArriveeStr != null && !heureArriveeStr.isEmpty()) {
                trajet.setHeureArrivee(LocalTime.parse(heureArriveeStr));
            }

            trajet.setConducteur((Utilisateur) session.getAttribute("utilisateur"));

            trajetDAO.creerTrajet(trajet);
            
            // Redirection vers "Mes Offres" pour voir le trajet créé
            response.sendRedirect("mes-trajets?creation=succes"); 

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("erreur", "Erreur lors de la création du trajet.");
            request.getRequestDispatcher("proposer-trajet.jsp").forward(request, response);
        } catch (DateTimeParseException | NumberFormatException e) {
            e.printStackTrace();
            request.setAttribute("erreur", "Format de données invalide. Veuillez vérifier les dates, heures et nombres.");
            request.getRequestDispatcher("proposer-trajet.jsp").forward(request, response);
        }
    }

    private void rechercherTrajets(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String villeDepart = request.getParameter("villeDepart");
            String villeArrivee = request.getParameter("villeArrivee");
            LocalDate dateDepart = LocalDate.parse(request.getParameter("dateDepart"));
            int places = Integer.parseInt(request.getParameter("places"));

            List<Trajet> trajetsTrouves = trajetDAO.rechercherTrajets(villeDepart, villeArrivee, dateDepart, places);

            request.setAttribute("listeTrajets", trajetsTrouves);
            request.setAttribute("villeDepart", villeDepart);
            request.setAttribute("villeArrivee", villeArrivee);
            
            request.getRequestDispatcher("resultats-recherche.jsp").forward(request, response);

        } catch (DateTimeParseException | NumberFormatException e) {
            request.setAttribute("erreur", "Format de date ou de nombre de places invalide.");
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }
    }

    private void afficherDetailsTrajet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Trajet trajet = trajetDAO.findTrajetById(id);

            if (trajet != null) {
                request.setAttribute("trajet", trajet);
                request.getRequestDispatcher("trajet-details.jsp").forward(request, response);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Trajet non trouvé.");
            }
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID de trajet invalide.");
        }
    }
}