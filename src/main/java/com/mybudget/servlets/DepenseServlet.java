package com.mybudget.servlets;

import com.mybudget.dao.CategorieDAO;
import com.mybudget.dao.DepenseDAO;
import com.mybudget.models.Categorie;
import com.mybudget.models.Depense;
import com.mybudget.utils.EmailSender;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@WebServlet("/depenses")
public class DepenseServlet extends HttpServlet {
    private final DepenseDAO depenseDAO = new DepenseDAO();
    private final CategorieDAO categorieDAO = new CategorieDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("estConnecte") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
        }


        String action = request.getParameter("action");

        try {
            if ("analyse".equals(action)) {
                LocalDate maintenant = LocalDate.now();
                int mois = maintenant.getMonthValue();
                int annee = maintenant.getYear();

                // Données du mois courant
                List<Depense> depensesMoisCourant = depenseDAO.getDepensesDuMois(mois, annee);
                double totalCourant = depensesMoisCourant.stream()
                        .mapToDouble(Depense::getMontant)
                        .sum();

                // Données du mois précédent
                LocalDate moisPrecedent = maintenant.minusMonths(1);
                List<Depense> depensesMoisPrecedent = depenseDAO.getDepensesDuMois(
                        moisPrecedent.getMonthValue(),
                        moisPrecedent.getYear()
                );
                double totalPrecedent = depensesMoisPrecedent.stream()
                        .mapToDouble(Depense::getMontant)
                        .sum();

                // Calculs
                double variation = totalCourant - totalPrecedent;
                double pourcentageVariation = (totalPrecedent != 0) ?
                        (variation / totalPrecedent * 100) : 0;

                // Analyse par catégorie
                List<Categorie> categories = categorieDAO.getAllCategories();
                Map<Integer, String> categorieNames = categories.stream()
                        .collect(Collectors.toMap(Categorie::getId, Categorie::getNom));

                Map<String, Double> depensesParCategorie = depensesMoisCourant.stream()
                        .collect(Collectors.groupingBy(
                                d -> categorieNames.getOrDefault(d.getCategorieId(), "Inconnue"),
                                Collectors.summingDouble(Depense::getMontant)
                        ));

                // Préparation des résultats
                request.setAttribute("totalCourant", totalCourant);
                request.setAttribute("totalPrecedent", totalPrecedent);
                request.setAttribute("variation", variation);
                request.setAttribute("pourcentageVariation", pourcentageVariation);
                request.setAttribute("depensesParCategorie", depensesParCategorie);
                request.setAttribute("depenses", depensesMoisCourant);

                request.getRequestDispatcher("analyse.jsp").forward(request, response);

            } else if ("edit".equals(action)) {
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
                // Liste par défaut
                List<Depense> depenses = depenseDAO.getAll();
                request.setAttribute("depenses", depenses);
                request.getRequestDispatcher("list.jsp").forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("error", "Erreur lors du traitement: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("estConnecte") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
        }

        String action = request.getParameter("action");

        try {
            // Validation des paramètres
            if (request.getParameter("montant") == null || request.getParameter("date_depense") == null) {
                throw new ServletException("Paramètres manquants");
            }

            double montant = Double.parseDouble(request.getParameter("montant"));
            String description = request.getParameter("description");
            Date dateDepense = Date.valueOf(request.getParameter("date_depense"));
            int categorieId = Integer.parseInt(request.getParameter("categorie_id"));

            if ("create".equals(action)) {
                Depense depense = new Depense(0, montant, description, dateDepense, categorieId);
                depenseDAO.ajouterDepense(depense);

                // Envoi d'email
                try {
                    String to = "anaiarandrianantenaina@gmail.com";
                    String sujet = "Nouvelle dépense enregistrée";
                    String message = String.format(
                            "Une nouvelle dépense a été ajoutée:\n" +
                                    "Montant: %.2f Ariary\n" +
                                    "Description: %s\n" +
                                    "Date: %s\n" +
                                    "Catégorie ID: %d",
                            montant, description, dateDepense, categorieId
                    );

                    EmailSender.sendEmail(to, sujet, message);
                } catch (Exception e) {
                    System.err.println("Erreur lors de l'envoi d'email: " + e.getMessage());
                }

            } else if ("update".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                Depense depense = new Depense(id, montant, description, dateDepense, categorieId);
                depenseDAO.updateDepense(depense);

            } else if ("delete".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                depenseDAO.supprimerDepense(id);
            }

            response.sendRedirect(request.getContextPath() + "/depenses");

        } catch (NumberFormatException e) {
            request.setAttribute("error", "Format numérique invalide");
            request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
        } catch (IllegalArgumentException e) {
            request.setAttribute("error", "Format de date invalide (utilisez yyyy-MM-dd)");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Erreur: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
}