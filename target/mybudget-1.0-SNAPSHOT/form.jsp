<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.mybudget.models.Depense" %>
<%@ page import="com.mybudget.models.Categorie" %>
<%@ page import="java.util.List" %>
<%
    Depense d = (Depense) request.getAttribute("depense");
    List<Categorie> categories = (List<Categorie>) request.getAttribute("categories");
%>
<!DOCTYPE html>
<html>
<head>
    <title><%= request.getAttribute("depense") != null ? "Modifier" : "Ajouter" %> une dépense</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="bg-black text-gray-200 min-h-screen">
    <div class="container mx-auto px-4 py-8 max-w-2xl">
        <!-- Header -->
        <div class="flex justify-between items-center mb-8">
            <h2 class="text-2xl font-bold">
                <i class="fas fa-<%= request.getAttribute("depense") != null ? "edit" : "plus-circle" %> mr-2"></i>
                <%= request.getAttribute("depense") != null ? "Modifier" : "Ajouter" %> une dépense
            </h2>
            <a href="depenses?action=list" class="text-sm text-neutral-400 hover:text-white">
                <i class="fas fa-arrow-right mr-1"></i> Voir la liste
            </a>
        </div>

        <!-- Formulaire -->
        <form method="post" action="depenses" class="bg-neutral-900 border border-neutral-800 rounded-xl p-6 shadow-lg">
            <input type="hidden" name="action" value="<%= (d != null) ? "update" : "create" %>">
            <input type="hidden" name="id" value="<%= (d != null) ? d.getId() : "" %>">

            <!-- Champ Montant -->
            <div class="mb-4">
                <label class="block text-sm font-medium mb-2">Montant (Ariary)</label>
                <div class="relative">
                    <span class="absolute inset-y-0 left-0 flex items-center pl-3 text-neutral-400">
                        Ar
                    </span>
                    <input type="number" name="montant"
                           value="<%= (d != null) ? d.getMontant() : "" %>"
                           class="w-full bg-neutral-800 border border-neutral-700 rounded-lg py-2 pl-10 pr-4 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                           placeholder="0.00"
                           step="0.01"
                           required>
                </div>
            </div>

            <!-- Champ Description -->
            <div class="mb-4">
                <label class="block text-sm font-medium mb-2">Description</label>
                <input type="text" name="description"
                       value="<%= (d != null) ? d.getDescription() : "" %>"
                       class="w-full bg-neutral-800 border border-neutral-700 rounded-lg py-2 px-4 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                       placeholder="Décrivez cette dépense"
                       required>
            </div>

            <!-- Champ Date -->
            <div class="mb-4">
                <label class="block text-sm font-medium mb-2">Date</label>
                <div class="relative">
                    <i class="fas fa-calendar absolute left-3 top-3 text-neutral-400"></i>
                    <input type="date" name="date_depense"
                           value="<%= (d != null) ? d.getDate_depense() : "" %>"
                           class="w-full bg-neutral-800 border border-neutral-700 rounded-lg py-2 pl-10 pr-4 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                           required>
                </div>
            </div>

            <!-- Champ Catégorie -->
            <div class="mb-6">
                <label class="block text-sm font-medium mb-2">Catégorie</label>
                <div class="relative">
                    <i class="fas fa-tag absolute left-3 top-3 text-neutral-400"></i>
                    <select name="categorie_id"
                            class="w-full bg-neutral-800 border border-neutral-700 rounded-lg py-2 pl-10 pr-4 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent appearance-none"
                            required>
                        <% if (categories != null) {
                            for (Categorie c : categories) { %>
                            <option value="<%= c.getId() %>"
                                <%= (d != null && d.getCategorieId() == c.getId()) ? "selected" : "" %>>
                                <%= c.getNom() %>
                            </option>
                        <%  }
                        } %>
                    </select>
                    <i class="fas fa-chevron-down absolute right-3 top-3 text-neutral-400"></i>
                </div>
            </div>

            <!-- Bouton Soumettre -->
            <button type="submit"
                    class="w-full bg-blue-600 hover:bg-blue-700 text-white font-medium py-2 px-4 rounded-lg transition duration-300">
                <i class="fas fa-save mr-2"></i>
                <%= (d != null) ? "Mettre à jour" : "Enregistrer" %>
            </button>
        </form>
    </div>
</body>
</html>