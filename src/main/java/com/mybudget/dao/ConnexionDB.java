package com.mybudget.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnexionDB {
    private static final String JDBC_URL = "jdbc:postgresql://localhost:5432/mybudget_db";
    private static final String DB_USER = "postgres";
    private static final String DB_PASSWORD = "nyavo";

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD);
    }
}
