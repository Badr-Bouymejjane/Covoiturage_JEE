<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.util.Locale" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

<!-- 1. Définir le titre de la page -->
<c:set var="pageTitle" value="Détails du Trajet" />

<%-- Définir la locale pour toute la page --%>
<fmt:setLocale value="fr_FR" />

<!-- 2. Inclure le header -->
<jsp:include page="header.jsp" />

<!-- 3. Contenu principal de la page -->
<main class="flex-grow container mx-auto px-4 sm:px-6 lg:px-8 py-8">
    <div class="w-full max-w-4xl mx-auto">
        
        <c:choose>
            <%-- CAS 1: Le trajet a bien été trouvé --%>
            <c:when test="${not empty trajet}">
                
                <%-- CORRECTION: On utilise request.getAttribute pour récupérer l'objet depuis la bonne portée --%>
                <%
                    if (request.getAttribute("trajet") != null) {
                        LocalDate dateDepart = ((com.covoiturage.model.Trajet)request.getAttribute("trajet")).getDateDepart();
                        String formattedDate = dateDepart.format(DateTimeFormatter.ofPattern("EEEE d MMMM yyyy", Locale.FRENCH));
                        pageContext.setAttribute("formattedDateDepart", formattedDate);
                    }
                %>

                <!-- Fil d'Ariane (Breadcrumbs) -->
                <nav class="text-sm text-gray-500 mb-6">
                    <a href="index.jsp" class="hover:text-blue-600">Accueil</a>
                    <span class="mx-2">/</span>
                    <a href="trajets?action=search&villeDepart=${trajet.villeDepart}&villeArrivee=${trajet.villeArrivee}&dateDepart=${trajet.dateDepart}&places=1" class="hover:text-blue-600">Résultats</a>
                    <span class="mx-2">/</span>
                    <span>Détails du trajet</span>
                </nav>

                <!-- Carte principale des détails -->
                <div class="bg-white p-6 sm:p-8 rounded-2xl shadow-lg">
                    <!-- En-tête de la carte -->
                    <div class="flex flex-col sm:flex-row justify-between items-start pb-6 border-b">
                        <div>
                            <h1 class="text-2xl md:text-3xl font-bold text-gray-800">
                                <c:out value="${trajet.villeDepart}"/> → <c:out value="${trajet.villeArrivee}"/>
                            </h1>
                            <div class="flex items-center text-gray-500 mt-2 text-sm">
                                <span class="flex items-center">
                                    <i class="fa-regular fa-calendar-alt mr-2"></i>
                                    <c:out value="${formattedDateDepart}"/>
                                </span>
                                <span class="mx-2 text-gray-300">|</span>
                                <span class="flex items-center">
                                    <i class="fa-regular fa-clock mr-2"></i>
                                    <c:out value="${trajet.heureDepart}"/>
                                </span>
                            </div>
                        </div>
                        <div class="bg-blue-600 text-white font-bold text-lg px-6 py-3 rounded-lg mt-4 sm:mt-0">
                            <fmt:formatNumber value="${trajet.prixParPlace}" type="currency" currencySymbol="MAD"/> / place
                        </div>
                    </div>

                    <!-- Détails du conducteur -->
                    <div class="py-6 border-b">
                         <h2 class="text-lg font-semibold text-gray-800 mb-4">Votre conducteur</h2>
                         <div class="flex items-center space-x-4">
                            <img class="h-14 w-14 rounded-full object-cover" src="https://ui-avatars.com/api/?name=${trajet.conducteur.prenom}+${trajet.conducteur.nom}&background=random" alt="Avatar de ${trajet.conducteur.prenom}">
                            <div>
                                <p class="font-semibold text-gray-800 text-lg"><c:out value="${trajet.conducteur.prenom}"/></p>
                                <div class="text-sm text-gray-500 mt-1">
                                    <span>Membre depuis <fmt:formatDate value="${trajet.conducteur.dateInscription}" pattern="MMMM yyyy" /></span>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Détails du trajet -->
                    <div class="py-6">
                        <h2 class="text-lg font-semibold text-gray-800 mb-4">Détails du trajet</h2>
                        <div class="space-y-3 text-sm">
                            <div class="flex justify-between">
                                <span class="text-gray-500">Places disponibles</span>
                                <span class="font-medium text-gray-800">${trajet.placesDisponibles}</span>
                            </div>
                            <c:if test="${not empty trajet.description}">
                                <div class="flex flex-col">
                                    <span class="text-gray-500 mb-1">Notes du conducteur</span>
                                    <p class="font-medium text-gray-800 bg-gray-50 p-3 rounded-lg"><c:out value="${trajet.description}"/></p>
                                </div>
                            </c:if>
                        </div>
                    </div>

                    <!-- Bouton d'action dynamique -->
                    <div class="mt-8">
                        <c:choose>
                            <%-- CAS 1: L'utilisateur est le conducteur, il ne peut pas réserver son propre trajet --%>
                            <c:when test="${not empty sessionScope.utilisateur && sessionScope.utilisateur.id == trajet.conducteur.id}">
                                <a href="mes-trajets" class="w-full flex justify-center items-center px-6 py-3 border border-transparent rounded-lg shadow-sm text-base font-medium text-white bg-gray-400 cursor-not-allowed">
                                    <i class="fa-solid fa-user-pen mr-3"></i>
                                    Gérer mon trajet
                                </a>
                            </c:when>
                            <%-- CAS 2: L'utilisateur est connecté et N'EST PAS le conducteur --%>
                            <c:when test="${not empty sessionScope.utilisateur}">
                                <a href="reservation?action=request&trajetId=${trajet.id}" class="w-full flex justify-center items-center px-6 py-3 border border-transparent rounded-lg shadow-sm text-base font-medium text-white bg-blue-600 hover:bg-blue-700">
                                    <i class="fa-solid fa-car-side mr-3"></i>
                                    Réserver ce trajet
                                </a>
                            </c:when>
                            <%-- CAS 3: Le visiteur n'est pas connecté --%>
                            <c:otherwise>
                                <a href="connexion.jsp" class="w-full flex justify-center items-center px-6 py-3 border border-transparent rounded-lg shadow-sm text-base font-medium text-white bg-blue-600 hover:bg-blue-700">
                                    <i class="fa-solid fa-arrow-right-to-bracket mr-3"></i>
                                    Se connecter pour réserver
                                </a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </c:when>
            
            <%-- CAS 2: Le trajet n'a pas été trouvé (ID invalide, etc.) --%>
            <c:otherwise>
                <div class="text-center mt-12 bg-white p-8 rounded-lg shadow">
                    <h2 class="text-2xl font-semibold text-gray-700">Trajet non trouvé</h2>
                    <p class="text-gray-500 mt-2">Désolé, le trajet que vous cherchez n'existe pas ou n'est plus disponible.</p>
                    <a href="index.jsp" class="mt-4 inline-block text-blue-600 font-medium hover:underline">
                        Retour à l'accueil
                    </a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</main>

<!-- 4. Inclure le footer -->
<jsp:include page="footer.jsp" />
