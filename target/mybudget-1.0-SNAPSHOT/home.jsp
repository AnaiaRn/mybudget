<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>MyBudget - Tableau de Bord</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/chart.js@3.7.1/dist/chart.min.css">
    <style>
        .card {
            margin-bottom: 20px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            transition: transform 0.2s;
        }
        .card:hover {
            transform: translateY(-5px);
        }
        .assistant {
            background-color: #f8f9fa;
            border-radius: 10px;
            padding: 15px;
        }
        .progress-bar {
            transition: width 1s ease-in-out;
        }
        #chat-messages {
            height: 200px;
            overflow-y: auto;
            background-color: white;
            border-radius: 5px;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #dee2e6;
        }
        .message-you {
            background-color: #e3f2fd;
            padding: 8px;
            border-radius: 10px;
            margin-bottom: 5px;
            max-width: 80%;
        }
        .message-assistant {
            background-color: #f1f1f1;
            padding: 8px;
            border-radius: 10px;
            margin-bottom: 5px;
            max-width: 80%;
            margin-left: auto;
        }
    </style>
</head>
<body>
    <div class="container mt-4">
        <!-- Message de bienvenue -->
        <div class="card border-primary">
            <div class="card-header bg-primary text-white d-flex justify-content-between align-items-center">
                <h4 class="mb-0">👋 Bienvenue, ${sessionScope.utilisateur.prenom} !</h4>
                <span class="badge bg-light text-primary"><fmt:formatDate value="${moisEnCours}" pattern="MMMM yyyy"/></span>
            </div>
            <div class="card-body">
                <div class="row">
                    <div class="col-md-6">
                        <div class="d-flex align-items-center mb-3">
                            <div class="me-3">
                                <h5 class="mb-0"><fmt:formatNumber value="${totalDepenses}" type="currency"/></h5>
                                <small class="text-muted">Dépenses totales</small>
                            </div>
                            <div class="progress flex-grow-1" style="height: 20px;">
                                <div class="progress-bar bg-${resteDisponible >= 0 ? 'success' : 'danger'}"
                                     role="progressbar"
                                     style="width: ${(totalDepenses/budgetMensuel)*100}%"
                                     aria-valuenow="${(totalDepenses/budgetMensuel)*100}"
                                     aria-valuemin="0"
                                     aria-valuemax="100">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <h5 class="${resteDisponible < 0 ? 'text-danger' : 'text-success'}">
                            <fmt:formatNumber value="${resteDisponible}" type="currency"/>
                            <small class="d-block text-muted">Reste disponible</small>
                        </h5>
                    </div>
                </div>
            </div>
        </div>

        <!-- Graphique et analyse -->
        <div class="row mt-4">
            <div class="col-md-8">
                <div class="card">
                    <div class="card-header bg-info text-white">
                        <h5>📊 Analyse des dépenses</h5>
                    </div>
                    <div class="card-body">
                        <canvas id="depensesChart" height="250"></canvas>
                    </div>
                </div>
            </div>

            <div class="col-md-4">
                <div class="card h-100">
                    <div class="card-header bg-warning text-white">
                        <h5>⚠️ Alertes & Conseils</h5>
                    </div>
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${resteDisponible < 0}">
                                <div class="alert alert-danger">
                                    <strong>Dépassement de budget !</strong>
                                    <p>Vous avez dépensé <fmt:formatNumber value="${-resteDisponible}" type="currency"/> au-delà de votre budget.</p>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="alert alert-success">
                                    <strong>Budget respecté</strong>
                                    <p>Il vous reste <fmt:formatNumber value="${resteDisponible}" type="currency"/> ce mois-ci.</p>
                                </div>
                            </c:otherwise>
                        </c:choose>

                        <div class="mt-3">
                            <h6>Conseils personnalisés</h6>
                            <ul class="list-group list-group-flush">
                                <c:forEach items="${conseils}" var="conseil">
                                    <li class="list-group-item">✅ ${conseil}</li>
                                </c:forEach>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Actions rapides -->
        <div class="card mt-4">
            <div class="card-header bg-success text-white">
                <div class="d-flex justify-content-between align-items-center">
                    <h5 class="mb-0">Actions rapides</h5>
                    <div>
                        <span class="badge bg-light text-success">${depenses.size()} dépenses ce mois</span>
                    </div>
                </div>
            </div>
            <div class="card-body">
                <div class="d-grid gap-2 d-md-flex justify-content-md-center">
                    <a href="${pageContext.request.contextPath}/depenses?action=create" class="btn btn-primary me-md-2">
                        <i class="bi bi-plus-circle"></i> Ajouter une dépense
                    </a>
                    <a href="${pageContext.request.contextPath}/depenses?action=list" class="btn btn-outline-secondary">
                        <i class="bi bi-list-ul"></i> Voir toutes les dépenses
                    </a>
                    <a href="${pageContext.request.contextPath}/analyse" class="btn btn-outline-info">
                        <i class="bi bi-graph-up"></i> Analyse détaillée
                    </a>
                </div>
            </div>
        </div>

        <!-- Assistant virtuel amélioré -->
        <div class="card mt-4">
            <div class="card-header bg-secondary text-white">
                <h5>💬 Assistant Budgétaire</h5>
            </div>
            <div class="card-body assistant">
                <div id="chat-messages">
                    <div class="message-assistant">
                        Bonjour ${sessionScope.utilisateur.prenom} ! Comment puis-je vous aider aujourd'hui ?
                    </div>
                </div>
                <div class="input-group mt-3">
                    <input type="text" id="question" class="form-control" placeholder="Ex: Montre mes dépenses ce mois..."
                           aria-label="Question pour l'assistant" aria-describedby="button-envoyer">
                    <button class="btn btn-primary" type="button" id="button-envoyer" onclick="envoyerQuestion()">
                        Envoyer
                    </button>
                </div>
                <small class="text-muted d-block mt-2">
                    Exemples: "Budget transport", "Dépenses alimentation", "Comparaison avec le mois dernier"
                </small>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js@3.7.1/dist/chart.min.js"></script>
    <script>
        // Graphique des dépenses
        document.addEventListener('DOMContentLoaded', function() {
            const ctx = document.getElementById('depensesChart').getContext('2d');
            const chart = new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: ['Transport', 'Alimentation', 'Logement', 'Loisirs', 'Autres'],
                    datasets: [{
                        label: 'Dépenses par catégorie',
                        data: [${depensesTransport}, ${depensesAlimentation}, ${depensesLogement}, ${depensesLoisirs}, ${depensesAutres}],
                        backgroundColor: [
                            'rgba(54, 162, 235, 0.7)',
                            'rgba(255, 99, 132, 0.7)',
                            'rgba(75, 192, 192, 0.7)',
                            'rgba(255, 206, 86, 0.7)',
                            'rgba(153, 102, 255, 0.7)'
                        ],
                        borderColor: [
                            'rgba(54, 162, 235, 1)',
                            'rgba(255, 99, 132, 1)',
                            'rgba(75, 192, 192, 1)',
                            'rgba(255, 206, 86, 1)',
                            'rgba(153, 102, 255, 1)'
                        ],
                        borderWidth: 1
                    }]
                },
                options: {
                    responsive: true,
                    plugins: {
                        legend: {
                            position: 'top',
                        },
                        tooltip: {
                            callbacks: {
                                label: function(context) {
                                    return context.dataset.label + ': ' + context.raw.toLocaleString('fr-FR', {
                                        style: 'currency',
                                        currency: 'EUR'
                                    });
                                }
                            }
                        }
                    },
                    scales: {
                        y: {
                            beginAtZero: true,
                            ticks: {
                                callback: function(value) {
                                    return value.toLocaleString('fr-FR', {
                                        style: 'currency',
                                        currency: 'EUR'
                                    });
                                }
                            }
                        }
                    }
                }
            });
        });

        // Assistant virtuel amélioré
        function envoyerQuestion() {
            const question = document.getElementById('question').value.trim();
            if (!question) return;

            const chat = document.getElementById('chat-messages');

            // Ajouter la question de l'utilisateur
            const questionDiv = document.createElement('div');
            questionDiv.className = 'message-you';
            questionDiv.innerHTML = `<strong>Vous:</strong> ${question}`;
            chat.appendChild(questionDiv);

            // Simuler un chargement
            const loadingDiv = document.createElement('div');
            loadingDiv.className = 'message-assistant';
            loadingDiv.innerHTML = '<strong>Assistant:</strong> <em>Réflexion en cours...</em>';
            chat.appendChild(loadingDiv);

            // Simuler un délai de réponse
            setTimeout(() => {
                // Supprimer le message de chargement
                chat.removeChild(loadingDiv);

                // Générer une réponse en fonction de la question
                let reponse = generateResponse(question);

                // Ajouter la réponse
                const reponseDiv = document.createElement('div');
                reponseDiv.className = 'message-assistant';
                reponseDiv.innerHTML = `<strong>Assistant:</strong> ${reponse}`;
                chat.appendChild(reponseDiv);

                // Faire défiler vers le bas
                chat.scrollTop = chat.scrollHeight;
            }, 1000);

            // Effacer le champ de question
            document.getElementById('question').value = '';
        }

        function generateResponse(question) {
            const lowerQuestion = question.toLowerCase();
            const responses = {
                "dépenses": `Vos dépenses ce mois s'élèvent à <fmt:formatNumber value="${totalDepenses}" type="currency"/>.`,
                "transport": `Dépenses transport: <fmt:formatNumber value="${depensesTransport}" type="currency"/>`,
                "alimentation": `Dépenses alimentation: <fmt:formatNumber value="${depensesAlimentation}" type="currency"/>`,
                "budget": `Votre budget mensuel est de <fmt:formatNumber value="${budgetMensuel}" type="currency"/>. Il vous reste <fmt:formatNumber value="${resteDisponible}" type="currency"/>.`,
                "reste": `Il vous reste <fmt:formatNumber value="${resteDisponible}" type="currency"/> ce mois-ci.`,
                "comparer": `Comparaison avec le mois dernier: ${comparaisonMoisPrecedent}`
            };

            for (const [keyword, response] of Object.entries(responses)) {
                if (lowerQuestion.includes(keyword)) {
                    return response;
                }
            }

            return "Je peux vous informer sur vos dépenses, budget, et tendances. Posez-moi une question spécifique comme 'Montre mes dépenses en transport' ou 'Quel est mon budget restant'.";
        }
    </script>
</body>
</html>