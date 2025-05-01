package com.mybudget.servlets;

import com.mybudget.dao.DepenseDAO;
import com.mybudget.models.Depense;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

@WebServlet("/depenses")
public class DepenseServlet extends HttpServlet {

    private DepenseDAO depenseDAO;

    @Override
    public void init() throws ServletException {
        depenseDAO = new DepenseDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            if (action == null) action = "list";

            switch (action) {
                case "new":
                    showNewForm(request, response);
                    break;
                case "edit":
                    showEditForm(request, response);
                    break;
                case "delete":
                    deleteDepense(request, response);
                    break;
                default:
                    listDepenses(request, response);
                    break;
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            switch (action) {
                case "insert":
                    insertDepense(request, response);
                    break;
                case "update":
                    updateDepense(request, response);
                    break;
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    private void listDepenses(HttpServletRequest request, HttpServletResponse response)
        throws Exception {
        List<Depense> liste = depenseDAO.getAll();
        request.setAttribute("listeDepenses", liste);
        request.getRequestDispatcher("WEB-INF/views/listeDepenses.jsp").forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/ajouterDepense.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
        throws Exception {
        int id = Integer.parseInt(request.getParameter("id"));
        Depense depense = depenseDAO.getById(id);
        request.setAttribute("depense", depense);
        request.getRequestDispatcher("/WEB-INF/views/modifierDepense.jsp").forward(request, response);
    }

    private void insertDepense(HttpServletRequest request, HttpServletResponse response)
        throws Exception {
        BigDecimal montant = new BigDecimal(request.getParameter("montant"));
        Date date = java.sql.Date.valueOf(request.getParameter("date_depense"));
        String description = request.getParameter("description");
        int utilisateurId = 1;
        int categorieId = Integer.parseInt(request.getParameter("categorie_id"));

        Depense depense = new Depense(id, montant, date_depense, description, utilisateurId, categorieId);
        depenseDAO.update(depense);
        response.sendRedirect("depenses");
    }
    private void deleteDepense(HttpServletRequest request, HttpServletResponse response)
        throws Exception {
        int id = Integer.parseInt(request.getParameter("id"));
        depenseDAO.delete(id);
        response.sendRedirect("depenses");
    }
}
