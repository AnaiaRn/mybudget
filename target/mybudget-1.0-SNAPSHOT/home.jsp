<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>MyBudget - Accueil</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.5/xlsx.full.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body class="w-screen h-screen bg-black">
    <div class="flex flex-col min-h-screen">
        <!-- Header avec infos utilisateur -->
        <header class="flex justify-between items-center px-8 py-4 bg-neutral-900 border-b border-neutral-800">
            <div class="flex items-center space-x-2">
                <i class="fas fa-wallet text-blue-500 text-2xl"></i>
                <span class="text-white font-semibold text-xl">MyBudget</span>
            </div>

            <div class="flex items-center space-x-6">
                <div class="text-neutral-400">
                    <i class="fas fa-user-circle mr-2"></i>
                    <span>${sessionScope.utilisateur.email}</span>
                </div>
                <a href="${pageContext.request.contextPath}/logout"
                   class="flex items-center text-neutral-400 hover:text-white transition">
                    <i class="fas fa-sign-out-alt mr-2"></i>
                    Déconnexion
                </a>
            </div>
        </header>

        <!-- Section graphique -->
        <div class="flex justify-center items-center mt-4">
            <div class="w-[90%] h-[250px] border border-neutral-800 shadow-2xl rounded-xl bg-neutral-900 p-6">
                <div class="flex justify-between items-center mb-4">
                    <h3 class="text-white text-lg font-semibold">Aperçu de votre budget</h3>
                    <span class="text-neutral-400 text-sm">${java.time.LocalDate.now().getMonth()} ${java.time.LocalDate.now().getYear()}</span>
                </div>

                <div class="flex h-[80%] items-end space-x-4">
                    <!-- Barres du graphique (exemple) -->
                    <div class="flex-1 flex flex-col items-center">
                        <div class="w-full bg-blue-600 rounded-t hover:bg-blue-500 transition" style="height: 60%"></div>
                        <span class="text-neutral-400 text-xs mt-2">Alim.</span>
                    </div>
                    <div class="flex-1 flex flex-col items-center">
                        <div class="w-full bg-purple-600 rounded-t hover:bg-purple-500 transition" style="height: 40%"></div>
                        <span class="text-neutral-400 text-xs mt-2">Transp.</span>
                    </div>
                    <div class="flex-1 flex flex-col items-center">
                        <div class="w-full bg-green-600 rounded-t hover:bg-green-500 transition" style="height: 30%"></div>
                        <span class="text-neutral-400 text-xs mt-2">Logt.</span>
                    </div>
                    <div class="flex-1 flex flex-col items-center">
                        <div class="w-full bg-yellow-600 rounded-t hover:bg-yellow-500 transition" style="height: 50%"></div>
                        <span class="text-neutral-400 text-xs mt-2">Loisirs</span>
                    </div>
                    <div class="flex-1 flex flex-col items-center">
                        <div class="w-full bg-red-600 rounded-t hover:bg-red-500 transition" style="height: 20%"></div>
                        <span class="text-neutral-400 text-xs mt-2">Autres</span>
                    </div>
                </div>
            </div>
        </div>

        <!-- Cartes de fonctionnalités -->
        <div class="flex justify-center space-x-4 mt-10 text-white px-4">
            <div class="w-[400px] h-[300px] bg-neutral-950 rounded-2xl flex flex-col justify-center items-center p-6 shadow-lg border border-neutral-800 hover:border-neutral-700 transition">
                <i class="fas fa-plus-circle text-blue-500 text-4xl mb-4"></i>
                <p class="text-white text-[15px] text-center mb-6">
                    Chaque dépense compte ! <br /> Enregistrez-la ici en quelques clics.
                </p>
                <a href="${pageContext.request.contextPath}/depenses?action=create"
                   class="px-6 py-2 text-white rounded-lg border border-blue-500 bg-blue-500/10 hover:bg-blue-500/20 transition duration-300 text-[15px]">
                    Ajouter une dépense
                </a>
            </div>

            <div class="w-[400px] h-[300px] bg-neutral-950 rounded-2xl flex flex-col justify-center items-center p-6 shadow-lg border border-neutral-800 hover:border-neutral-700 transition">
                <i class="fas fa-list-alt text-purple-500 text-4xl mb-4"></i>
                <p class="text-white text-[15px] text-center mb-6">
                    Gardez un œil sur vos dépenses quotidiennes <br /> pour mieux gérer votre budget.
                </p>
                <a href="${pageContext.request.contextPath}/depenses?action=list"
                   class="px-6 py-2 text-white rounded-lg border border-purple-500 bg-purple-500/10 hover:bg-purple-500/20 transition duration-300 text-[15px]">
                    Voir la liste
                </a>
            </div>

            <div class="w-[400px] h-[300px] bg-neutral-950 rounded-2xl flex flex-col justify-center items-center p-6 shadow-lg border border-neutral-800 hover:border-neutral-700 transition">
                <i class="fas fa-chart-bar text-green-500 text-4xl mb-4"></i>
                <p class="text-white text-[15px] text-center mb-6">
                    Suivez vos finances chaque mois <br /> grâce à un rapport détaillé et automatique.
                </p>
                <a href="depenses?action=analyse" class="px-6 py-2 text-white rounded-lg border border-green-500 bg-green-500/10 hover:bg-green-500/20 transition duration-300 text-[15px]">
                    Rapport Mensuel
                </a>
            </div>

            <div class="w-[400px] h-[300px] bg-neutral-950 rounded-2xl flex flex-col justify-center items-center p-6 shadow-lg border border-neutral-800 hover:border-neutral-700 transition">
                <i class="fas fa-robot text-yellow-500 text-4xl mb-4"></i>
                <p class="text-white text-[15px] text-center mb-6">
                    Besoin d'aide ? <br />Posez votre question à l'assistant virtuel MyBudget.
                </p>
                <a href="${pageContext.request.contextPath}/chatbot.jsp"  class="px-6 py-2 text-white rounded-lg border border-yellow-500 bg-yellow-500/10 hover:bg-yellow-500/20 transition duration-300 text-[15px]">
                    Assistant virtuel
                </a>
            </div>
        </div>

        <!-- Footer -->
        <footer class="mt-auto py-4 text-center text-neutral-500 text-sm border-t border-neutral-800">
            © 2023 MyBudget - Tous droits réservés
        </footer>
    </div>
</body>
</html>