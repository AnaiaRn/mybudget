package com.mybudget.service;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.google.gson.JsonSyntaxException;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import java.io.IOException;
import java.nio.charset.StandardCharsets;

public class DeepSeekService {
    private static final String API_URL = "https://api.deepseek.com/v1/chat/completions";
    private final String apiKey;

    public DeepSeekService(String apiKey) {
        this.apiKey = apiKey;
    }

    public String getChatResponse(String userMessage) throws Exception {
        try (CloseableHttpClient httpClient = HttpClients.createDefault()) {
            HttpPost request = new HttpPost(API_URL);

            // Headers
            request.setHeader("Content-Type", "application/json");
            request.setHeader("Authorization", "Bearer " + apiKey);

            // Body
            JsonObject requestBody = new JsonObject();
            requestBody.addProperty("model", "deepseek-chat");

            JsonArray messages = new JsonArray();
            JsonObject message = new JsonObject();
            message.addProperty("role", "user");
            message.addProperty("content", userMessage);
            messages.add(message);

            requestBody.add("messages", messages);
            requestBody.addProperty("temperature", 0.7);

            request.setEntity(new StringEntity(requestBody.toString()));

            // Execute
            try (CloseableHttpResponse response = httpClient.execute(request)) {
                int statusCode = response.getStatusLine().getStatusCode();
                String responseBody = EntityUtils.toString(response.getEntity());

                if (statusCode != 200) {
                    throw new IOException("API Error: " + statusCode + " - " + responseBody);
                }

                JsonObject jsonResponse = JsonParser.parseString(responseBody).getAsJsonObject();
                return jsonResponse.getAsJsonArray("choices")
                        .get(0).getAsJsonObject()
                        .getAsJsonObject("message")
                        .get("content").getAsString();
            }
        }
    }
}