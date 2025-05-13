<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>MyBudget - Accueil</title>
    <script src="https://cdn.tailwindcss.com"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.5/xlsx.full.min.js"></script>

</head>
<body>
    <div class="w-screen h-screen bg-black ">

          <div class="flex justify-between items-center px-4 py-3 bg-black rounded-b-lg shadow-md">
      {/* Logo / Titre */}

    </div>




            <div class="flex justify-center items-center mt-4">
              <div class="w-[90%] h-[250px] border border-gray-600 shadow-2xl"></div>
            </div>




            <div class="flex justify-center space-x-4 mt-10 text-white">

              <div class="w-[400px] h-[300px] bg-neutral-950 rounded-2xl flex flex-col justify-center items-center p-6 shadow-lg">
                <p class="text-white text-[15px] text-center mb-6">
                Chaque dépense compte ! <br /> Enregistrez-la ici en quelques clics.            </p>
                <a href="${pageContext.request.contextPath}/depenses?action=create" class="px-4 py-2 text-white  rounded-lg border transition duration-300 text-[15px] hover:bg-neutral-900">
                Ajouter une dépense
                </a>
             </div>

             <div class="w-[400px] h-[300px] bg-neutral-950 rounded-2xl flex flex-col justify-center items-center p-6 shadow-lg">
                <p class="text-white text-[15px] text-center mb-6">
                  Gardez un œil sur vos dépenses quotidiennes <br /> pour mieux gérer votre budget.
                </p>
                <a href="${pageContext.request.contextPath}/depenses?action=list" class="px-4 py-2 text-white  rounded-lg border transition duration-300 text-[15px] hover:bg-neutral-900">
                  Voir la liste
                </a>
             </div>
             <div class="w-[400px] h-[300px] bg-neutral-950 rounded-2xl flex flex-col justify-center items-center p-6 shadow-lg">
                <p class="text-white text-[15px] text-center mb-6">
                Suivez vos finances chaque mois <br /> grâce à un rapport détaillé et automatique.
                </p>
                <a href="" class="px-4 py-2 text-white  rounded-lg border transition duration-300 text-[15px] hover:bg-neutral-900">
                Rapport Mensuel
                </a>
             </div>
             <div class="w-[400px] h-[300px] bg-neutral-950 rounded-2xl flex flex-col justify-center items-center p-6 shadow-lg">
                <p class="text-white text-[15px] text-center mb-6">
                Besoin d’aide ?  <br />Posez votre question à l’assistant virtuel MyBudget.
                </p>
                <a href="" class="px-4 py-2 text-white  rounded-lg border transition duration-300 text-[15px] hover:bg-neutral-900">
                Assistant virtuel
                </a>
             </div>
            </div>
        </div>
</body>
</html>
