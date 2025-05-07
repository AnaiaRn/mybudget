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

        // 1. Validation des paramètres
        String email = request.getParameter("email");
        String motDePasse = request.getParameter("mot_de_passe");

        if (email == null || email.isEmpty() || motDePasse == null || motDePasse.isEmpty()) {
            request.setAttribute("erreur", "Email et mot de passe requis");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        // 2. Authentification
        UtilisateurDAO dao = new UtilisateurDAO();
        Utilisateur utilisateur = dao.getUtilisateurParEmailEtMotDePasse(email, motDePasse);

        if (utilisateur != null) {
            // 3. Création de session sécurisée
            HttpSession session = request.getSession();
            session.invalidate(); // Invalide toute session existante

            session = request.getSession(true);
            session.setAttribute("utilisateur", utilisateur);
            session.setAttribute("estConnecte", true);
            session.setMaxInactiveInterval(SESSION_TIMEOUT);

            // 4. Sécurité supplémentaire
            response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
            response.setHeader("Pragma", "no-cache"); // HTTP 1.0
            response.setDateHeader("Expires", 0); // Proxies

            // 5. Cookie sécurisé
            Cookie sessionCookie = new Cookie("JSESSIONID", session.getId());
            sessionCookie.setHttpOnly(true);
            sessionCookie.setSecure(request.isSecure()); // HTTPS seulement
            sessionCookie.setMaxAge(SESSION_TIMEOUT);
            response.addCookie(sessionCookie);

            // 6. Journalisation
            System.out.println("Connexion réussie - Email: " + email + " - IP: " + request.getRemoteAddr());

            // 7. Redirection
            String redirectPath = (String) session.getAttribute("redirectAfterLogin");
            if (redirectPath != null && !redirectPath.isEmpty()) {
                session.removeAttribute("redirectAfterLogin");
                response.sendRedirect(redirectPath);
            } else {
                response.sendRedirect(request.getContextPath() + "/depenses?action=list");
            }
        } else {
            // Journalisation des échecs
            System.out.println("Tentative de connexion échouée - Email: " + email + " - IP: " + request.getRemoteAddr());

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