package com.mybudget.servlets;

import com.mybudget.dao.UtilisateurDAO;
import com.mybudget.models.Utilisateur;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

public class LoginServlet extends HttpServlet {
    protected void doPost (HttpServletRequest  request, HttpServletResponse response)
        throws ServletException, IOException {
        String email = request.getParameter("email");
        String mot_de_passe = request.getParameter("mot_de_passe");

        UtilisateurDAO dao = new UtilisateurDAO();
        Utilisateur utilisateur = dao.getUtilisateurParEmailEtMotDePasse(email, mot_de_passe);

        if (utilisateur != null) {
            HttpSession session = request.getSession();
            session.setAttribute("Utilisateur", utilisateur);
            response.sendRedirect("dashboard.jsp");
        } else {
            request.setAttribute("erreur", "Email ou Mot de passe invalide");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
