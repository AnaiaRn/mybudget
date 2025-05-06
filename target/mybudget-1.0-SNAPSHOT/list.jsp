<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.mybudget.models.Depense" %>
<html>
<head>
    <title>Liste des Dépenses</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.5/xlsx.full.min.js"></script>

</head>
<body class="bg-gray-100 text-gray-900">

<h2 class="text-3xl font-semibold text-center my-8">Liste des Dépenses</h2>

<div class="text-center mb-6">
    <a href="depenses?action=create" class="bg-blue-600 text-white py-2 px-4 rounded-lg hover:bg-blue-700 transition duration-300">Ajouter une dépense</a>
    <button class="bg-blue-600 text-white py-2 px-4 rounded-lg hover:bg-blue-700 transition duration-300" onclick="exportToExcel()">Exporter en Excel</button>
    <div style="position: absolute; top: 10px; right: 10px;">
        <a href="${pageContext.request.contextPath}/logout" class="btn btn-danger">
            <i class="fas fa-sign-out-alt"></i> Déconnexion
        </a>
        <span style="margin-left: 10px;">
            Connecté en tant que : ${sessionScope.utilisateur.email}
        </span>
    </div>

</div>


<table class="min-w-full bg-white border border-gray-300 rounded-lg shadow-md" id="table">
    <thead>
        <tr>
            <th class="px-6 py-3 text-left text-sm font-semibold text-gray-700 bg-gray-200">ID</th>
            <th class="px-6 py-3 text-left text-sm font-semibold text-gray-700 bg-gray-200">Montant</th>
            <th class="px-6 py-3 text-left text-sm font-semibold text-gray-700 bg-gray-200">Description</th>
            <th class="px-6 py-3 text-left text-sm font-semibold text-gray-700 bg-gray-200">Date</th>
            <th class="px-6 py-3 text-left text-sm font-semibold text-gray-700 bg-gray-200">Catégorie</th>
            <th class="px-6 py-3 text-left text-sm font-semibold text-gray-700 bg-gray-200">Actions</th>
        </tr>
    </thead>
    <tbody>
        <%
            List<Depense> depenses = (List<Depense>) request.getAttribute("depenses");
            if (depenses != null) {
                for (Depense d : depenses) {
        %>
        <tr class="border-b border-gray-200">
            <td class="px-6 py-3 text-sm text-gray-800"><%= d.getId() %></td>
            <td class="px-6 py-3 text-sm text-gray-800"><%= d.getMontant() %> Ariary</td>
            <td class="px-6 py-3 text-sm text-gray-800"><%= d.getDescription() %></td>
            <td class="px-6 py-3 text-sm text-gray-800"><%= d.getDate_depense() %></td>
            <td class="px-6 py-3 text-sm text-gray-800"><%= d.getCategorieId() %></td>
            <td class="px-6 py-3 text-sm text-gray-800"><%= d.getCategorie().getNom() %></td>

           <td class="px-6 py-3 text-sm text-blue-600">
               <a href="depenses?action=edit&id=<%= d.getId() %>" class="hover:text-blue-800">Modifier</a> |
<a href="depenses?action=delete&id=<%= d.getId() %>" class="hover:text-red-600">Supprimer</a>
           </td>


        </tr>
        <%
                }
            }
        %>
    </tbody>
</table>

</body>
</html>

<script>
function exportToExcel() {
    const originalTable = document.getElementById('table');
    const clone = originalTable.cloneNode(true); // Clone du tableau existant

    // Supprimer la dernière cellule (<th> ou <td>) de chaque ligne
    for (let row of clone.rows) {
        row.deleteCell(row.cells.length - 1);
    }

    // Convertir le tableau temporaire en Excel
    const wb = XLSX.utils.table_to_book(clone, { sheet: "Depenses" });
    XLSX.writeFile(wb, "liste_depenses.xlsx");
}
</script>
