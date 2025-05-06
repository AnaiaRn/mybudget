package com.mybudget.servlets;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/logout")
public class LogoutServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            //Journalisation
            System.out.println("Déconnexion de : " + session.getAttribute("email"));

            session.invalidate(); //Destruction de la session
        }
        response.sendRedirect(request.getContextPath() + "/login");
    }
}
