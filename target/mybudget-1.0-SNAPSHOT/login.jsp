<%@ page contentType="text/html;charset=UTF-8" %>
<html lang="fr">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <script src="https://cdn.tailwindcss.com"></script>
  <title>Connexion à MyBudget</title>
  <style>
    body {
      background-color: #000;
    }
  </style>
</head>
<body class="w-screen h-screen bg-black">

  <div class="flex justify-center items-center">
    <div class="w-[1000px] h-[600px] bg-neutral-900 mt-[130px] shadow-lg rounded-2xl border border-neutral-800">
      <div class="flex">
        <!-- PARTIE 1 - Image -->
        <div class="w-[500px] h-[600px] rounded-l-2xl bg-neutral-950 overflow-hidden">
          <img src="<%= request.getContextPath() %>/image/a.jpg" alt="Logo" class="mt-[115px] w-full h-auto object-cover opacity-90">
        </div>

        <!-- PARTIE 2 - Formulaire -->
        <div class="w-[500px] h-[600px] bg-neutral-900 shadow-xl rounded-r-2xl p-8 flex flex-col justify-center border-l border-neutral-800">
          <h2 class="text-2xl font-bold text-center text-neutral-200 mb-6">Connexion à MyBudget</h2>

          <form method="post" action="login" class="space-y-6">
            <div class="flex flex-col">
              <label for="email" class="text-sm font-medium text-neutral-400 mb-2">Email</label>
              <input
                type="email"
                name="email"
                id="email"
                class="border border-neutral-700 bg-neutral-800 text-neutral-200 rounded-lg p-3 focus:outline-none focus:ring-2 focus:ring-blue-600 focus:border-transparent"
                placeholder="Entrez votre email"
              />
            </div>

            <div class="flex flex-col">
              <label for="mot_de_passe" class="text-sm font-medium text-neutral-400 mb-2">Mot de passe</label>
              <input
                type="password"
                name="mot_de_passe"
                id="mot_de_passe"
                class="border border-neutral-700 bg-neutral-800 text-neutral-200 rounded-lg p-3 focus:outline-none focus:ring-2 focus:ring-blue-600 focus:border-transparent"
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

          <p class="text-sm text-neutral-400 mt-6 text-center">
            Vous n'avez pas encore de compte ?
            <a href="/register" class="text-blue-400 hover:text-blue-300 hover:underline ml-1">Inscrivez-vous</a>
          </p>
        </div>
      </div>
    </div>
  </div>

</body>
</html>