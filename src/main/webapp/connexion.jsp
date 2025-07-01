<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:set var="pageTitle" value="Connexion" />
<jsp:include page="header.jsp" />
<main class="main-content">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-5">
                <div class="card form-card">
                    <h2>Content de vous revoir !</h2>
                    <c:if test="${not empty requestScope.erreur}"><div class="alert alert-danger"><c:out value="${requestScope.erreur}"/></div></c:if>
                    <c:if test="${param.inscription == 'succes'}"><div class="alert alert-success">Inscription réussie !</div></c:if>
                    <form action="connexion" method="post">
                        <div class="mb-3"><label class="form-label">Email</label><input type="email" class="form-control" name="email" required></div>
                        <div class="mb-4"><label class="form-label">Mot de passe</label><input type="password" class="form-control" name="motDePasse" required></div>
                        <div class="d-grid"><button type="submit" class="btn btn-primary btn-lg">Se connecter</button></div>
                        <p class="text-center mt-3">Pas encore de compte ? <a href="inscription.jsp">Inscrivez-vous</a></p>
                    </form>
                </div>
            </div>
        </div>
    </div>
</main>
<jsp:include page="footer.jsp" />