package com.mybudget.servlets;

import com.mybudget.dao.UtilisateurDAO;
import com.mybudget.models.Utilisateur;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {

    private static final int SESSION_TIMEOUT = 30 * 60; // 30 minutes en secondes

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String motDePasse = request.getParameter("mot_de_passe");

        UtilisateurDAO dao = new UtilisateurDAO();
        Utilisateur utilisateur = dao.getUtilisateurParEmailEtMotDePasse(email, motDePasse);

        if (utilisateur != null) {
            // 1. Invalider l'ancienne session pour éviter les conflits
            HttpSession oldSession = request.getSession(false);
            if (oldSession != null) {
                oldSession.invalidate();
            }

            // 2. Créer une nouvelle session
            HttpSession newSession = request.getSession(true);
            newSession.setAttribute("utilisateur", utilisateur);

            // 3. Définir le timeout (en secondes)
            newSession.setMaxInactiveInterval(30 * 60); // 30 minutes

            // 4. Journalisation de debug
            System.out.println("Session ID après connexion: " + newSession.getId());
            System.out.println("Redirect vers: " + request.getContextPath() + "/depenses?action=list");

            // 5. Redirection ABSOLUE
            response.sendRedirect(request.getContextPath() + "/depenses?action=list");
            return; // Important!
        } else {
            request.setAttribute("erreur", "Identifiants invalides");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // Si déjà connecté, redirection
        if (session != null && session.getAttribute("estConnecte") != null) {
            response.sendRedirect(request.getContextPath() + "/depenses");
            return;
        }

        // Gestion des redirections après login
        String requestedPath = request.getParameter("from");
        if (requestedPath != null && !requestedPath.isEmpty()) {
            request.getSession(true).setAttribute("redirectAfterLogin", requestedPath);
        }

        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }
}