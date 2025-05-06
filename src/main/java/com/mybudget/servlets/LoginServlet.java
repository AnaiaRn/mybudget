package com.mybudget.servlets;

import com.mybudget.dao.UtilisateurDAO;
import com.mybudget.models.Utilisateur;
import jakarta.mail.Session;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected  void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        String email = request.getParameter("email");
        String motdepasse = request.getParameter("mot_de_passe");

        UtilisateurDAO dao = new UtilisateurDAO();
        Utilisateur utilisateur = dao.getUtilisateurParEmailEtMotDePasse(email, motdepasse);

        if (utilisateur != null) {
            //Création de la session
            HttpSession session = request.getSession();
            session.setAttribute("utilisateur", utilisateur);
            session.setAttribute("estConnecte", true);
            session.setMaxInactiveInterval(5 * 10);

            //Journalisation
            System.out.println("Utilisateur connecté : " + utilisateur.getEmail());

            //Rédirection vers la page sécurisée
            response.sendRedirect(request.getContextPath() + "/depenses?action=list");
        } else {
            request.setAttribute("erreur", "Email ou mot de passe invalide");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet (HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        //Si déjà connecté, redirige vers l'accueil
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("estConnecte") != null) {
            response.sendRedirect(request.getContextPath() + "/depenses");
            return;
        }
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }
}
