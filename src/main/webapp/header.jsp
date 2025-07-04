<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <title>CovoiturageApp - <c:out value="${pageTitle}"/></title>
    
    <!-- Tailwind CSS via CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    
    <!-- Font Awesome pour les icônes (AJOUT) -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    
    <!-- Google Fonts: Inter -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    
    <style>
        body {
            font-family: 'Inter', sans-serif;
            background-color: #f8f9fa;
        }
    </style>
</head>
<body class="flex flex-col min-h-screen">

    <!-- Header avec navigation dynamique -->
    <header class="bg-white shadow-sm sticky top-0 z-50">
        <div class="container mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex justify-between items-center h-16">
                <a href="index.jsp" class="text-2xl font-bold text-blue-600">CovoiturageApp</a>
                
                <c:choose>
                    <c:when test="${not empty sessionScope.utilisateur}">
                        <div class="flex items-center space-x-6">
                            <a href="index.jsp" class="text-gray-600 hover:text-blue-600 font-medium">Trouver un trajet</a>
                            <c:if test="${sessionScope.utilisateur.role == 'Conducteur'}">
                                <a href="proposer-trajet.jsp" class="text-gray-600 hover:text-blue-600 font-medium">Proposer un trajet</a>
                            </c:if>
                            <a href="mes-trajets" class="text-gray-600 hover:text-blue-600 font-medium">Mes Trajets</a>
                            <a href="profil.jsp" class="flex items-center space-x-2">
                               <span class="font-medium text-gray-700">Bonjour, <c:out value="${sessionScope.utilisateur.prenom}"/></span>
                               <img class="h-8 w-8 rounded-full" src="https://ui-avatars.com/api/?name=${sessionScope.utilisateur.prenom}+${sessionScope.utilisateur.nom}&background=0D8ABC&color=fff" alt="Avatar">
                            </a>
                            <a href="deconnexion" class="text-gray-600 hover:text-blue-600 font-medium">Déconnexion</a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="flex items-center space-x-4">
                            <a href="connexion.jsp" class="text-gray-600 hover:text-blue-600 font-medium">Connexion</a>
                            <a href="inscription.jsp" class="bg-blue-600 text-white font-semibold px-4 py-2 rounded-lg shadow-sm hover:bg-blue-700 transition-colors">Inscription</a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </header>
