<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.util.Locale" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

<c:set var="pageTitle" value="Gérer les Réservations" />
<fmt:setLocale value="fr_FR" />

<jsp:include page="header.jsp" />

<main class="flex-grow container mx-auto px-4 sm:px-6 lg:px-8 py-8">
    <div class="w-full max-w-4xl mx-auto">

        <c:choose>
            <c:when test="${not empty trajet}">
                <%-- Formatage de la date du trajet pour l'affichage --%>
                <%
                    if (request.getAttribute("trajet") != null) {
                        LocalDate date = ((com.covoiturage.model.Trajet)request.getAttribute("trajet")).getDateDepart();
                        String dateStr = date.format(DateTimeFormatter.ofPattern("EEEE d MMMM yyyy", Locale.FRENCH));
                        pageContext.setAttribute("formattedTrajetDate", dateStr);
                    }
                %>

                <!-- Fil d'Ariane et Titre -->
                <nav class="text-sm text-gray-500 mb-2">
                    <a href="mes-trajets" class="hover:text-blue-600">Mes Trajets</a>
                    <span class="mx-2">/</span>
                    <span>Gérer le trajet</span>
                </nav>
                <h1 class="text-3xl md:text-4xl font-bold text-gray-800">
                    Trajet <span class="text-blue-600">${trajet.villeDepart} → ${trajet.villeArrivee}</span>
                </h1>
                <p class="mt-1 text-gray-600 capitalize">Le ${formattedTrajetDate} à <c:out value="${trajet.heureDepart}"/></p>

                <!-- Carte de gestion des réservations -->
                <div class="mt-8 bg-white rounded-2xl shadow-lg">
                    <div class="p-6 border-b">
                        <h2 class="text-xl font-semibold text-gray-800">Demandes de réservation</h2>
                    </div>

                    <c:choose>
                        <c:when test="${not empty reservations}">
                            <ul class="divide-y divide-gray-200">
                                <c:forEach var="res" items="${reservations}">
                                    <li class="p-6 flex flex-col sm:flex-row justify-between items-center">
                                        <div class="flex items-center space-x-4">
                                            <img class="h-12 w-12 rounded-full object-cover" src="https://ui-avatars.com/api/?name=${res.passager.prenom}+${res.passager.nom}&background=random" alt="Avatar de ${res.passager.prenom}">
                                            <div>
                                                <p class="font-semibold text-gray-900">${res.passager.prenom} ${res.passager.nom}</p>
                                                <p class="text-sm text-gray-500">${res.nbrPlaces} place(s) demandée(s)</p>
                                            </div>
                                        </div>
                                        
                                        <!-- Boutons d'action -->
                                        <div class="flex items-center space-x-3 mt-4 sm:mt-0 flex-shrink-0">
                                            <c:choose>
                                                <c:when test="${res.statusReservation.toString() == 'DEMANDEE'}">
                                                    <a href="reservation?action=confirm&resId=${res.id}&trajetId=${trajet.id}&places=${res.nbrPlaces}" class="bg-green-100 text-green-800 font-bold py-2 px-4 rounded-lg hover:bg-green-200 text-sm">Accepter</a>
                                                    <a href="reservation?action=refuse&resId=${res.id}&trajetId=${trajet.id}" class="bg-red-100 text-red-800 font-bold py-2 px-4 rounded-lg hover:bg-red-200 text-sm">Refuser</a>
                                                </c:when>
                                                <c:when test="${res.statusReservation.toString() == 'CONFIRMEE'}">
                                                    <span class="text-xs font-semibold inline-block py-2 px-3 uppercase rounded-full text-green-600 bg-green-200">Confirmée</span>
                                                </c:when>
                                                <c:when test="${res.statusReservation.toString() == 'REFUSEE'}">
                                                    <span class="text-xs font-semibold inline-block py-2 px-3 uppercase rounded-full text-red-600 bg-red-200">Refusée</span>
                                                </c:when>
                                                 <c:when test="${res.statusReservation.toString() == 'ANNULEE'}">
                                                    <span class="text-xs font-semibold inline-block py-2 px-3 uppercase rounded-full text-gray-600 bg-gray-200">Annulée par le passager</span>
                                                </c:when>
                                            </c:choose>
                                        </div>
                                    </li>
                                </c:forEach>
                            </ul>
                        </c:when>
                        <c:otherwise>
                            <p class="p-6 text-gray-500">Aucune demande de réservation pour ce trajet pour le moment.</p>
                        </c:otherwise>
                    </c:choose>
                </div>
            </c:when>
            <c:otherwise>
                 <div class="text-center mt-12 bg-white p-8 rounded-lg shadow">
                    <h2 class="text-2xl font-semibold text-gray-700">Trajet non trouvé</h2>
                    <p class="text-gray-500 mt-2">Le trajet que vous essayez de gérer n'existe pas.</p>
                    <a href="mes-trajets" class="mt-4 inline-block text-blue-600 font-medium hover:underline">Retour à mes trajets</a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</main>

<jsp:include page="footer.jsp" />
