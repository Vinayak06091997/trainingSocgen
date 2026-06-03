package com.example.backend;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import spark.Filter;
import spark.Request;
import spark.Response;
import spark.Spark;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class App {
    private static final Gson gson = new GsonBuilder().create();

    public static void main(String[] args) {
        int port = Integer.parseInt(System.getenv().getOrDefault("PORT", "8081"));
        Spark.port(port);
        Spark.before((request, response) -> response.type("application/json"));

        String dbUrl = System.getenv().getOrDefault("DB_URL", "jdbc:postgresql://localhost:5432/appdb");
        String dbUser = System.getenv().getOrDefault("DB_USER", "appuser");
        String dbPassword = System.getenv().getOrDefault("DB_PASSWORD", "password");

        initDatabase(dbUrl, dbUser, dbPassword);

        Spark.get("/api/users", (req, res) -> gson.toJson(listUsers(dbUrl, dbUser, dbPassword)));

        Spark.post("/api/users", (req, res) -> {
            User user = gson.fromJson(req.body(), User.class);
            if (user == null || user.name == null || user.name.isBlank()) {
                res.status(400);
                return gson.toJson(new ErrorResponse("name is required"));
            }
            addUser(dbUrl, dbUser, dbPassword, user);
            res.status(201);
            return gson.toJson(user);
        });

        Spark.get("/api/health", (req, res) -> gson.toJson(new HealthResponse("ok")));
    }

    private static Connection getConnection(String url, String user, String password) throws SQLException {
        return DriverManager.getConnection(url, user, password);
    }

    private static void initDatabase(String url, String user, String password) {
        try (Connection conn = getConnection(url, user, password);
             PreparedStatement stmt = conn.prepareStatement("CREATE TABLE IF NOT EXISTS users (id SERIAL PRIMARY KEY, name TEXT NOT NULL)") ) {
            stmt.execute();
        } catch (SQLException e) {
            throw new RuntimeException("Failed to initialize database", e);
        }
    }

    private static List<User> listUsers(String url, String user, String password) {
        List<User> users = new ArrayList<>();
        try (Connection conn = getConnection(url, user, password);
             PreparedStatement stmt = conn.prepareStatement("SELECT id, name FROM users ORDER BY id")) {
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                users.add(new User(rs.getInt("id"), rs.getString("name")));
            }
        } catch (SQLException e) {
            throw new RuntimeException("Failed to query users", e);
        }
        return users;
    }

    private static void addUser(String url, String user, String password, User newUser) {
        try (Connection conn = getConnection(url, user, password);
             PreparedStatement stmt = conn.prepareStatement("INSERT INTO users (name) VALUES (?)")) {
            stmt.setString(1, newUser.name);
            stmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Failed to add user", e);
        }
    }

    static class User {
        public Integer id;
        public String name;

        public User() {
        }

        public User(Integer id, String name) {
            this.id = id;
            this.name = name;
        }
    }

    static class ErrorResponse {
        public final String error;

        public ErrorResponse(String error) {
            this.error = error;
        }
    }

    static class HealthResponse {
        public final String status;

        public HealthResponse(String status) {
            this.status = status;
        }
    }
}
