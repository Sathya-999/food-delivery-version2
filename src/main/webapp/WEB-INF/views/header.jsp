<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="com.tap.fooddelivery.util.ImageRotationUtil" %>
<%
    // Set dynamic featured image for the week
    String featuredImage = ImageRotationUtil.getFeaturedImage();
    String featuredDish = ImageRotationUtil.getFeaturedDishName();
    int daysLeft = ImageRotationUtil.getDaysUntilNextRotation();
    request.setAttribute("featuredImage", featuredImage);
    request.setAttribute("featuredDish", featuredDish);
    request.setAttribute("daysLeft", daysLeft);
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle} - Andhra Food Delivery</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,800" rel="stylesheet">
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script> 
    <style>
        .andhra-header-banner {
            background-image: url('https://images.unsplash.com/photo-1589301760014-d929f3979dbc?w=1600&h=500&fit=crop');
            background-size: cover;
            background-position: center;
            padding: 80px 20px;
            text-align: center;
            color: white;
            margin-bottom: 20px;
            box-shadow: 0 6px 12px rgba(0,0,0,0.2);
            position: relative;
            overflow: hidden;
            min-height: 400px;
        }
        .andhra-header-banner::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(to bottom, rgba(139, 69, 19, 0.5), rgba(0, 0, 0, 0.8));
            z-index: 1;
        }
        .andhra-header-banner .content {
            position: relative;
            z-index: 2;
        }
        .andhra-header-banner h1 {
            font-size: 3em;
            margin: 0 0 20px 0;
            text-shadow: 3px 3px 6px rgba(0,0,0,0.8);
            font-weight: 800;
        }
        .andhra-header-banner .featured-dish {
            font-size: 1.8em;
            margin: 20px 0;
            padding: 15px 30px;
            background: rgba(218, 165, 32, 0.95);
            display: inline-block;
            border-radius: 30px;
            font-weight: 700;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.5);
        }
        .andhra-header-banner .rotation-info {
            font-size: 1em;
            margin-top: 15px;
            opacity: 0.98;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.8);
            font-weight: 500;
        }
    </style>
</head>
<body>

<!-- Andhra Pradesh Featured Header Banner -->
<div class="andhra-header-banner">
    <div class="content">
        <h1 style="font-size: 2.5em; margin-bottom: 30px; text-shadow: 4px 4px 8px rgba(0,0,0,0.9);">🍛 Authentic Andhra Pradesh Cuisine 🌶️</h1>
        <div style="background: rgba(255,255,255,0.15); backdrop-filter: blur(10px); padding: 30px; border-radius: 15px; display: inline-block; box-shadow: 0 8px 16px rgba(0,0,0,0.4);">
            <h2 style="margin: 0 0 15px 0; font-size: 2em; color: #FFD700; text-shadow: 3px 3px 6px rgba(0,0,0,0.8);">This Week's Special</h2>
            <p style="font-size: 2.5em; margin: 0; font-weight: 800; text-shadow: 3px 3px 6px rgba(0,0,0,0.8);">${featuredDish}</p>
            <p style="margin: 15px 0 0 0; font-size: 1.2em; opacity: 0.95; text-shadow: 2px 2px 4px rgba(0,0,0,0.8);">✨ Changes every 7 days | Next in ${daysLeft} days ✨</p>
        </div>
    </div>
</div>

<header>
    <a href="${pageContext.request.contextPath}/home" class="logo">🍛 Andhra Food Delivery</a>
    <nav>
        <a href="${pageContext.request.contextPath}/home" class="${pageTitle == 'Home' ? 'active' : ''}">Restaurants</a>
        <a href="${pageContext.request.contextPath}/history" class="${pageTitle == 'History' ? 'active' : ''}">Orders</a>
        <a href="${pageContext.request.contextPath}/cart">
            Cart
            <c:if test="${not empty sessionScope.cart && sessionScope.cart.items.size() > 0}">
                <span class="badge">${sessionScope.cart.items.size()}</span>
            </c:if>
        </a>
        <a href="${pageContext.request.contextPath}/logout">Logout (${sessionScope.user.username})</a>
    </nav>
</header>

<div class="container">

