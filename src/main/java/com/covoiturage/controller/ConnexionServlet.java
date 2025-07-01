package com.covoiturage.controller;
import com.covoiturage.dao.UtilisateurDAO;
import com.covoiturage.model.Utilisateur;
import com.covoiturage.util.PasswordUtils;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/connexion")
public class ConnexionServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private UtilisateurDAO utilisateurDAO = new UtilisateurDAO();
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String plainPassword = request.getParameter("motDePasse");
        Utilisateur userFromDB = utilisateurDAO.findByEmail(email);
        if (userFromDB != null && PasswordUtils.checkPassword(plainPassword, userFromDB.getMotDePasse())) {
            HttpSession session = request.getSession();
            session.setAttribute("utilisateur", userFromDB);
            response.sendRedirect("index.jsp");
        } else {
            request.setAttribute("erreur", "Email ou mot de passe incorrect.");
            request.getRequestDispatcher("connexion.jsp").forward(request, response);
        }
    }
}