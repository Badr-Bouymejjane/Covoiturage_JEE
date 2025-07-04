<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!-- 1. Définir le titre de la page -->
<c:set var="pageTitle" value="Trouvez votre trajet parfait" />

<!-- 2. Inclure le header -->
<jsp:include page="header.jsp" />

<!-- 3. Contenu principal de la page -->
<main class="flex-grow container mx-auto px-4 sm:px-6 lg:px-8 flex items-center justify-center py-12">
    <div class="w-full max-w-2xl">
        <div class="bg-white p-8 sm:p-12 rounded-2xl shadow-lg">
            <h1 class="text-3xl sm:text-4xl font-bold text-center text-gray-800 mb-8">Trouvez votre trajet parfait</h1>

            <!-- Affichage d'une éventuelle erreur de recherche -->
            <c:if test="${not empty requestScope.erreur}">
                <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded-lg relative mb-6" role="alert">
                    <span><c:out value="${requestScope.erreur}" /></span>
                </div>
            </c:if>

            <!-- Le formulaire de recherche qui pointe vers TrajetsServlet -->
            <form action="trajets" method="GET" class="space-y-6">
                <!-- Champ caché pour spécifier l'action à la servlet -->
                <input type="hidden" name="action" value="search">

                <div>
                    <label for="villeDepart" class="block text-sm font-medium text-gray-700 mb-1">Ville de départ</label>
                    <div class="relative">
                        <div class="absolute inset-y-0 left-0 pl-4 flex items-center pointer-events-none">
                           <svg class="h-5 w-5 text-gray-400" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor"><path fill-rule="evenodd" d="M5.05 4.05a7 7 0 119.9 9.9L10 18.9l-4.95-4.95a7 7 0 010-9.9zM10 11a2 2 0 100-4 2 2 0 000 4z" clip-rule="evenodd" /></svg>
                        </div>
                        <input type="text" name="villeDepart" id="villeDepart" required class="w-full pl-12 pr-4 py-3 border border-gray-300 rounded-lg shadow-sm focus:ring-blue-500 focus:border-blue-500" placeholder="Ex: Paris, Rabat...">
                    </div>
                </div>

                <div>
                    <label for="villeArrivee" class="block text-sm font-medium text-gray-700 mb-1">Ville d'arrivée</label>
                    <div class="relative">
                        <div class="absolute inset-y-0 left-0 pl-4 flex items-center pointer-events-none">
                            <svg class="h-5 w-5 text-gray-400" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor"><path d="M10.894 2.553a1 1 0 00-1.788 0l-7 14a1 1 0 001.169 1.409l5-1.429A1 1 0 009 15.571V11a1 1 0 112 0v4.571a1 1 0 00.725.962l5 1.428a1 1 0 001.17-1.408l-7-14z" /></svg>
                        </div>
                        <input type="text" name="villeArrivee" id="villeArrivee" required class="w-full pl-12 pr-4 py-3 border border-gray-300 rounded-lg shadow-sm focus:ring-blue-500 focus:border-blue-500" placeholder="Ex: Lyon, Casablanca...">
                    </div>
                </div>

                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <div>
                        <label for="dateDepart" class="block text-sm font-medium text-gray-700 mb-1">Date</label>
                        <div class="relative">
                            <div class="absolute inset-y-0 left-0 pl-4 flex items-center pointer-events-none">
                                <svg class="w-5 h-5 text-gray-400" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" d="M6 2a1 1 0 00-1 1v1H4a2 2 0 00-2 2v10a2 2 0 002 2h12a2 2 0 002-2V6a2 2 0 00-2-2h-1V3a1 1 0 10-2 0v1H7V3a1 1 0 00-1-1zm0 5a1 1 0 000 2h8a1 1 0 100-2H6z" clip-rule="evenodd"></path></svg>
                            </div>
                            <input type="date" name="dateDepart" id="dateDepart" required class="w-full pl-12 pr-4 py-3 border border-gray-300 rounded-lg shadow-sm focus:ring-blue-500 focus:border-blue-500">
                        </div>
                    </div>
                    <div>
                        <label for="places" class="block text-sm font-medium text-gray-700 mb-1">Passagers</label>
                        <div class="relative">
                             <div class="absolute inset-y-0 left-0 pl-4 flex items-center pointer-events-none">
                                <svg class="w-5 h-5 text-gray-400" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path d="M9 6a3 3 0 11-6 0 3 3 0 016 0zm-1.5 5.5a3 3 0 00-3 0V13a1 1 0 00-1 1v1a1 1 0 001 1h3a1 1 0 001-1v-1a1 1 0 00-1-1v-1.5zM16 6a3 3 0 11-6 0 3 3 0 016 0zm-1.5 5.5a3 3 0 00-3 0V13a1 1 0 00-1 1v1a1 1 0 001 1h3a1 1 0 001-1v-1a1 1 0 00-1-1v-1.5z"></path></svg>
                            </div>
                            <input type="number" name="places" id="places" required value="1" min="1" class="w-full pl-12 pr-4 py-3 border border-gray-300 rounded-lg shadow-sm focus:ring-blue-500 focus:border-blue-500">
                        </div>
                    </div>
                </div>

                <div class="pt-2">
                    <button type="submit" class="w-full flex justify-center items-center px-6 py-3 border border-transparent rounded-lg shadow-sm text-base font-medium text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500">
                        <svg class="w-5 h-5 mr-2" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" d="M8 4a4 4 0 100 8 4 4 0 000-8zM2 8a6 6 0 1110.89 3.476l4.817 4.817a1 1 0 01-1.414 1.414l-4.816-4.816A6 6 0 012 8z" clip-rule="evenodd"></path></svg>
                        Rechercher
                    </button>
                </div>
            </form>

            <div class="text-center mt-6">
                <p class="text-sm text-gray-600">
                    Ou proposez votre propre trajet !
                    <a href="proposer-trajet.jsp" class="font-medium text-blue-600 hover:text-blue-700">Devenir conducteur</a>
                </p>
            </div>
        </div>
    </div>
</main>

<!-- 4. Inclure le footer -->
<jsp:include page="footer.jsp" />
