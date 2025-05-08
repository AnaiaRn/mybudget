<%@ page isErrorPage="true" contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Erreur - Application</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8d7da;
            color: #721c24;
            padding: 50px;
        }
        .error-container {
            background-color: #f5c6cb;
            border: 1px solid #f1b0b7;
            padding: 30px;
            border-radius: 10px;
        }
        h1 {
            font-size: 2em;
        }
        .details {
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div class="error-container">
        <h1>Une erreur est survenue</h1>
        <p>Nous sommes désolés, une erreur s’est produite lors du traitement de votre demande.</p>

        <div class="details">
            <%-- Affiche le message de l’exception si elle est disponible --%>
            <% if (exception != null) { %>
                <strong>Message d'erreur :</strong> <%= exception.getMessage() %><br>
                <strong>Type d'erreur :</strong> <%= exception.getClass().getName() %>
            <% } else { %>
                <strong>Détails :</strong> Aucune information sur l'erreur n'est disponible.
            <% } %>
        </div>
    </div>
</body>
</html>
