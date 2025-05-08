<%@ page isErrorPage="true" contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Erreur</title>
</head>
<body>
    <h1>Erreur détectée</h1>
    <p>Message: ${requestScope['jakarta.servlet.error.message']}</p>
    <p><a href="${pageContext.request.contextPath}/login">Retour à l'accueil</a></p>
</body>
</html>