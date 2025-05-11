<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>MyBudget - Accueil</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .card { margin-bottom: 20px; }
        .assistant { background-color: #f8f9fa; border-radius: 10px; padding: 15px; }
    </style>
</head>
<body>
    <div class="container mt-4">
        <!-- Message de bienvenue -->
        <div class="card">
            <div class="card-header bg-primary text-white">
                <h4>👋 Bienvenue, ${sessionScope.utilisateur.prenom} !</h4>
            </div>
            <div class="card-body">
                <p class="card-text">Bonne gestion pour ce mois de <fmt:formatDate value="${moisEnCours}" pattern="MMMM yyyy"/>.</p>
            </div>
        </div>

        <!-- Résumé du mois -->
        <div class="row">
            <div class="col-md-6">
                <div class="card">
                    <div class="card-header bg-info text-white">
                        <h5>📆 Résumé du mois</h5>
                    </div>
                    <div class="card-body">
                        <ul class="list-group list-group-flush">
                            <li class="list-group-item">Mois en cours : <fmt:formatDate value="${moisEnCours}" pattern="MMMM yyyy"/></li>
                            <li class="list-group-item">Budget mensuel : <fmt:formatNumber value="${budgetMensuel}" type="currency"/></li>
                            <li class="list-group-item">Total dépenses : <fmt:formatNumber value="${totalDepenses}" type="currency"/></li>
                            <li class="list-group-item">Reste disponible :
                                <span class="${resteDisponible < 0 ? 'text-danger' : 'text-success'}">
                                    <fmt:formatNumber value="${resteDisponible}" type="currency"/>
                                </span>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>

            <!-- Alertes & tendances -->
            <div class="col-md-6">
                <div class="card">
                    <div class="card-header bg-warning">
                        <h5>⚠️ Alertes & tendances</h5>
                    </div>
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${resteDisponible < 0}">
                                <div class="alert alert-danger">Dépassement de budget !</div>
                            </c:when>
                            <c:otherwise>
                                <div class="alert alert-success">Budget respecté</div>
                            </c:otherwise>
                        </c:choose>
                        <p>${messageTendances}</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Actions rapides -->
        <div class="card mt-4">
            <div class="card-header bg-success text-white">
                <h5>Actions</h5>
            </div>
            <div class="card-body text-center">
                <a href="${pageContext.request.contextPath}/depenses?action=create" class="btn btn-primary me-2">
                    ➕ Ajouter une dépense
                </a>
                <a href="${pageContext.request.contextPath}/depenses?action=list" class="btn btn-secondary">
                    📋 Voir la liste des dépenses
                </a>
            </div>
        </div>

        <!-- Assistant virtuel -->
        <div class="card mt-4">
            <div class="card-header bg-secondary text-white">
                <h5>💬 Assistant virtuel</h5>
            </div>
            <div class="card-body assistant">
                <div id="chat-messages" style="height: 150px; overflow-y: scroll; margin-bottom: 10px;">
                    <!-- Messages du chat -->
                </div>
                <div class="input-group">
                    <input type="text" id="question" class="form-control" placeholder="Posez votre question...">
                    <button class="btn btn-outline-primary" onclick="envoyerQuestion()">Envoyer</button>
                </div>
                <small class="text-muted">Exemples : "Montre mes dépenses", "Budget transport", etc.</small>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function envoyerQuestion() {
            const question = document.getElementById('question').value;
            const chat = document.getElementById('chat-messages');

            // Ajouter la question
            chat.innerHTML += `<div><strong>Vous:</strong> ${question}</div>`;

            // Simuler une réponse (à remplacer par un appel AJAX)
            const reponses = {
                "dépenses": `Vos dépenses ce mois: <fmt:formatNumber value="${totalDepenses}" type="currency"/>`,
                "transport": `Dépenses transport: <fmt:formatNumber value="${depensesTransport}" type="currency"/>`,
                "budget": `Reste disponible: <fmt:formatNumber value="${resteDisponible}" type="currency"/>`
            };

            let reponse = "Je peux répondre sur vos dépenses, budget, etc.";
            for (const [motCle, rep] of Object.entries(reponses)) {
                if (question.toLowerCase().includes(motCle)) {
                    reponse = rep;
                    break;
                }
            }

            chat.innerHTML += `<div><strong>Assistant:</strong> ${reponse}</div>`;
            chat.scrollTop = chat.scrollHeight;
            document.getElementById('question').value = '';
        }
    </script>
</body>
</html>
