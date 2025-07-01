<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:set var="pageTitle" value="Proposer un Trajet" />
<jsp:include page="header.jsp" />
    <main class="main-content">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-7">
                    <div class="card form-card">
                        <h2>Create a New Ride</h2>
                        <p class="text-muted text-center mb-4">Share your upcoming trip with fellow travelers.</p>
                        
                        <c:if test="${not empty erreur}">
                            <div class="alert alert-danger" role="alert"><c:out value="${erreur}"/></div>
                        </c:if>

                        <form action="trajets" method="post">
                            <input type="hidden" name="action" value="create">
                            <div class="mb-3">
                                <label class="form-label">From</label>
                                <input type="text" class="form-control" name="villeDepart" placeholder="Enter a city or address" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">To</label>
                                <input type="text" class="form-control" name="villeArrivee" placeholder="Enter a city or address" required>
                            </div>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Date</label>
                                    <input type="date" class="form-control" name="dateDepart" required>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Time</label>
                                    <input type="time" class="form-control" name="heureDepart" required>
                                </div>
                            </div>
                             <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Available seats</label>
                                    <input type="number" class="form-control" name="placesDisponibles" placeholder="e.g., 3" required min="1">
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Price per seat (€)</label>
                                    <input type="number" step="0.50" class="form-control" name="prixParPlace" placeholder="e.g., 15.00" required min="0">
                                </div>
                            </div>
                            <div class="mb-4">
                                <label class="form-label">Additional Notes (Optional)</label>
                                <textarea class="form-control" name="description" rows="3" placeholder="e.g., Luggage restrictions, pick-up details..."></textarea>
                            </div>
                            <div class="d-grid">
                                <button type="submit" class="btn btn-primary btn-lg">Publish Ride</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </main>
<jsp:include page="footer.jsp" />