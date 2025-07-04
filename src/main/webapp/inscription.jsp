<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!-- 1. Définir le titre de la page -->
<c:set var="pageTitle" value="Inscription" />

<!-- 2. Inclure le header -->
<jsp:include page="header.jsp" />

<!-- 3. Contenu principal de la page -->
<main class="flex-grow container mx-auto px-4 sm:px-6 lg:px-8 flex items-center justify-center py-12">
    <div class="w-full max-w-2xl">
        <div class="bg-white p-8 sm:p-12 rounded-2xl shadow-lg">
            <div class="text-center mb-8">
                <h1 class="text-3xl sm:text-4xl font-bold text-gray-800">Créez votre compte</h1>
                <p class="mt-2 text-gray-600">Rejoignez-nous et commencez à voyager différemment.</p>
            </div>

            <!-- AFFICHER LES ERREURS VENANT DE LA SERVLET -->
            <c:if test="${not empty requestScope.erreur}">
                <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded-lg relative mb-6" role="alert">
                    <span class="block sm:inline"><c:out value="${requestScope.erreur}" /></span>
                </div>
            </c:if>

            <!-- Le formulaire pointe vers la servlet "inscription" -->
            <form action="inscription" method="POST" class="space-y-6">
                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <div>
                        <label for="prenom" class="block text-sm font-medium text-gray-700">Prénom</label>
                        <input type="text" name="prenom" id="prenom" required class="mt-1 w-full px-4 py-2 border border-gray-300 rounded-lg shadow-sm focus:ring-blue-500 focus:border-blue-500">
                    </div>
                    <div>
                        <label for="nom" class="block text-sm font-medium text-gray-700">Nom</label>
                        <input type="text" name="nom" id="nom" required class="mt-1 w-full px-4 py-2 border border-gray-300 rounded-lg shadow-sm focus:ring-blue-500 focus:border-blue-500">
                    </div>
                </div>

                <div>
                    <label for="email" class="block text-sm font-medium text-gray-700">Adresse e-mail</label>
                    <input type="email" name="email" id="email" required class="mt-1 w-full px-4 py-2 border border-gray-300 rounded-lg shadow-sm focus:ring-blue-500 focus:border-blue-500">
                </div>

                <div>
                    <label for="password" class="block text-sm font-medium text-gray-700">Mot de passe</label>
                    <input type="password" name="motDePasse" id="password" required class="mt-1 w-full px-4 py-2 border border-gray-300 rounded-lg shadow-sm focus:ring-blue-500 focus:border-blue-500">
                </div>

                <div>
                    <label for="telephone" class="block text-sm font-medium text-gray-700">Téléphone</label>
                    <input type="tel" name="telephone" id="telephone" class="mt-1 w-full px-4 py-2 border border-gray-300 rounded-lg shadow-sm focus:ring-blue-500 focus:border-blue-500">
                </div>

                <div>
                    <label class="block text-sm font-medium text-gray-700">Rôle</label>
                    <fieldset class="mt-2">
                        <div class="space-y-2 sm:flex sm:items-center sm:space-y-0 sm:space-x-10">
                            <div class="flex items-center">
                                <input id="role-conducteur" name="role" type="radio" value="Conducteur" required class="focus:ring-blue-500 h-4 w-4 text-blue-600 border-gray-300">
                                <label for="role-conducteur" class="ml-3 block text-sm font-medium text-gray-700">Conducteur</label>
                            </div>
                            <div class="flex items-center">
                                <input id="role-passager" name="role" type="radio" value="Passager" required class="focus:ring-blue-500 h-4 w-4 text-blue-600 border-gray-300">
                                <label for="role-passager" class="ml-3 block text-sm font-medium text-gray-700">Passager</label>
                            </div>
                        </div>
                    </fieldset>
                </div>

                <div>
                    <button type="submit" class="w-full flex justify-center items-center px-6 py-3 border border-transparent rounded-lg shadow-sm text-base font-medium text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500">
                        S'inscrire
                    </button>
                </div>
            </form>
            
            <div class="text-center mt-6">
                <p class="text-sm text-gray-600">
                    Vous avez déjà un compte ?
                    <a href="connexion.jsp" class="font-medium text-blue-600 hover:text-blue-700">Connectez-vous</a>
                </p>
            </div>
        </div>
    </div>
</main>

<!-- 4. Inclure le footer -->
<jsp:include page="footer.jsp" />
