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
                request.getRequestDispatcher("depenses/form.jsp").forward(request, response);
            } else if ("delete".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                depenseDAO.supprimerDepense(id);
                response.sendRedirect("depenses?action=list");
            } else {
                List<Depense> depenses = depenseDAO.getAll();
                request.setAttribute("depenses", depenses);
                request.getRequestDispatcher("depenses/list.jsp").forward(request, response);
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            int montant = Integer.parseInt(request.getParameter("montant"));
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
           }
           response.sendRedirect("depenses?action=list");
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
