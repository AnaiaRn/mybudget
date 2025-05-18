<%@ page contentType="text/html;charset=UTF-8" %>
<html lang="fr">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <script src="https://cdn.tailwindcss.com"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <title>Connexion à MyBudget</title>
  <style>
    body {
      background-color: #000;
    }
    .logo-placeholder {
      background: linear-gradient(145deg, #1e293b, #0f172a);
    }
  </style>
</head>
<body class="w-screen h-screen bg-black">

  <div class="flex justify-center items-center">
    <div class="w-[1000px] h-[600px] bg-neutral-900 mt-[130px] shadow-lg rounded-2xl border border-neutral-800">
      <div class="flex">
        <!-- PARTIE 1 - Placeholder stylisé -->
        <div class="w-[500px] h-[600px] rounded-l-2xl logo-placeholder flex flex-col items-center justify-center p-8">
          <div class="text-center">
            <div class="flex justify-center mb-6">
              <i class="fas fa-wallet text-6xl text-blue-500"></i>
            </div>
            <h1 class="text-3xl font-bold text-neutral-200 mb-4">MyBudget</h1>
            <p class="text-neutral-400">Gérez vos finances en toute simplicité</p>

            <div class="mt-12 grid grid-cols-3 gap-4">
              <div class="h-2 bg-blue-500 rounded-full"></div>
              <div class="h-2 bg-blue-500 rounded-full opacity-70"></div>
              <div class="h-2 bg-blue-500 rounded-full opacity-40"></div>
            </div>
          </div>
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
                required
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
                required
              />
            </div>

            <button
              type="submit"
              class="w-full bg-blue-600 text-white font-semibold py-3 rounded-lg hover:bg-blue-700 transition duration-300"
            >
              <i class="fas fa-sign-in-alt mr-2"></i>Se connecter
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