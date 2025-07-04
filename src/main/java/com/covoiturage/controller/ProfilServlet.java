package com.covoiturage.controller;

import com.covoiturage.dao.UtilisateurDAO;
import com.covoiturage.model.Utilisateur;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/profil")
public class ProfilServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UtilisateurDAO utilisateurDAO = new UtilisateurDAO();

    /**
     * Affiche la page de profil.
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Simple redirection vers la page JSP, les données sont déjà dans la session.
        request.getRequestDispatcher("profil.jsp").forward(request, response);
    }

    /**
     * Traite la mise à jour des informations du profil.
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Utilisateur currentUser = (Utilisateur) session.getAttribute("utilisateur");

        // Récupérer les nouvelles informations depuis le formulaire
        String nom = request.getParameter("nom");
        String prenom = request.getParameter("prenom");
        String email = request.getParameter("email");
        String telephone = request.getParameter("telephone");

        // Mettre à jour l'objet utilisateur
        currentUser.setNom(nom);
        currentUser.setPrenom(prenom);
        currentUser.setEmail(email);
        currentUser.setTelephone(telephone);

        try {
            boolean success = utilisateurDAO.updateUser(currentUser);
            if (success) {
                // Rafraîchir l'objet utilisateur dans la session avec les nouvelles données
                Utilisateur updatedUser = utilisateurDAO.findById(currentUser.getId());
                session.setAttribute("utilisateur", updatedUser);
                request.setAttribute("successMessage", "Votre profil a été mis à jour avec succès !");
            } else {
                request.setAttribute("errorMessage", "Une erreur est survenue lors de la mise à jour.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Erreur de base de données. L'email est peut-être déjà utilisé.");
        }

        request.getRequestDispatcher("profil.jsp").forward(request, response);
    }
}
