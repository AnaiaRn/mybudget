<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.mybudget.models.Depense" %>
<html>
<head>
    <title>Liste des Dépenses</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.5/xlsx.full.min.js"></script>
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css">
    <script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
    <style>
        .dataTables_wrapper .dataTables_filter {
            display: none; /* Cache la recherche intégrée de DataTables */
        }
        .dataTables_wrapper .dataTables_paginate .paginate_button {
            color: #a3a3a3 !important;
            border: 1px solid #525252 !important;
            margin-left: 2px;
            border-radius: 0.375rem;
        }
        .dataTables_wrapper .dataTables_paginate .paginate_button.current {
            background: #404040 !important;
            color: white !important;
            border: 1px solid #525252 !important;
        }
        .dataTables_wrapper .dataTables_paginate .paginate_button:hover {
            background: #404040 !important;
            color: white !important;
            border: 1px solid #525252 !important;
        }
        .dataTables_wrapper .dataTables_length select {
            background-color: #262626;
            border: 1px solid #525252;
            color: white;
            border-radius: 0.375rem;
            padding: 0.25rem 0.5rem;
        }
        .dataTables_wrapper .dataTables_info {
            color: #a3a3a3 !important;
        }
    </style>
</head>
<body class="w-screen h-screen bg-black flex justify-center items-center">
    <div class="w-[80%] h-[80%] bg-neutral-950 relative flex flex-col">
        <!-- Info utilisateur discrète en haut -->
        <div class="text-right pt-2 pr-2">
            <span class="text-neutral-500 text-xs">
                Connecté: <span class="text-neutral-400">${sessionScope.utilisateur.email}</span>
            </span>
        </div>

        <!-- Contenu principal -->
        <div class="flex-grow">
            <!-- Filtre - Une seule ligne avec recherche, catégorie, export et réinitialisation -->
            <div class="flex justify-between items-center text-white mt-4 px-8">
                <!-- Recherche globale unique -->
                <div class="flex-1 mr-4">
                    <input type="text" id="globalSearch" class="w-full px-3 py-2 border border-neutral-600 rounded-md bg-neutral-900 text-neutral-200" placeholder="Rechercher..." />
                </div>

                <!-- Select par catégorie -->
                <div class="flex-1 mr-4">
                    <select id="categoryFilter" class="w-full px-3 py-2 border border-neutral-600 rounded-md bg-neutral-900 text-neutral-200">
                        <option value="">Toutes catégories</option>
                        <option value="Alimentation">Alimentation</option>
                        <option value="Transport">Transport</option>
                        <option value="Loisirs">Loisirs</option>
                        <option value="Logement">Logement</option>
                    </select>
                </div>

                <!-- Exportation excel -->
                <div class="flex-1 mr-4">
                    <button id="export" class="w-full px-3 py-2 border border-neutral-600 rounded-md bg-neutral-900 text-neutral-200 hover:bg-neutral-800 transition">Export Excel</button>
                </div>

                <!-- Réinitialiser -->
                <div class="flex-1">
                    <button id="reinitialiser" class="w-full px-3 py-2 border border-neutral-600 rounded-md bg-neutral-900 text-neutral-200 hover:bg-neutral-800 transition">Réinitialiser</button>
                </div>
            </div>

            <!-- Tableau -->
            <div class="mt-6 px-4">
                <table id="depensesTable" class="min-w-full bg-neutral-950 rounded-lg">
                    <thead>
                        <tr>
                            <th class="px-6 py-3 text-left text-sm font-semibold bg-neutral-800 text-neutral-500">ID</th>
                            <th class="px-6 py-3 text-left text-sm font-semibold bg-neutral-800 text-neutral-500">Montant</th>
                            <th class="px-6 py-3 text-left text-sm font-semibold bg-neutral-800 text-neutral-500">Description</th>
                            <th class="px-6 py-3 text-left text-sm font-semibold bg-neutral-800 text-neutral-500">Date</th>
                            <th class="px-6 py-3 text-left text-sm font-semibold bg-neutral-800 text-neutral-500">Catégorie</th>
                            <th class="px-6 py-3 text-left text-sm font-semibold bg-neutral-800 text-neutral-500">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            List<Depense> depenses = (List<Depense>) request.getAttribute("depenses");
                            if (depenses != null) {
                                for (Depense d : depenses) {
                        %>
                        <tr class="border-b border-neutral-800 hover:bg-neutral-900/50">
                            <td class="px-6 py-4 text-sm text-neutral-400"><%= d.getId() %></td>
                            <td class="px-6 py-4 text-sm text-neutral-400"><%= d.getMontant() %> Ariary</td>
                            <td class="px-6 py-4 text-sm text-neutral-400"><%= d.getDescription() %></td>
                            <td class="px-6 py-4 text-sm text-neutral-400"><%= d.getDate_depense() %></td>
                            <td class="px-6 py-4 text-sm text-neutral-400"><%= d.getCategorieId() %></td>
                            <td class="px-6 py-4 text-sm text-neutral-400 space-x-2">
                                <a href="depenses?action=edit&id=<%= d.getId() %>" class="border border-neutral-600 px-3 py-1 rounded-2xl hover:bg-neutral-800 transition">Modifier</a>
                                <a href="depenses?action=delete&id=<%= d.getId() %>" class="border border-neutral-600 px-3 py-1 rounded-2xl hover:bg-neutral-800 transition">Supprimer</a>
                            </td>
                        </tr>
                        <%
                                }
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Déconnexion discrète en bas -->
        <div class="text-right pb-2 pr-2">
            <a href="${pageContext.request.contextPath}/logout" class="text-neutral-500 hover:text-neutral-400 text-xs transition">
                Déconnexion
            </a>
        </div>
    </div>

    <script>
    $(document).ready(function() {
        // Initialisation de DataTable avec style sombre
        var table = $('#depensesTable').DataTable({
            "language": {
                "url": "//cdn.datatables.net/plug-ins/1.13.6/i18n/fr-FR.json"
            },
            "dom": 'rt<"bottom"lip><"clear">', // Supprime la recherche intégrée
            "pageLength": 10,
            "order": [[3, "desc"]],
            "initComplete": function() {
                $('.dataTables_length label').addClass('text-neutral-400');
            }
        });

        // Recherche globale unique
        $('#globalSearch').keyup(function(){
            table.search($(this).val()).draw();
        });

        // Filtre par catégorie
        $('#categoryFilter').change(function() {
            var category = $(this).val();
            table.column(4).search(category).draw();
        });

        // Export Excel
        $('#export').click(function() {
            const table = document.getElementById('depensesTable');
            const clone = table.cloneNode(true);

            // Supprimer la colonne Actions
            $(clone).find('th:last-child, td:last-child').remove();

            // Convertir en Excel
            const wb = XLSX.utils.table_to_book(clone, { sheet: "Depenses" });
            XLSX.writeFile(wb, "liste_depenses.xlsx");
        });

        // Réinitialiser les filtres
        $('#reinitialiser').click(function() {
            $('#globalSearch').val('');
            $('#categoryFilter').val('');
            table.search('').columns().search('').draw();
        });
    });
    </script>
</body>
</html>