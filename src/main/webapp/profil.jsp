<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

<c:set var="pageTitle" value="Mon Profil" />
<fmt:setLocale value="fr_FR" />
<jsp:include page="header.jsp" />

<main class="flex-grow container mx-auto px-4 sm:px-6 lg:px-8 py-12">
    <div class="w-full max-w-4xl mx-auto">
        
        <c:choose>
            <c:when test="${not empty sessionScope.utilisateur}">
                <div class="mb-8">
                    <h1 class="text-3xl md:text-4xl font-bold text-gray-800">Gestion du Profil</h1>
                    <p class="mt-1 text-gray-600">Mettez à jour vos informations personnelles.</p>
                </div>

                <div class="bg-white p-8 rounded-2xl shadow-lg">
                    <!-- Affichage des messages de succès ou d'erreur -->
                    <c:if test="${not empty successMessage}">
                        <div class="bg-green-100 border-l-4 border-green-500 text-green-700 p-4 mb-6 rounded-lg" role="alert">
                            <p>${successMessage}</p>
                        </div>
                    </c:if>
                    <c:if test="${not empty errorMessage}">
                        <div class="bg-red-100 border-l-4 border-red-500 text-red-700 p-4 mb-6 rounded-lg" role="alert">
                            <p>${errorMessage}</p>
                        </div>
                    </c:if>

                    <form action="profil" method="POST" class="space-y-8">
                        <div class="border-b pb-8">
                            <h2 class="text-xl font-semibold text-gray-800">Informations Personnelles</h2>
                            <div class="mt-6 grid grid-cols-1 md:grid-cols-2 gap-6">
                                <div>
                                    <label for="prenom" class="block text-sm font-medium text-gray-700">Prénom</label>
                                    <input type="text" name="prenom" id="prenom" value="${sessionScope.utilisateur.prenom}" class="mt-1 w-full px-4 py-2 border border-gray-300 rounded-lg shadow-sm focus:ring-blue-500 focus:border-blue-500">
                                </div>
                                <div>
                                    <label for="nom" class="block text-sm font-medium text-gray-700">Nom</label>
                                    <input type="text" name="nom" id="nom" value="${sessionScope.utilisateur.nom}" class="mt-1 w-full px-4 py-2 border border-gray-300 rounded-lg shadow-sm focus:ring-blue-500 focus:border-blue-500">
                                </div>
                                <div>
                                    <label for="email" class="block text-sm font-medium text-gray-700">Adresse e-mail</label>
                                    <input type="email" name="email" id="email" value="${sessionScope.utilisateur.email}" class="mt-1 w-full px-4 py-2 border border-gray-300 rounded-lg shadow-sm focus:ring-blue-500 focus:border-blue-500">
                                </div>
                                <div>
                                    <label for="telephone" class="block text-sm font-medium text-gray-700">Téléphone</label>
                                    <input type="tel" name="telephone" id="telephone" value="${sessionScope.utilisateur.telephone}" class="mt-1 w-full px-4 py-2 border border-gray-300 rounded-lg shadow-sm focus:ring-blue-500 focus:border-blue-500">
                                </div>
                            </div>
                        </div>

                        <div class="flex justify-end">
                            <button type="submit" class="bg-blue-600 text-white font-semibold px-6 py-2.5 rounded-lg shadow-sm hover:bg-blue-700 transition-colors">
                                Enregistrer les modifications
                            </button>
                        </div>
                    </form>
                </div>
            </c:when>
            <c:otherwise>
                 <div class="text-center mt-12 bg-white p-8 rounded-lg shadow">
                    <h2 class="text-2xl font-semibold text-gray-700">Accès refusé</h2>
                    <p class="text-gray-500 mt-2">Vous devez être connecté pour voir votre profil.</p>
                    <a href="connexion.jsp" class="mt-4 inline-block text-blue-600 font-medium hover:underline">Se connecter</a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</main>

<jsp:include page="footer.jsp" />
