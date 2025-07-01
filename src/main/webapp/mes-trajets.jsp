<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:set var="pageTitle" value="Mes Trajets" />
<jsp:include page="header.jsp" />
<main class="main-content">
    <div class="container">
        <h2 class="mb-4 fw-bold">My Trips</h2>
        
        <c:choose>
            <c:when test="${sessionScope.utilisateur.role == 'Conducteur'}">
                <h4>Mes Offres Publiées</h4>
                <c:forEach var="offre" items="${listeOffres}">
                    <div class="card mb-4">
                        <div class="card-header d-flex justify-content-between">
                            <strong>${offre.villeDepart} → ${offre.villeArrivee}</strong>
                            <span>Statut : <span class="badge bg-info">${offre.statusTrajet}</span></span>
                        </div>
                        <div class="card-body">
                            <h5 class="card-title">Demandes de réservation</h5>
                            <c:set var="demandes" value="${demandesParTrajet[offre.id]}" />
                            <c:if test="${empty demandes}">
                                <p class="text-muted">Aucune demande pour ce trajet pour le moment.</p>
                            </c:if>
                            <c:if test="${not empty demandes}">
                                <ul class="list-group">
                                    <c:forEach var="demande" items="${demandes}">
                                        <li class="list-group-item d-flex justify-content-between align-items-center">
                                            <span>
                                                <img src="https://i.pravatar.cc/30?u=${demande.passager.email}" class="rounded-circle me-2">
                                                ${demande.passager.prenom} ${demande.passager.nom}
                                            </span>
                                            <c:choose>
                                                <c:when test="${demande.statusReservation == 'DEMANDEE'}">
                                                    <div>
                                                        <a href="reservation?action=update&id=${demande.id}&status=CONFIRMEE" class="btn btn-success btn-sm">Confirmer</a>
                                                        <a href="reservation?action=update&id=${demande.id}&status=REFUSEE" class="btn btn-danger btn-sm">Refuser</a>
                                                    </div>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-secondary">${demande.statusReservation}</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </c:if>
                        </div>
                    </div>
                </c:forEach>
            </c:when>

            <c:when test="${sessionScope.utilisateur.role == 'Passager'}">
                <h4>Mes Réservations</h4>
                <%-- Le code pour afficher les réservations du passager reste le même --%>
            </c:when>
        </c:choose>
    </div>
</main>
<jsp:include page="footer.jsp" />