<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:set var="pageTitle" value="Résultats de recherche" />
<jsp:include page="header.jsp" />

<main class="main-content">
    <div class="container">
        <p class="text-muted">Ride / Search Results</p>
        <h2 class="mb-4 fw-bold">Trajets de ${villeDepart} à ${villeArrivee}</h2>
        
        <c:choose>
            <c:when test="${not empty listeTrajets}">
                <c:forEach var="trajet" items="${listeTrajets}">
                    <a href="trajets?action=details&id=${trajet.id}" class="trip-card">
                        <img src="https://i.pravatar.cc/50?u=${trajet.conducteur.email}" class="avatar" alt="Avatar du conducteur">
                        <div class="trip-info">
                            <h5><c:out value="${trajet.conducteur.prenom} ${trajet.conducteur.nom}"/></h5>
                            <div class="trip-details">
                                <%-- CORRECTION : On affiche simplement l'heure du départ --%>
                                <c:out value="${trajet.heureDepart}"/>
                            </div>
                        </div>
                        <div class="trip-price">
                            <button class="btn btn-primary view-trip-btn">View Trip &rarr;</button>
                        </div>
                    </a>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div class="text-center mt-5">
                    <p>Aucun trajet trouvé pour ces dates.</p>
                    <a href="index.jsp">Chercher pour d'autres dates</a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</main>

<jsp:include page="footer.jsp" />