<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>${pageTitle} - RideOn</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-light bg-white">
        <div class="container">
            <a class="navbar-brand" href="index.jsp">RideOn</a>
            <div class="collapse navbar-collapse">
                <ul class="navbar-nav ms-auto align-items-center">
                    <c:choose>
                        <c:when test="${not empty sessionScope.utilisateur}">
                            <li class="nav-item"><a class="nav-link" href="index.jsp">Rechercher</a></li>
                            <c:if test="${sessionScope.utilisateur.role == 'Conducteur'}">
                                <li class="nav-item"><a class="nav-link" href="proposer-trajet.jsp">Proposer un trajet</a></li>
                            </c:if>
                            <li class="nav-item"><a class="nav-link" href="mes-trajets">Mes Trajets</a></li>
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown">
                                    <img src="https://i.pravatar.cc/40?u=${sessionScope.utilisateur.email}" class="rounded-circle">
                                </a>
                                <ul class="dropdown-menu dropdown-menu-end">
                                    <li><a class="dropdown-item" href="#">Profil</a></li>
                                    <li><a class="dropdown-item" href="deconnexion">Déconnexion</a></li>
                                </ul>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li class="nav-item"><a class="nav-link" href="connexion.jsp">Se connecter</a></li>
                            <li class="nav-item"><a class="btn btn-primary ms-2" href="inscription.jsp">S'inscrire</a></li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </div>
    </nav>