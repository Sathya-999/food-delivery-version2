package com.fooddelivery.config;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class DBConnection {
    private static Properties properties = new Properties();

    static {
        try (InputStream input = DBConnection.class.getClassLoader().getResourceAsStream("application.properties")) {
            if (input == null) {
                System.out.println("Sorry, unable to find application.properties");
                // Fallback (Not recommended for prod, but keeps it working if file invalid)
                properties.setProperty("db.url", "jdbc:mysql://localhost:3306/fooddelivery");
                properties.setProperty("db.username", "root");
                properties.setProperty("db.password", "root");
                properties.setProperty("db.driver", "com.mysql.cj.jdbc.Driver");
            } else {
                properties.load(input);
            }
            Class.forName(properties.getProperty("db.driver"));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(
            properties.getProperty("db.url"),
            properties.getProperty("db.username"),
            properties.getProperty("db.password")
        );
    }
}

