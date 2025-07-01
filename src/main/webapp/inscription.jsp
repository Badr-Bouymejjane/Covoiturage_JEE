<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:set var="pageTitle" value="Inscription" />
<jsp:include page="header.jsp" />
<main class="main-content">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-6">
                <div class="card form-card">
                    <h2>Créer votre compte</h2>
                    <c:if test="${not empty erreur}"><div class="alert alert-danger"><c:out value="${erreur}"/></div></c:if>
                    <form action="inscription" method="post">
                        <div class="row mb-3">
                            <div class="col-md-6"><label class="form-label">Prénom</label><input type="text" class="form-control" name="prenom" required></div>
                            <div class="col-md-6"><label class="form-label">Nom</label><input type="text" class="form-control" name="nom" required></div>
                        </div>
                        <div class="mb-3"><label class="form-label">Email</label><input type="email" class="form-control" name="email" required></div>
                        <div class="mb-3"><label class="form-label">Mot de passe</label><input type="password" class="form-control" name="motDePasse" required></div>
                        <div class="mb-4"><label class="form-label">Je suis un...</label>
                            <div class="form-check"><input class="form-check-input" type="radio" name="role" value="Passager" checked><label class="form-check-label">Passager</label></div>
                            <div class="form-check"><input class="form-check-input" type="radio" name="role" value="Conducteur"><label class="form-check-label">Conducteur</label></div>
                        </div>
                        <div class="d-grid"><button type="submit" class="btn btn-primary btn-lg">Créer le compte</button></div>
                        <p class="text-center mt-3">Déjà un compte ? <a href="connexion.jsp">Connectez-vous</a></p>
                    </form>
                </div>
            </div>
        </div>
    </div>
</main>
<jsp:include page="footer.jsp" />