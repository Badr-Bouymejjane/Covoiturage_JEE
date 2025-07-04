<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.util.Locale" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

<c:set var="pageTitle" value="Mes Trajets" />
<fmt:setLocale value="fr_FR" />

<jsp:include page="header.jsp" />

<main class="flex-grow container mx-auto px-4 sm:px-6 lg:px-8 py-8">
    <div class="w-full max-w-5xl mx-auto">
        <c:choose>
            <%-- ================================================================= --%>
            <%--                          VUE CONDUCTEUR                           --%>
            <%-- ================================================================= --%>
            <c:when test="${sessionScope.utilisateur.role == 'Conducteur'}">
                <div class="flex flex-col sm:flex-row justify-between items-start sm:items-center mb-8">
                    <div>
                        <h1 class="text-3xl md:text-4xl font-bold text-gray-800">Gestion des Trajets</h1>
                        <p class="mt-1 text-gray-600">Publiez et gérez vos annonces de covoiturage.</p>
                    </div>
                    <a href="proposer-trajet.jsp" class="mt-4 sm:mt-0 flex-shrink-0 bg-blue-600 text-white font-semibold px-5 py-2.5 rounded-lg shadow-sm hover:bg-blue-700 transition-colors flex items-center">
                        <i class="fas fa-plus-circle mr-2"></i> Créer un nouveau trajet
                    </a>
                </div>

                <!-- Section des trajets actifs -->
                <h2 class="text-2xl font-semibold text-gray-800 mb-6">Trajets Actifs</h2>
                <div class="space-y-6">
                    <c:set var="activeTripsFound" value="false" />
                    <c:forEach var="offre" items="${listeOffres}">
                        <c:if test="${offre.statusTrajet == 'ACTIF'}">
                            <c:set var="activeTripsFound" value="true" />
                            <div class="bg-white rounded-2xl shadow-md">
                                <div class="p-6">
                                    <div class="flex flex-col sm:flex-row sm:items-center sm:justify-between">
                                        <div>
                                            <h3 class="text-xl font-semibold text-gray-900">${offre.villeDepart} → ${offre.villeArrivee}</h3>
                                            <%
                                                if (pageContext.getAttribute("offre") != null) {
                                                    LocalDate date = ((com.covoiturage.model.Trajet)pageContext.getAttribute("offre")).getDateDepart();
                                                    String dateStr = date.format(DateTimeFormatter.ofPattern("EEEE d MMMM", Locale.FRENCH));
                                                    pageContext.setAttribute("formattedOffreDate", dateStr);
                                                }
                                            %>
                                            <p class="text-gray-500 mt-1 text-sm capitalize">${formattedOffreDate} à <c:out value="${offre.heureDepart}"/></p>
                                        </div>
                                        <div class="flex items-center text-sm space-x-4 text-gray-600 mt-3 sm:mt-0">
                                            <span><i class="fas fa-chair mr-1"></i> ${offre.placesDisponibles} places</span>
                                            <span><i class="fas fa-euro-sign mr-1"></i> <fmt:formatNumber value="${offre.prixParPlace}" type="currency" currencySymbol="€"/></span>
                                        </div>
                                    </div>
                                </div>
                                <div class="bg-gray-50 px-6 py-4 border-t rounded-b-2xl flex items-center justify-end space-x-3">
                                    <a href="gerer-trajet?id=${offre.id}" class="bg-blue-100 text-blue-800 font-medium py-2 px-4 rounded-lg hover:bg-blue-200">Gérer les réservations</a>
                                </div>
                            </div>
                        </c:if>
                    </c:forEach>
                    <c:if test="${not activeTripsFound}">
                        <p class="text-gray-500 bg-white p-6 rounded-lg shadow-sm">Vous n'avez aucun trajet actif pour le moment.</p>
                    </c:if>
                </div>
            </c:when>

            <%-- ================================================================= --%>
            <%--                           VUE PASSAGER                            --%>
            <%-- ================================================================= --%>
            <c:when test="${sessionScope.utilisateur.role == 'Passager'}">
                <div class="flex flex-col sm:flex-row justify-between items-start sm:items-center mb-8">
                    <div>
                        <h1 class="text-3xl md:text-4xl font-bold text-gray-800">Mes Réservations</h1>
                        <p class="mt-1 text-gray-600">Consultez vos réservations à venir et passées.</p>
                    </div>
                     <a href="index.jsp" class="mt-4 sm:mt-0 flex-shrink-0 bg-blue-600 text-white font-semibold px-5 py-2.5 rounded-lg shadow-sm hover:bg-blue-700 transition-colors flex items-center">
                        <i class="fas fa-search mr-2"></i> Trouver un trajet
                    </a>
                </div>
                
                <!-- Section des réservations à venir -->
                <h2 class="text-2xl font-semibold text-gray-800 mb-6">Réservations à venir</h2>
                <div class="space-y-6">
                    <c:set var="upcomingResFound" value="false" />
                    <c:forEach var="res" items="${listeReservations}">
                        <%  
                            if (pageContext.getAttribute("res") != null) {
                                LocalDate dateDepart = ((com.covoiturage.model.Reservation)pageContext.getAttribute("res")).getTrajet().getDateDepart();
                                boolean isUpcoming = dateDepart.isAfter(LocalDate.now()) || dateDepart.isEqual(LocalDate.now());
                                pageContext.setAttribute("isUpcoming", isUpcoming);
                            }
                        %>
                        <c:if test="${isUpcoming}">
                            <c:set var="upcomingResFound" value="true" />
                            <div class="bg-white rounded-2xl shadow-md p-6">
                                <div class="flex flex-col sm:flex-row sm:items-start sm:justify-between">
                                    <div>
                                        <div class="flex items-center mb-2">
                                            <h3 class="text-xl font-semibold text-gray-900">${res.trajet.villeDepart} → ${res.trajet.villeArrivee}</h3>
                                            <span class="ml-3 text-xs font-semibold inline-block py-1 px-2 uppercase rounded-full text-gray-600 bg-gray-200">${res.statusReservation}</span>
                                        </div>
                                        <%
                                            if (pageContext.getAttribute("res") != null) {
                                                LocalDate date = ((com.covoiturage.model.Reservation)pageContext.getAttribute("res")).getTrajet().getDateDepart();
                                                String dateStr = date.format(DateTimeFormatter.ofPattern("EEEE d MMMM", Locale.FRENCH));
                                                pageContext.setAttribute("formattedResDate", dateStr);
                                            }
                                        %>
                                        <p class="text-gray-500 mt-1 text-sm capitalize">${formattedResDate} à <c:out value="${res.trajet.heureDepart}"/></p>
                                        <div class="mt-3 text-sm text-gray-600 flex items-center">
                                            <i class="fas fa-user-circle text-gray-400 mr-2"></i>
                                            <span>Conducteur: <strong>${res.trajet.conducteur.prenom} ${res.trajet.conducteur.nom}</strong></span>
                                        </div>
                                    </div>
                                    <div class="flex-shrink-0 mt-4 sm:mt-0">
                                        <!-- Bouton simple et unique -->
                                        <a href="reservation?action=cancel&id=${res.id}" class="bg-red-100 text-red-800 font-medium py-2 px-4 rounded-lg hover:bg-red-200">Annuler</a>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                    </c:forEach>
                    <c:if test="${not upcomingResFound}">
                        <p class="text-gray-500 bg-white p-6 rounded-lg shadow-sm">Vous n'avez aucune réservation à venir.</p>
                    </c:if>
                </div>
            </c:when>
        </c:choose>
    </div>
</main>

<jsp:include page="footer.jsp" />
