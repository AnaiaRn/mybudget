package com.mybudget.utils;

import java.util.ArrayList;
import java.util.List;

public class AnalyseDepense {

    public static List<String> detecterAnomalies(List<Double> depenses, String categorie) {
        List<String> alertes = new ArrayList<>();

        if (depenses == null || depenses.size() < 3) {
            alertes.add("Pas assez de données pour analyser les tendances.");
            return alertes;
        }

        double moyenne = depenses.stream().mapToDouble(Double::doubleValue).average().orElse(0.0);
        double ecartype = Math.sqrt(depenses.stream()
                .mapToDouble(d -> Math.pow(d - moyenne, 2))
                .average().orElse(0.0));

        for (int i = 0; i < depenses.size(); i++) {
            double sZore = (depenses.get(i) - moyenne) / ecartype;
            if (Math.abs(sZore) > 2) {
                alertes.add("Anomalies détectées pour les mois" + (i + 1) + "en catégorie" + categorie +
                        "dépense : " + depenses.get(i) + "Ariary");
            }
        }
        return alertes;
    }
}
