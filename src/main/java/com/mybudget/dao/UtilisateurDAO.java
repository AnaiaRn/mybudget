package com.mybudget.dao;

import com.mybudget.models.Utilisateur;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UtilisateurDAO {

    public Utilisateur getUtilisateurParEmailEtMotDePasse(String email, String mo_de_passe) {
        Utilisateur utilisateur = null;
        String sql = "SELECT * FROM utilisateur WHERE email = ? AND mot_de_passe = ?";

        try (Connection conn = ConnexionDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, email);
            stmt.setString(2, mo_de_passe);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                utilisateur = new Utilisateur();
                utilisateur.setId(rs.getInt("id"));
                utilisateur.setNom(rs.getString("nom"));
                utilisateur.setEmail(rs.getString("email"));
                utilisateur.setMot_de_passe(rs.getString("mot_de_passe"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return utilisateur;
    }
}
