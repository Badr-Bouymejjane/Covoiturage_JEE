<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<c:set var="pageTitle" value="Détails du Trajet" />
<jsp:include page="header.jsp" />

<main class="main-content">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <c:if test="${not empty trajet}">
                    <div class="details-card">
                        <!-- Header -->
                        <div class="d-flex justify-content-between align-items-start mb-4">
                            <div class="details-header">
                                <h2><c:out value="${trajet.villeDepart}"/> → <c:out value="${trajet.villeArrivee}"/></h2>
                                <p class="text-muted fs-5">
                                    <%-- CORRECTION : On utilise c:out pour la date pour éviter l'erreur --%>
                                    <i class="bi bi-calendar-event"></i> <c:out value="${trajet.dateDepart}"/>
                                    <i class="bi bi-clock ms-3"></i> <c:out value="${trajet.heureDepart}"/>
                                </p>
                            </div>
                            <div class="price">
                                <fmt:formatNumber value="${trajet.prixParPlace}" type="currency" currencySymbol="€"/> / siège
                            </div>
                        </div>

                        <!-- Ride Details -->
                        <div class="details-section mb-4">
                            <h5>Ride Details</h5>
                            <table class="table table-borderless">
                                <tbody>
                                    <tr>
                                        <td class="text-muted">Places disponibles</td>
                                        <td><c:out value="${trajet.placesDisponibles}"/></td>
                                    </tr>
                                    <tr>
                                        <td class="text-muted">Bagages</td>
                                        <td>1 grand sac (à confirmer)</td>
                                    </tr>
                                     <tr>
                                        <td class="text-muted">Notes du conducteur</td>
                                        <td><c:out value="${not empty trajet.description ? trajet.description : 'Aucune note.'}"/></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>

                        <!-- Driver Info -->
                        <div class="details-section mb-4">
                            <h5>Your Driver</h5>
                            <div class="d-flex align-items-center driver-info">
                                <img src="https://i.pravatar.cc/60?u=${trajet.conducteur.email}" class="rounded-circle me-3" alt="Avatar du conducteur">
                                <div>
                                    <h6 class="mb-0 fw-bold"><c:out value="${trajet.conducteur.prenom} ${trajet.conducteur.nom}"/></h6>
                                    <span class="text-muted">4.9 ★ (123 rides)</span>
                                </div>
                            </div>
                        </div>

                        <!-- Action Button -->
                        <div class="d-grid mt-4">
    						<a href="reservation?action=request&trajetId=${trajet.id}" class="btn btn-primary btn-lg">Request This Ride</a>
						</div>
                    </div>
                </c:if>

                <c:if test="${empty trajet}">
                    <div class="alert alert-danger">Le trajet demandé n'a pas pu être trouvé.</div>
                </c:if>
            </div>
        </div>
    </div>
</main>

<jsp:include page="footer.jsp" />