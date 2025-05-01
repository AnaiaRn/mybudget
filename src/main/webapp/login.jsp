<%@ page contentType="text/html;charset=UTF-8" %>
<html lang="fr">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <script src="https://cdn.tailwindcss.com"></script>
  <title>Ajouter une tâche</title>
</head>
<body>

  <div class="w-screen h-screen bg-gray-400 flex items-center justify-center">
    <div class="w-[400px] bg-white shadow-2xl rounded-2xl p-8">
      <h2 class="text-gray-800 font-bold text-3xl text-center mb-8">Connexion</h2>

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
          class="w-full bg-blue-600 text-white font-semibold py-3 rounded-lg hover:bg-blue-700 transition duration-300"
        >
          Se connecter
        </button>
      </form>
    </div>
  </div>

</body>
</html>
