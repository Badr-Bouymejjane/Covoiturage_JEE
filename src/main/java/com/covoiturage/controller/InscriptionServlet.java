package com.covoiturage.controller;
import com.covoiturage.dao.UtilisateurDAO;
import com.covoiturage.model.Role;
import com.covoiturage.model.Utilisateur;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/inscription")
public class InscriptionServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private UtilisateurDAO utilisateurDAO = new UtilisateurDAO();
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Utilisateur user = new Utilisateur();
        user.setNom(request.getParameter("nom"));
        user.setPrenom(request.getParameter("prenom"));
        user.setEmail(request.getParameter("email"));
        user.setMotDePasse(request.getParameter("motDePasse"));
        user.setRole(Role.valueOf(request.getParameter("role")));
        try {
            utilisateurDAO.creer(user);
            response.sendRedirect("connexion.jsp?inscription=succes");
        } catch (SQLException e) {
            if (e.getSQLState().startsWith("23")) {
                request.setAttribute("erreur", "Cette adresse email est déjà utilisée.");
            } else {
                request.setAttribute("erreur", "Une erreur technique est survenue.");
            }
            request.getRequestDispatcher("inscription.jsp").forward(request, response);
        }
    }
}