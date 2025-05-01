package com.mybudget.models;

import com.sun.org.apache.bcel.internal.generic.RETURN;

public class Categorie {
    private int id;
    private String nom;
    private String description;

    public Categorie() {}

    public Categorie(int id, String nom) {
        this.id = id;
        this.nom = nom;
        this.description = description;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNom(){
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getDescription() {
        return description;
    }
    public void setDescription(String description) {
        this.description = description;
    }
}
