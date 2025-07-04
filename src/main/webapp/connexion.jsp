<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!-- 1. Définir le titre de la page -->
<c:set var="pageTitle" value="Connexion" />

<!-- 2. Inclure le header -->
<jsp:include page="header.jsp" />

<!-- 3. Contenu principal de la page -->
<main class="flex-grow container mx-auto px-4 sm:px-6 lg:px-8 flex items-center justify-center py-12">
    <div class="w-full max-w-md">
        <div class="bg-white p-8 sm:p-12 rounded-2xl shadow-lg">
            <div class="text-center mb-8">
                <h1 class="text-3xl font-bold text-gray-800">Bon retour !</h1>
                <p class="mt-2 text-gray-600">Connectez-vous pour continuer.</p>
            </div>

            <!-- Affichage des messages d'erreur ou de succès -->
            <c:if test="${not empty requestScope.erreur}">
                <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded-lg relative mb-6" role="alert">
                    <span><c:out value="${requestScope.erreur}" /></span>
                </div>
            </c:if>
            <c:if test="${param.inscription == 'succes'}">
                 <div class="bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded-lg relative mb-6" role="alert">
                    <span>Inscription réussie ! Vous pouvez maintenant vous connecter.</span>
                </div>
            </c:if>

            <!-- Le formulaire pointe vers la servlet "connexion" -->
            <form action="connexion" method="POST" class="space-y-6">
                <div>
                    <label for="email" class="block text-sm font-medium text-gray-700">Adresse e-mail</label>
                    <input type="email" name="email" id="email" required class="mt-1 w-full px-4 py-2 border border-gray-300 rounded-lg shadow-sm focus:ring-blue-500 focus:border-blue-500">
                </div>
                <div>
                    <div class="flex justify-between items-baseline">
                        <label for="password" class="block text-sm font-medium text-gray-700">Mot de passe</label>
                        <a href="#" class="text-sm text-blue-600 hover:text-blue-700">Mot de passe oublié ?</a>
                    </div>
                    <input type="password" name="motDePasse" id="password" required class="mt-1 w-full px-4 py-2 border border-gray-300 rounded-lg shadow-sm focus:ring-blue-500 focus:border-blue-500">
                </div>
                <div>
                    <button type="submit" class="w-full flex justify-center items-center px-6 py-3 border border-transparent rounded-lg shadow-sm text-base font-medium text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500">
                        Se connecter
                    </button>
                </div>
            </form>
            
             <div class="text-center mt-6">
                <p class="text-sm text-gray-600">
                    Pas encore de compte ?
                    <a href="inscription.jsp" class="font-medium text-blue-600 hover:text-blue-700">Inscrivez-vous</a>
                </p>
            </div>
        </div>
    </div>
</main>

<!-- 4. Inclure le footer -->
<jsp:include page="footer.jsp" />
