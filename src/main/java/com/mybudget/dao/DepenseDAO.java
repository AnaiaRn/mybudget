package com.mybudget.dao;

import com.mybudget.models.Depense;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DepenseDAO {

    private Connection getConnection() throws SQLException {
        return ConnexionDB.getConnection();
    }

    public List<Depense> findAll() {
        List<Depense> liste = new ArrayList<>();
        String sql = "SELECT * FROM depense";
        try (Connection conn = getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)
        ) {
            while (rs.next()) {
                Depense d = new Depense();
                d.setId(rs.getInt("id"));
                d.setMontant(rs.getDouble("montant"));
                d.setDate_depense(rs.getDate("date_depense"));
                d.setDescription(rs.getString("decription"));
                d.setUtilisateurId(rs.getInt("utilisateur_id"));
                d.setCategorieId(rs.getInt("categorie_id"));
                liste.add(d);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return liste;
    }

    public Depense findById(int id) {
        Depense d = null;
        String sql = "SELECT * FROM depense WHERE id= ? ";

        try (Connection conn =  getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    d = new Depense();
                    d.setId(rs.getInt("id"));
                    d.setMontant(rs.getDouble("montant"));
                    d.setDate_depense(rs.getDate("date_depense"));
                    d.setDescription(rs.getString("description"));
                    d.setUtilisateurId(rs.getInt("utilisateur_id"));
                    d.setCategorieId(rs.getInt("categorie_id"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return d;
    }

    public boolean save(Depense d) {
        String sql = "INSERT INTO depense (montant, date_depense, description, utilisateur_id, categorie_id) VALUES (?,?,?,?,?)";
        try (Connection conn = getConnection();
        PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setDouble(1, d.getMontant());
            ps.setDate(2, new java.sql.Date(d.getDate_depense().getTime()));
            ps.setString(3, d.getDescription());
            ps.setInt(4, d.getUtilisateurId());
            ps.setInt(5, d.getCategorieId());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    
}
