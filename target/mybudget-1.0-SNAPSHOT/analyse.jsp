<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Analyse des Dépenses</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            background-color: #000;
            color: #a3a3a3; /* neutral-400 */
        }
        .card {
            background-color: #262626; /* neutral-800 */
            border: 1px solid #404040;
        }
        .highlight {
            color: #f5f5f5; /* Texte plus visible */
        }
    </style>
</head>
<body class="min-h-screen">
    <div class="container mx-auto px-4 py-8 max-w-4xl">
        <!-- Header -->
        <div class="flex justify-between items-center mb-8">
            <h2 class="text-2xl font-bold highlight">
                <i class="fas fa-chart-pie mr-2"></i>Analyse des Dépenses
            </h2>
            <a href="depenses?action=list" class="text-neutral-400 hover:text-neutral-300">
                <i class="fas fa-arrow-right mr-1"></i> Retour à la liste
            </a>
        </div>

        <!-- Comparaison mensuelle -->
        <div class="card rounded-xl p-6 mb-8">
            <h3 class="text-xl font-semibold mb-4 highlight">
                <i class="fas fa-calendar-alt mr-2"></i>Comparaison mensuelle
            </h3>

            <div class="grid grid-cols-2 md:grid-cols-4 gap-4">
                <div class="border border-neutral-700 p-4 rounded-lg">
                    <p class="text-neutral-400 mb-1">Ce mois</p>
                    <p class="text-lg highlight">${totalCourants} Ar</p>
                </div>

                <div class="border border-neutral-700 p-4 rounded-lg">
                    <p class="text-neutral-400 mb-1">Mois dernier</p>
                    <p class="text-lg highlight">${totalPrecedent} Ar</p>
                </div>

                <div class="border border-neutral-700 p-4 rounded-lg">
                    <p class="text-neutral-400 mb-1">Variation</p>
                    <p class="text-lg highlight">${variation} Ar</p>
                </div>

                <div class="border border-neutral-700 p-4 rounded-lg">
                    <p class="text-neutral-400 mb-1">Pourcentage</p>
                    <p class="text-lg highlight">${pourcentageVariation}%</p>
                </div>
            </div>

            <div class="mt-6 text-center">
                <c:choose>
                    <c:when test="${variation > 0}">
                        <p class="highlight">
                            <i class="fas fa-arrow-up mr-2"></i>Augmentation des dépenses ce mois-ci
                        </p>
                    </c:when>
                    <c:when test="${variation < 0}">
                        <p class="highlight">
                            <i class="fas fa-arrow-down mr-2"></i>Diminution des dépenses ce mois-ci
                        </p>
                    </c:when>
                    <c:otherwise>
                        <p class="highlight">
                            <i class="fas fa-equals mr-2"></i>Dépenses stables
                        </p>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <!-- Détails par catégorie -->
        <div class="card rounded-xl p-6">
            <h3 class="text-xl font-semibold mb-4 highlight">
                <i class="fas fa-list-ul mr-2"></i>Répartition par catégorie
            </h3>

            <div class="overflow-x-auto">
                <table class="w-full">
                    <thead>
                        <tr class="border-b border-neutral-700">
                            <th class="text-left p-3 text-neutral-400">Catégorie</th>
                            <th class="text-left p-3 text-neutral-400">Montant</th>
                            <th class="text-left p-3 text-neutral-400">Pourcentage</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="entry" items="${depensesParCategorie}">
                            <tr class="border-b border-neutral-800 hover:bg-neutral-800/50">
                                <td class="p-3 highlight">${entry.key}</td>
                                <td class="p-3 highlight">${entry.value} Ar</td>
                                <td class="p-3 highlight">
                                    <c:set var="percentage" value="${(entry.value / totalCourants) * 100}"/>
                                    ${percentage.intValue()}%
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html>