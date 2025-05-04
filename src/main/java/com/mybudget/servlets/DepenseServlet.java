package com.mybudget.servlets;

import com.mybudget.dao.CategorieDAO;
import com.mybudget.dao.DepenseDAO;
import com.mybudget.models.Categorie;
import com.mybudget.models.Depense;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Date;
import java.util.List;

@WebServlet("/depenses")
public class DepenseServlet extends HttpServlet {
    private DepenseDAO depenseDAO = new DepenseDAO();
    private CategorieDAO categorieDAO = new CategorieDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            if("edit".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                Depense depense = depenseDAO.getById(id);
                List<Categorie> categories = categorieDAO.getAllCategories();
                request.setAttribute("depense", depense);
                request.setAttribute("categories", categories);
                request.getRequestDispatcher("form.jsp").forward(request, response);
            } else if ("create".equals(action)) {
                List<Categorie> categories = categorieDAO.getAllCategories();
                request.setAttribute("categories", categories);
                request.getRequestDispatcher("form.jsp").forward(request, response);
            } else {
                List<Depense> depenses = depenseDAO.getAll();
                request.setAttribute("depenses", depenses);
                request.getRequestDispatcher("list.jsp").forward(request, response);
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

   protected void doPost(HttpServletRequest request, HttpServletResponse response)
       throws ServletException, IOException {
        String action = request.getParameter("action");

       System.out.println("Action: " + action);
       System.out.println("ID: " + request.getParameter("id"));
       System.out.println("Montant: " + request.getParameter("montant"));
       System.out.println("Date: " + request.getParameter("date_depense"));
       System.out.println("Description: " + request.getParameter("description"));
       System.out.println("Categorie ID: " + request.getParameter("categorie_id"));


       try {
            double montant = Double.parseDouble(request.getParameter("montant"));
            String description = request.getParameter("description");
            Date date_depense = Date.valueOf(request.getParameter("date_depense"));
            int categorie_id = Integer.parseInt(request.getParameter("categorie_id"));

           if ("create".equals(action)) {
               Depense depense = new Depense(0, montant, description, date_depense, categorie_id);
               depenseDAO.ajouterDepense(depense);
           } else if ("update".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                Depense depense = new Depense(id, montant, description, date_depense, categorie_id);
                depenseDAO.updateDepense(depense);
            } else  if ("delete".equals(action)) {
               int id = Integer.parseInt(request.getParameter("id"));  // Récupère l'ID de la dépense
               depenseDAO.supprimerDepense(id);  // Appelle la méthode de suppression dans ton DAO
               response.sendRedirect("depenses?action=list");  // Redirige vers la liste des dépenses après suppression
           }
            response.sendRedirect("depenses?action=list");
        } catch (Exception e) {
            throw new ServletException(e);
        }
   }



}
