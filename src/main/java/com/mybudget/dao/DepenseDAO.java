package com.mybudget.dao;

import com.mybudget.models.Depense;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DepenseDAO {

    public void ajouterDepense(Depense depense) {
        String sql = "INSERT INTO depense (montant, date_depense, description, utilisateur_id, categorie_id) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = ConnexionDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setDouble(1, depense.getMontant());
            stmt.setDate(2, new java.sql.Date(depense.getDate_depense().getTime()));
            stmt.setString(3, depense.getDescription());

            stmt.setInt(4, 1); // ✅ Utilisateur par défaut
            stmt.setInt(5, depense.getCategorieId());

            stmt.executeUpdate();
            System.out.println("✅ Dépense insérée avec utilisateur_id = 1");


    } catch (SQLException e) {
            System.err.println("❌ Erreur SQL lors de l'insertion : " + e.getMessage());
            e.printStackTrace();
        }
    }




    public List<Depense> getAll() {
        List<Depense> depenses = new ArrayList<>();
        String sql = "SELECT * FROM depense";

        try (Connection conn = ConnexionDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Depense d = new Depense();
                d.setId(rs.getInt("id"));
                d.setMontant(rs.getDouble("montant"));
                d.setDate_depense(rs.getDate("date_depense"));
                d.setDescription(rs.getString("description")); // ✅
                d.setUtilisateurId(rs.getInt("utilisateur_id"));
                d.setCategorieId(rs.getInt("categorie_id"));
                depenses.add(d);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return depenses;
    }


    public Depense getById(int id) {
        Depense d = null;
        String sql = "SELECT * FROM depense WHERE id = ?";

        try (Connection conn = ConnexionDB.getConnection();
        PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    d = new Depense();
                    d.setId(rs.getInt("id"));
                    d.setMontant(rs.getDouble("montant"));
                    d.setDate_depense(rs.getDate("date_depense"));
                    d.setDescription(rs.getString("description"));
                    d.setUtilisateurId(rs.getInt("utiilisateur_id"));
                    d.setCategorieId(rs.getInt("categorie_id"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return d;
    }

    public void updateDepense(Depense depense) {
        String sql = "UPDATE depense SET montant = ?, date_depense = ?, description = ?, categorie_id = ? WHERE id = ?";
        try (Connection conn = ConnexionDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setDouble(1, depense.getMontant());
            stmt.setDate(2, new java.sql.Date(depense.getDate_depense().getTime()));
            stmt.setString(3, depense.getDescription());
            stmt.setInt(4, depense.getCategorieId());
            stmt.setInt(5, depense.getId());

            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void supprimerDepense(int id) {
        String sql = "DELETE FROM depense WHERE id = ?";
        try (Connection conn = ConnexionDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }



}
