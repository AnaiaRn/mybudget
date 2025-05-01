package com.mybudget.dao;

import com.mybudget.models.Categorie;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CategorieDAO {

    public List<Categorie> getAllCategories() {
        List<Categorie> categories = new ArrayList<>();
        String sql = "SELECT * FROM categorie";

        try (Connection conn = ConnexionDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Categorie cat = new Categorie();
                cat.setId(rs.getInt("id"));
                cat.setNom(rs.getString("nom"));
                cat.setDescription(rs.getString("description"));
                categories.add(cat);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return categories;
    }

    public Categorie getCategorieById(int id) {
        Categorie cat = null;
        String sql = "SELECT * FROM categorie WHERE id = ?";

        try (Connection conn = ConnexionDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    cat = new Categorie();
                    cat.setId(rs.getInt("id"));
                    cat.setNom(rs.getString("nom"));
                    cat.setDescription(rs.getString("description"));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return cat;
    }
}
