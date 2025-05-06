<%@ page contentType="text/html;charset=UTF-8" %>
<html lang="fr">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <script src="https://cdn.tailwindcss.com"></script>
  <title>Ajouter une tâche</title>
</head>
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Connexion à MyBudget</title>
  <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="w-screen h-screen bg-gray-300">

  <div class="flex justify-center items-center">
    <div class="w-[1000px] h-[600px] bg-white mt-[130px] shadow rounded-2xl">
      <div class="flex">
        <!-- PARTIE 1 -->
        <div class="w-[500px] h-[600px] rounded-l-2xl bg-black">
         <img src="<%= request.getContextPath() %>/image/w.jpg" alt="Logo" class="mt-[115px] shadow-black">
        </div>

        <!-- PARTIE 2 -->
        <div class="w-[500px] h-[600px] bg-white shadow-xl rounded-2xl p-8 flex flex-col justify-center">
          <h2 class="text-2xl font-bold text-center text-gray-950 mb-6">Connexion à MyBudget</h2>

          <form method="post" action="login" class="space-y-6">
            <div class="flex flex-col">
              <label for="email" class="text-sm font-medium text-gray-700 mb-2">Email</label>
              <input
                type="email"
                name="email"
                id="email"
                class="border border-gray-300 rounded-lg p-3 focus:outline-none focus:ring-2 focus:ring-blue-500"
                placeholder="Entrez votre email"
              />
            </div>

            <div class="flex flex-col">
              <label for="mot_de_passe" class="text-sm font-medium text-gray-700 mb-2">Mot de passe</label>
              <input
                type="password"
                name="mot_de_passe"
                id="mot_de_passe"
                class="border border-gray-300 rounded-lg p-3 focus:outline-none focus:ring-2 focus:ring-blue-500"
                placeholder="Entrez votre mot de passe"
              />
            </div>

            <button
              type="submit"
              class="w-full bg-gray-900 text-white font-semibold py-3 rounded-lg hover:bg-gray-950 transition duration-300"
            >
              Se connecter
            </button>
          </form>

          <p class="text-sm text-gray-600 mt-6 text-center">
            Vous n’avez pas encore de compte ?
            <a href="/register" class="text-blue-600 hover:underline ml-1">Inscrivez-vous</a>
          </p>
        </div>
      </div>
    </div>
  </div>

</body>
</html>

</html>
