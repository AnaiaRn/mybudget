<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Analyse des Dépenses</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <style>
        .positive { color: #ef4444; } /* Rouge pour augmentation */
        .negative { color: #10b981; } /* Vert pour diminution */
        .neutral { color: #d1d5db; } /* Gris neutre */
        #piechart {
            width: 100%;
            height: 500px;
            border-radius: 0.5rem;
            background-color: #1f2937;
        }
        .google-visualization-tooltip {
            background-color: #1f2937 !important;
            border: 1px solid #374151 !important;
            color: #f3f4f6 !important;
        }
    </style>
</head>
<body class="bg-gray-900 text-gray-100 min-h-screen p-6">
    <div class="max-w-6xl mx-auto">
        <!-- En-tête -->
        <div class="flex justify-between items-center mb-8 border-b border-gray-700 pb-4">
            <h1 class="text-2xl font-bold">
                <i class="fas fa-chart-pie mr-2"></i>Analyse des Dépenses
            </h1>
            <a href="depenses?action=list" class="text-sm text-gray-400 hover:text-white">
                <i class="fas fa-arrow-left mr-1"></i> Retour aux dépenses
            </a>
        </div>

        <!-- Section Comparaison Mensuelle -->
        <c:if test="${not empty totalCourants}">
            <div class="bg-gray-800 rounded-lg shadow-lg p-6 mb-8 border border-gray-700">
                <h2 class="text-xl font-semibold mb-4 flex items-center">
                    <i class="fas fa-calendar-alt mr-2"></i>Comparaison mensuelle
                </h2>

                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
                    <div class="bg-gray-700 p-4 rounded-lg">
                        <p class="text-sm text-gray-400">Ce mois</p>
                        <p class="text-2xl font-bold">${totalCourants} Ar</p>
                    </div>

                    <div class="bg-gray-700 p-4 rounded-lg">
                        <p class="text-sm text-gray-400">Mois dernier</p>
                        <p class="text-2xl font-bold">${totalPrecedent} Ar</p>
                    </div>

                    <div class="bg-gray-700 p-4 rounded-lg">
                        <p class="text-sm text-gray-400">Variation</p>
                        <p class="text-2xl font-bold">${variation} Ar</p>
                    </div>

                    <div class="bg-gray-700 p-4 rounded-lg">
                        <p class="text-sm text-gray-400">Pourcentage</p>
                        <p class="text-2xl font-bold">${pourcentageVariation}%</p>
                    </div>
                </div>

                <div class="mt-6 text-center">
                    <c:choose>
                        <c:when test="${variation > 0}">
                            <p class="text-lg positive">
                                <i class="fas fa-arrow-up mr-2"></i>Les dépenses ont augmenté ce mois-ci.
                            </p>
                        </c:when>
                        <c:when test="${variation < 0}">
                            <p class="text-lg negative">
                                <i class="fas fa-arrow-down mr-2"></i>Les dépenses ont diminué ce mois-ci.
                            </p>
                        </c:when>
                        <c:otherwise>
                            <p class="text-lg neutral">
                                <i class="fas fa-equals mr-2"></i>Les dépenses sont stables.
                            </p>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </c:if>

        <!-- Graphique -->
        <div class="bg-gray-800 rounded-lg shadow-lg p-6 mb-8 border border-gray-700">
            <h2 class="text-xl font-semibold mb-4 flex items-center">
                <i class="fas fa-chart-pie mr-2"></i>Répartition par catégorie
            </h2>
            <div id="piechart"></div>
        </div>

        <!-- Détails par catégorie -->
        <div class="bg-gray-800 rounded-lg shadow-lg p-6 border border-gray-700">
            <h2 class="text-xl font-semibold mb-4 flex items-center">
                <i class="fas fa-list-ul mr-2"></i>Détails des dépenses
            </h2>

            <div class="overflow-x-auto">
                <table class="min-w-full divide-y divide-gray-700">
                    <thead class="bg-gray-700">
                        <tr>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-300 uppercase tracking-wider">Catégorie</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-300 uppercase tracking-wider">Montant</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-300 uppercase tracking-wider">Pourcentage</th>
                        </tr>
                    </thead>
                    <tbody class="bg-gray-800 divide-y divide-gray-700">
                        <c:forEach var="entry" items="${depensesParCategorie}">
                            <tr>
                                <td class="px-6 py-4 whitespace-nowrap">${entry.key}</td>
                                <td class="px-6 py-4 whitespace-nowrap">${entry.value} Ar</td>
                                <td class="px-6 py-4 whitespace-nowrap">
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

    <script type="text/javascript">
        google.charts.load('current', {'packages':['corechart']});
        google.charts.setOnLoadCallback(drawChart);

        function drawChart() {
            const data = google.visualization.arrayToDataTable([
                ['Catégorie', 'Montant'],
                <c:forEach var="entry" items="${depensesParCategorie}">
                    ['${entry.key}', ${entry.value}],
                </c:forEach>
            ]);

            const options = {
                title: 'Répartition des dépenses',
                titleTextStyle: {
                    color: '#f3f4f6',
                    fontSize: 16
                },
                backgroundColor: '#1f2937',
                legend: {
                    textStyle: {
                        color: '#f3f4f6'
                    }
                },
                colors: ['#3b82f6', '#10b981', '#f59e0b', '#ef4444', '#8b5cf6', '#ec4899'],
                pieSliceTextStyle: {
                    color: '#111827'
                },
                chartArea: {
                    width: '90%',
                    height: '80%'
                }
            };

            const chart = new google.visualization.PieChart(document.getElementById('piechart'));
            chart.draw(data, options);
        }
    </script>
</body>
</html>