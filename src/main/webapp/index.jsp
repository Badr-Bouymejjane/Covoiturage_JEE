<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:set var="pageTitle" value="Find Your Perfect Ride" />
<jsp:include page="header.jsp" />

    <main class="main-content">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-7">
                    <div class="card form-card">
                        <h1>Find Your Perfect Ride</h1>
                        
                        <form action="trajets" method="get">
                            <input type="hidden" name="action" value="search">
                            <div class="mb-3">
                                <label for="villeDepart" class="form-label">Leaving from</label>
                                <input type="text" class="form-control" id="villeDepart" name="villeDepart" placeholder="Enter departure location" required>
                            </div>
                            <div class="mb-3">
                                <label for="villeArrivee" class="form-label">Going to</label>
                                <input type="text" class="form-control" id="villeArrivee" name="villeArrivee" placeholder="Enter destination" required>
                            </div>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="dateDepart" class="form-label">Date</label>
                                    <input type="date" class="form-control" id="dateDepart" name="dateDepart" required>
                                </div>
                                <div class="col-md-6 mb-4">
                                    <label for="places" class="form-label">Seats</label>
                                    <input type="number" class="form-control" id="places" name="places" value="1" min="1" required>
                                </div>
                            </div>
                            <div class="d-grid">
                                <button type="submit" class="btn btn-primary btn-lg">Search Rides</button>
                            </div>
                        </form>
                        
                        <p class="text-center mt-3">
                           Need to offer a ride instead? <a href="proposer-trajet.jsp">Publish a ride</a>
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </main>

<jsp:include page="footer.jsp" />
```
</html>