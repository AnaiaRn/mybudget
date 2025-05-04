<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Analyse des Dépenses</title>
</head>
<body>
    <h1>Resultats d'analyse</h1>

    <c:if test="${not empty totalCourants}">
        <h2>Comparaison mensuelle</h2>
        <p><strong>Ce mois :</strong> ${totalCourants} ariary</p>
        <p><strong>Mois dernier :</strong> ${totalPrecedent} ariary</p>
        <p><strong>Variation :</strong> ${variation} ariary</p>
        <p><strong>Pourcentage de variation :</strong> ${pourcentageVariation}%</p>

        <c:choose>
            <c:when test="${variation > 0}">
                <p style="color: red;">Les depenses ont augmente ce mois-ci.</p>
            </c:when>
            <c:when test="${variation < 0}">
                <p style="color: green;">Les depenses ont diminue ce mois-ci.</p>
            </c:when>
            <c:otherwise>
                <p>Les depenses sont restees stables par rapport au mois precedent.</p>
            </c:otherwise>
        </c:choose>
    </c:if>
</body>
</html>
