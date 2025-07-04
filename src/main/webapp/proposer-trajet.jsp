<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!-- 1. Définir le titre de la page -->
<c:set var="pageTitle" value="Proposer un Trajet" />

<!-- 2. Inclure le header -->
<jsp:include page="header.jsp" />

<!-- 3. Contenu principal de la page -->
<main class="flex-grow container mx-auto px-4 sm:px-6 lg:px-8 flex items-center justify-center py-12">
    <div class="w-full max-w-2xl">
        
        <c:choose>
            <%-- CAS 1: L'utilisateur est bien un conducteur connecté --%>
            <c:when test="${not empty sessionScope.utilisateur && sessionScope.utilisateur.role == 'Conducteur'}">
                <div class="bg-white p-8 sm:p-12 rounded-2xl shadow-lg">
                    <div class="text-center mb-8">
                        <h1 class="text-3xl sm:text-4xl font-bold text-gray-800">Créer un nouveau trajet</h1>
                        <p class="mt-2 text-gray-600">Partagez votre prochain voyage avec la communauté.</p>
                    </div>

                    <!-- Affichage d'une éventuelle erreur venant de la servlet -->
                    <c:if test="${not empty requestScope.erreur}">
                        <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded-lg relative mb-6" role="alert">
                            <span><c:out value="${requestScope.erreur}" /></span>
                        </div>
                    </c:if>

                    <form action="trajets" method="POST" class="space-y-6">
                        <input type="hidden" name="action" value="create">

                        <div>
                            <label for="villeDepart" class="block text-sm font-medium text-gray-700">Ville de départ</label>
                            <input type="text" name="villeDepart" id="villeDepart" required class="mt-1 w-full px-4 py-2 border border-gray-300 rounded-lg shadow-sm focus:ring-blue-500 focus:border-blue-500">
                        </div>

                        <div>
                            <label for="villeArrivee" class="block text-sm font-medium text-gray-700">Ville d'arrivée</label>
                            <input type="text" name="villeArrivee" id="villeArrivee" required class="mt-1 w-full px-4 py-2 border border-gray-300 rounded-lg shadow-sm focus:ring-blue-500 focus:border-blue-500">
                        </div>

                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                            <div>
                                <label for="dateDepart" class="block text-sm font-medium text-gray-700">Date de départ</label>
                                <input type="date" name="dateDepart" id="dateDepart" required class="mt-1 w-full px-4 py-2 border border-gray-300 rounded-lg shadow-sm focus:ring-blue-500 focus:border-blue-500">
                            </div>
                            <div>
                                <label for="heureDepart" class="block text-sm font-medium text-gray-700">Heure de départ</label>
                                <input type="time" name="heureDepart" id="heureDepart" required class="mt-1 w-full px-4 py-2 border border-gray-300 rounded-lg shadow-sm focus:ring-blue-500 focus:border-blue-500">
                            </div>
                        </div>

                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                            <div>
                                <label for="placesDisponibles" class="block text-sm font-medium text-gray-700">Places disponibles</label>
                                <input type="number" name="placesDisponibles" id="placesDisponibles" min="1" required class="mt-1 w-full px-4 py-2 border border-gray-300 rounded-lg shadow-sm focus:ring-blue-500 focus:border-blue-500">
                            </div>
                            <div>
                                <label for="prixParPlace" class="block text-sm font-medium text-gray-700">Prix par place (€)</label>
                                <input type="number" name="prixParPlace" id="prixParPlace" step="0.5" min="0" required class="mt-1 w-full px-4 py-2 border border-gray-300 rounded-lg shadow-sm focus:ring-blue-500 focus:border-blue-500">
                            </div>
                        </div>

                        <div>
                            <label for="description" class="block text-sm font-medium text-gray-700">Notes additionnelles (optionnel)</label>
                            <textarea name="description" id="description" rows="4" class="mt-1 w-full px-4 py-2 border border-gray-300 rounded-lg shadow-sm focus:ring-blue-500 focus:border-blue-500" placeholder="Ex: Bagages, musique, pauses..."></textarea>
                        </div>

                        <div class="pt-2">
                            <button type="submit" class="w-full flex justify-center items-center px-6 py-3 border border-transparent rounded-lg shadow-sm text-base font-medium text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500">
                                Publier le trajet
                            </button>
                        </div>
                    </form>
                </div>
            </c:when>

            <%-- CAS 2: L'utilisateur n'est pas conducteur ou pas connecté --%>
            <c:otherwise>
                 <div class="text-center mt-12 bg-white p-8 rounded-lg shadow">
                    <h2 class="text-2xl font-semibold text-gray-700">Accès refusé</h2>
                    <p class="text-gray-500 mt-2">Vous devez être connecté en tant que conducteur pour proposer un trajet.</p>
                    <a href="connexion.jsp" class="mt-4 inline-block text-blue-600 font-medium hover:underline">
                        Se connecter
                    </a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</main>

<!-- 4. Inclure le footer -->
<jsp:include page="footer.jsp" />
