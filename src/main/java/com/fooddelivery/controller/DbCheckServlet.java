package com.fooddelivery.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fooddelivery.config.DBConnection;

@WebServlet("/dbcheck")
public class DbCheckServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/plain");
        PrintWriter out = resp.getWriter();

        try (Connection con = DBConnection.getConnection()) {
            out.println("Database Connection: SUCCESS");
            
            // 1. Check Orders Table Schema
            out.println("\n--- Table Schema: `Orders` ---");
            try {
                DatabaseMetaData meta = con.getMetaData();
                ResultSet columns = meta.getColumns(null, null, "orders", null); // Case insensitive often needed
                // If empty, try "Orders"
                if (!columns.isBeforeFirst()) { 
                     columns = meta.getColumns(null, null, "Orders", null);
                }
                
                while(columns.next()) {
                    String name = columns.getString("COLUMN_NAME");
                    String type = columns.getString("TYPE_NAME");
                    out.println(name + " (" + type + ")");
                }
            } catch (Exception e) {
                out.println("Error reading metadata: " + e.getMessage());
            }

            // 2. Check Recent Data
            out.println("\n--- Recent 5 Rows in `Orders` ---");
            try (Statement stmt = con.createStatement();
                 ResultSet rs = stmt.executeQuery("SELECT * FROM Orders ORDER BY orderId DESC LIMIT 5")) {
                 
                 ResultSetMetaData rsMeta = rs.getMetaData();
                 int colCount = rsMeta.getColumnCount();
                 
                 // Header
                 for(int i=1; i<=colCount; i++) {
                     out.print(rsMeta.getColumnName(i) + "\t|\t");
                 }
                 out.println();
                 out.println(String.join("", java.util.Collections.nCopies(50, "-")));

                 while(rs.next()) {
                     for(int i=1; i<=colCount; i++) {
                         out.print(rs.getObject(i) + "\t|\t");
                     }
                     out.println();
                 }
            }

            // 3. Check User Table Schema
            out.println("\n--- Table Schema: `user` ---");
            try {
                DatabaseMetaData meta = con.getMetaData();
                ResultSet columns = meta.getColumns(null, null, "user", null);
                if (!columns.next()) {
                     columns = meta.getColumns(null, null, "User", null); // Try capitalized
                } else {
                    // Reset cursor if possible or just print the first one we found
                     String name = columns.getString("COLUMN_NAME");
                     String type = columns.getString("TYPE_NAME");
                     out.println(name + " (" + type + ")");
                }
                
                while(columns.next()) {
                    String name = columns.getString("COLUMN_NAME");
                    String type = columns.getString("TYPE_NAME");
                    out.println(name + " (" + type + ")");
                }
            } catch (Exception e) {
                out.println("Error reading metadata: " + e.getMessage());
            }

            // 4. Check User Data (First 1)
            out.println("\n--- Recent 1 Row in `User` ---");
            try (Statement stmt = con.createStatement();
                 ResultSet rs = stmt.executeQuery("SELECT * FROM User LIMIT 1")) {
                 if(rs.next()) {
                     ResultSetMetaData rsMeta = rs.getMetaData();
                     int colCount = rsMeta.getColumnCount();
                     for(int i=1; i<=colCount; i++) {
                         out.println(rsMeta.getColumnName(i) + ": " + rs.getObject(i) + " (" + rsMeta.getColumnTypeName(i) + ")");
                     }
                 } else {
                     out.println("No users found.");
                 }
            }

        } catch (SQLException e) {
            out.println("Database Connection FAILED");
            e.printStackTrace(out);
        }
    }
}

