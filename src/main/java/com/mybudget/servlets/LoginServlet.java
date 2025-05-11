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
            // 1. Invalider l'ancienne session si elle existe
            HttpSession oldSession = request.getSession(false);
            if (oldSession != null) {
                oldSession.invalidate();
            }

            // 2. Créer une nouvelle session
            HttpSession newSession = request.getSession(true);
            newSession.setAttribute("utilisateur", utilisateur);
            newSession.setMaxInactiveInterval(SESSION_TIMEOUT);

            // 3. Configurer le cookie manuellement pour plus de fiabilité
            Cookie sessionCookie = new Cookie("JSESSIONID", newSession.getId());
            sessionCookie.setPath(request.getContextPath());
            sessionCookie.setMaxAge(SESSION_TIMEOUT);
            sessionCookie.setHttpOnly(true);
            sessionCookie.setSecure(request.isSecure()); // Active en HTTPS
            response.addCookie(sessionCookie);

            // 4. Empêcher la mise en cache
            response.setHeader("Cache-Control", "no-cache, no-store");

            // 5. Redirection
            String redirectPath = request.getParameter("from") != null ?
                    request.getParameter("from") :
                    request.getContextPath() + "/home.jsp";

            System.out.println("Connexion réussie. Redirection vers: " + redirectPath);
            response.sendRedirect(redirectPath);

        } else {
            request.setAttribute("erreur", "Identifiants invalides");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // Redirection si déjà connecté
        if (session != null && session.getAttribute("utilisateur") != null) {
            response.sendRedirect(request.getContextPath() + "/depenses");
            return;
        }

        // Gestion de la redirection post-login
        String requestedPath = request.getParameter("from");
        if (requestedPath != null && !requestedPath.isEmpty()) {
            request.getSession(true).setAttribute("redirectAfterLogin", requestedPath);
        }

        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }
}