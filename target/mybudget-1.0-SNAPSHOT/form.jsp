<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.mybudget.models.Depense" %>
<%@ page import="com.mybudget.models.Categorie" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.*, com.mybudget.models.Categorie, com.mybudget.models.Depense" %>
<%
    Depense d = (Depense) request.getAttribute("depense");
    List<Categorie> categories = (List<Categorie>) request.getAttribute("categories");
%>

<html>
<head>
    <title>Formulaire Dépense</title>
</head>
<body>
<h2><%= request.getAttribute("depense") != null ? "Modifier" : "Ajouter" %> une dépense</h2>

<form method="post" action="depenses">
    <input type="hidden" name="action" value="<%= (d != null) ? "update" : "create" %>">
    <input type="hidden" name="id" value="<%= (d != null) ? d.getId() : "" %>">

    <label>Montant:</label>
    <input type="number" name="montant" value="<%= (d != null) ? d.getMontant() : "" %>"><br>

    <label>Description:</label>
    <input type="text" name="description" value="<%= (d != null) ? d.getDescription() : "" %>"><br>

    <label>Date:</label>
    <input type="date" name="date_depense" value="<%= (d != null) ? d.getDate_depense() : "" %>"><br>

    <label>Catégorie:</label>
    <select name="categorie_id">
       <% if (categories != null) {
            for (Categorie c : categories) { %>
           <option value="<%= c.getId() %>"
               <%= (d != null && d.getCategorieId() == c.getId()) ? "selected" : "" %>>
               <%= c.getNom() %>
           </option>
       <%  }
          } %>

    </select><br>

    <button type="submit">Enregistrer</button>
</form>


<a href="depenses?action=list">Retour à la liste</a>
</body>
</html>
