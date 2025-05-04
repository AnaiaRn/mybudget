<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Analyse des Dépenses</title>
</head>
<body>
    <h1>Résultats d'analyse</h1>

    <c:if test="${not empty resultatAnalyse}">
        <pre>${resultatAnalyse}</pre>
    </c:if>

    <c:if test="${not empty analyseResultats}">
        <h2>Comparaison mensuelle</h2>
        <p>Ce mois: ${analyseResultats.comparaison_mensuelle.total_courant} €</p>
        <p>Mois dernier: ${analyseResultats.comparaison_mensuelle.total_precedent} €</p>
    </c:if>
</body>
</html>