package com.mybudget.models;

public class Utilisateur {
    private int id;
    private String nom;
    private String email;
    private String mot_de_passe;

    // Constructeur vide
    public Utilisateur() {
    }

    // Constructeur avec paramètres
    public Utilisateur(int id, String nom, String email, String mot_de_passe) {
        this.id = id;
        this.nom = nom;
        this.email = email;
        this.mot_de_passe = mot_de_passe;
    }

    // Getters et setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getMot_de_passe() {
        return mot_de_passe;
    }

    public void setMot_de_passe(String mot_de_passe) {
        this.mot_de_passe = mot_de_passe;
    }
}
