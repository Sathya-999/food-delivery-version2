package com.fooddelivery.config;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class DBConnection {
    private static Properties properties = new Properties();

    static {
        try {
            // First, check for environment variables (Railway/Cloud deployment)
            String envDbUrl = System.getenv("DATABASE_URL");
            String envDbHost = System.getenv("MYSQL_HOST");
            String envDbPort = System.getenv("MYSQL_PORT");
            String envDbName = System.getenv("MYSQL_DATABASE");
            String envDbUser = System.getenv("MYSQL_USER");
            String envDbPass = System.getenv("MYSQL_PASSWORD");
            
            if (envDbUrl != null && !envDbUrl.isEmpty()) {
                // Use DATABASE_URL directly if provided
                properties.setProperty("db.url", envDbUrl);
                properties.setProperty("db.username", envDbUser != null ? envDbUser : "root");
                properties.setProperty("db.password", envDbPass != null ? envDbPass : "");
                properties.setProperty("db.driver", "com.mysql.cj.jdbc.Driver");
                System.out.println("Using DATABASE_URL from environment");
            } else if (envDbHost != null && !envDbHost.isEmpty()) {
                // Build URL from individual environment variables
                String port = envDbPort != null ? envDbPort : "3306";
                String dbName = envDbName != null ? envDbName : "railway";
                String url = "jdbc:mysql://" + envDbHost + ":" + port + "/" + dbName + "?useSSL=true&allowPublicKeyRetrieval=true";
                properties.setProperty("db.url", url);
                properties.setProperty("db.username", envDbUser != null ? envDbUser : "root");
                properties.setProperty("db.password", envDbPass != null ? envDbPass : "");
                properties.setProperty("db.driver", "com.mysql.cj.jdbc.Driver");
                System.out.println("Using MySQL environment variables: " + envDbHost + ":" + port + "/" + dbName);
            } else {
                // Fall back to application.properties for local development
                InputStream input = DBConnection.class.getClassLoader().getResourceAsStream("application.properties");
                if (input == null) {
                    System.out.println("Sorry, unable to find application.properties");
                    // Fallback defaults for local development
                    properties.setProperty("db.url", "jdbc:mysql://localhost:3306/fooddelivery");
                    properties.setProperty("db.username", "root");
                    properties.setProperty("db.password", "root");
                    properties.setProperty("db.driver", "com.mysql.cj.jdbc.Driver");
                } else {
                    properties.load(input);
                    input.close();
                }
                System.out.println("Using local application.properties");
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

