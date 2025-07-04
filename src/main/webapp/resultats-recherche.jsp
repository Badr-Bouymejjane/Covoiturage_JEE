<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.util.Locale" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

<!-- 1. Définir le titre de la page -->
<c:set var="pageTitle" value="Résultats de la recherche" />

<!-- 2. Inclure le header -->
<jsp:include page="header.jsp" />

<!-- 3. Contenu principal de la page -->
<main class="flex-grow container mx-auto px-4 sm:px-6 lg:px-8 py-8">
    <div class="w-full max-w-4xl mx-auto">
        
        <!-- Titre dynamique basé sur la recherche -->
        <h1 class="text-3xl md:text-4xl font-bold text-gray-800">
            Trajets de <span class="text-blue-600"><c:out value="${villeDepart}"/></span> à <span class="text-blue-600"><c:out value="${villeArrivee}"/></span>
        </h1>
        <p class="mt-2 text-gray-600">Affichage des trajets pour <c:out value="${param.places}"/> passager(s)</p>

        <!-- Liste des trajets -->
        <div class="mt-8 space-y-8">
            <c:choose>
                <%-- CAS 1: Il y a des trajets à afficher --%>
                <c:when test="${not empty listeTrajets}">
                    <c:set var="currentDate" value="" />
                    <c:forEach var="trajet" items="${listeTrajets}">
                        
                        <%-- Logique pour afficher le titre de la date (Aujourd'hui, Demain, etc.) --%>
                        <c:if test="${trajet.dateDepart != currentDate}">
                            <c:set var="currentDate" value="${trajet.dateDepart}" />
                            <%
                                // On utilise un scriptlet pour formater la date de manière lisible
                                LocalDate date = (LocalDate) pageContext.getAttribute("currentDate");
                                String formattedDate;
                                if (date.isEqual(LocalDate.now())) {
                                    formattedDate = "Aujourd'hui, " + date.format(DateTimeFormatter.ofPattern("d MMMM", Locale.FRENCH));
                                } else if (date.isEqual(LocalDate.now().plusDays(1))) {
                                    formattedDate = "Demain, " + date.format(DateTimeFormatter.ofPattern("d MMMM", Locale.FRENCH));
                                } else {
                                    formattedDate = date.format(DateTimeFormatter.ofPattern("EEEE d MMMM", Locale.FRENCH));
                                }
                                pageContext.setAttribute("formattedDate", formattedDate);
                            %>
                            <h2 class="text-xl font-semibold text-gray-700 mb-4 capitalize">${formattedDate}</h2>
                        </c:if>

                        <!-- Carte du trajet -->
                        <div class="bg-white p-4 sm:p-6 rounded-xl shadow-md transition hover:shadow-lg">
                            <div class="flex flex-col sm:flex-row justify-between items-center gap-4">
                                <div class="flex items-center space-x-4">
                                    <img class="h-14 w-14 rounded-full object-cover" src="https://ui-avatars.com/api/?name=${trajet.conducteur.prenom}+${trajet.conducteur.nom}&background=random" alt="Avatar de ${trajet.conducteur.prenom}">
                                    <div>
                                        <p class="font-semibold text-gray-800"><c:out value="${trajet.conducteur.prenom}"/> <c:out value="${trajet.conducteur.nom}"/></p>
                                        <div class="text-sm text-gray-500 mt-1 flex items-center space-x-3">
											<span><i class="fa-solid fa-clock mr-1"></i> <c:out value="${trajet.heureDepart}" /></span>                                            <span><i class="fa-solid fa-chair mr-1"></i> ${trajet.placesDisponibles} places</span>
                                            <span><i class="fa-solid fa-euro-sign mr-1"></i> <fmt:formatNumber value="${trajet.prixParPlace}" type="currency" currencySymbol="€"/></span>
                                        </div>
                                    </div>
                                </div>
                                <!-- Le lien pointe vers la servlet avec l'action "details" et l'ID du trajet -->
                                <a href="trajets?action=details&id=${trajet.id}" class="bg-blue-600 text-white font-semibold px-5 py-2.5 rounded-lg shadow-sm hover:bg-blue-700 transition-colors w-full sm:w-auto text-center">
                                    Voir le trajet <i class="fa-solid fa-arrow-right ml-2"></i>
                                </a>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>

                <%-- CAS 2: Aucun trajet n'a été trouvé --%>
                <c:otherwise>
                    <div class="text-center mt-12 bg-white p-8 rounded-lg shadow">
                        <h2 class="text-2xl font-semibold text-gray-700">Aucun trajet trouvé</h2>
                        <p class="text-gray-500 mt-2">Désolé, il n'y a pas de trajets correspondant à votre recherche pour le moment.</p>
                        <a href="index.jsp" class="mt-4 inline-block text-blue-600 font-medium hover:underline">
                            Modifier ma recherche
                        </a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</main>

<!-- 4. Inclure le footer -->
<jsp:include page="footer.jsp" />
