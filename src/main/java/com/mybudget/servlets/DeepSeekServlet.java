package com.mybudget.servlets;

import com.google.gson.JsonObject;
import com.mybudget.service.DeepSeekService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/deepseek-chat")
public class DeepSeekServlet extends HttpServlet {

    private DeepSeekService deepSeekService;

    @Override
    public void init() throws ServletException {
        // Initialisation du service avec votre clé API
        String apiKey = "sk-e55b0326cbb7444d941e2cd71a20e678"; // À remplacer par votre vraie clé
        this.deepSeekService = new DeepSeekService(apiKey);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        JsonObject jsonResponse = new JsonObject();
        PrintWriter out = response.getWriter();

        try {
            String userMessage = request.getParameter("message");
            if (userMessage == null || userMessage.trim().isEmpty()) {
                response.setStatus(400);
                jsonResponse.addProperty("error", "Le message ne peut pas être vide");
                out.print(jsonResponse.toString());
                return;
            }

            String botResponse = deepSeekService.getChatResponse(userMessage);
            jsonResponse.addProperty("response", botResponse);
            out.print(jsonResponse.toString());

        } catch (Exception e) {
            response.setStatus(500);
            jsonResponse.addProperty("error", "Erreur de traitement");
            jsonResponse.addProperty("details", e.getMessage());
            out.print(jsonResponse.toString());
            e.printStackTrace(); // Log l'erreur dans les logs serveur
        } finally {
            out.close();
        }
    }
}