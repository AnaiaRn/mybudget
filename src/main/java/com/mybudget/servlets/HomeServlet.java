package com.mybudget.servlets;

import com.mybudget.dao.CategorieDAO;
import com.mybudget.dao.DepenseDAO;
import com.mybudget.models.Categorie;
import com.mybudget.models.Depense;
import com.mybudget.models.Utilisateur;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.time.LocalDate;
import java.time.YearMonth;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.stream.Collectors;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {
    private final DepenseDAO depenseDAO = new DepenseDAO();
    private final CategorieDAO categorieDAO = new CategorieDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("utilisateur") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            LocalDate maintenant = LocalDate.now();
            int mois = maintenant.getMonthValue();
            int annee = maintenant.getYear();

            // 1. Récupération des données
            List<Depense> depensesMoisCourant = depenseDAO.getDepensesDuMois(mois, annee);
            double totalCourant = depensesMoisCourant.stream()
                    .mapToDouble(Depense::getMontant)
                    .sum();

            // 2. Analyse par catégorie
            List<Categorie> categories = categorieDAO.getAllCategories();
            Map<Integer, String> categorieNames = categories.stream()
                    .collect(Collectors.toMap(Categorie::getId, Categorie::getNom));

            Map<String, Double> depensesParCategorie = depensesMoisCourant.stream()
                    .collect(Collectors.groupingBy(
                            d -> categorieNames.getOrDefault(d.getCategorieId(), "Inconnue"),
                            Collectors.summingDouble(Depense::getMontant)
                    ));

            // 3. Préparation des attributs
            request.setAttribute("moisEnCours", maintenant);
            request.setAttribute("totalDepenses", totalCourant);
            request.setAttribute("depensesParCategorie", depensesParCategorie);

            // Calcul du reste disponible (exemple avec un budget fixe)
            double budgetMensuel = 200000; // À remplacer par votre logique réelle
            request.setAttribute("budgetMensuel", budgetMensuel);
            request.setAttribute("resteDisponible", budgetMensuel - totalCourant);

            request.getRequestDispatcher("/WEB-INF/views/home.jsp").forward(request, response);

        } catch (Exception e) {
            request.setAttribute("error", "Erreur lors du chargement du tableau de bord");
            request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
        }
    }
}