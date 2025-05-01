package com.mybudget.models;

import java.util.Date;

public class Depense {
    private int id;
    private double montant;
    private Date date_depense;
    private String description;
    private int utilisateurId;
    private int categorieId;

    //Constructeur

    public Depense() {}

    public Depense(int id, double montant, String description, Date date_depense, int categorieId) {
        this.id = id;
        this.montant = montant;
        this.description = description;
        this.date_depense = date_depense;
        this.categorieId = categorieId;
    }


    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }

    public double getMontant() {
        return montant;
    }
    public void setMontant(Double montant) {
        this.montant = montant;
    }

    public Date getDate_depense() {
        return date_depense;
    }
    public void setDate_depense(Date date_depense) {
        this.date_depense = date_depense;
    }

    public String getDescription() {
        return description;
    }
    public void setDescription(String description) {
        this.description = description;
    }

    public int getUtilisateurId() {
        return utilisateurId;
    }
    public void setUtilisateurId(int utilisateurId) {
        this.utilisateurId = utilisateurId;
    }

    public int getCategorieId() {
        return categorieId;
    }
    public void setCategorieId(int categorieId) {
        this.categorieId = categorieId;
    }
}
