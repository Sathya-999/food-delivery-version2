<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Menu - FoodLoop</title>
            <link rel="icon" type="image/svg+xml" href="${pageContext.request.contextPath}/favicon.svg">
            <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap"
                rel="stylesheet">
            <style>
                * {
                    margin: 0;
                    padding: 0;
                    box-sizing: border-box;
                }

                body {
                    font-family: 'Poppins', sans-serif;
                    background: #f8f8f8;
                    color: #3d4152;
                }

                .navbar {
                    position: sticky;
                    top: 0;
                    z-index: 1000;
                    background: #fff;
                    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
                    padding: 0 40px;
                    height: 70px;
                    display: flex;
                    align-items: center;
                    justify-content: space-between;
                }

                .nav-left {
                    display: flex;
                    align-items: center;
                    gap: 20px;
                }

                .back-btn {
                    display: flex;
                    align-items: center;
                    gap: 8px;
                    color: #3d4152;
                    text-decoration: none;
                    font-weight: 500;
                    font-size: 15px;
                    padding: 8px 16px;
                    border-radius: 8px;
                    transition: all 0.2s;
                }

                .back-btn:hover {
                    background: #f2f2f2;
                    color: #fc8019;
                }

                .logo {
                    font-size: 26px;
                    font-weight: 800;
                    color: #fc8019;
                    text-decoration: none;
                }

                .nav-right {
                    display: flex;
                    align-items: center;
                    gap: 30px;
                }

                .nav-item {
                    display: flex;
                    align-items: center;
                    gap: 8px;
                    font-size: 15px;
                    font-weight: 500;
                    color: #3d4152;
                    text-decoration: none;
                    cursor: pointer;
                }

                .nav-item:hover {
                    color: #fc8019;
                }

                .menu-container {
                    max-width: 1300px;
                    margin: 0 auto;
                    padding: 30px 40px;
                }

                .menu-header {
                    margin-bottom: 30px;
                }

                .menu-header h1 {
                    font-size: 28px;
                    font-weight: 700;
                    color: #1c1c1c;
                    margin-bottom: 8px;
                }

                .menu-header p {
                    color: #7e808c;
                    font-size: 15px;
                }

                .menu-grid {
                    display: grid;
                    grid-template-columns: repeat(4, 1fr);
                    gap: 16px;
                }

                .menu-card {
                    background: white;
                    border-radius: 12px;
                    overflow: hidden;
                    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.06);
                    transition: all 0.3s ease;
                    display: flex;
                    flex-direction: row;
                    align-items: center;
                    padding: 12px;
                    gap: 12px;
                }

                .menu-card:hover {
                    transform: translateY(-2px);
                    box-shadow: 0 4px 16px rgba(0, 0, 0, 0.1);
                }

                .menu-card-image {
                    width: 70px;
                    height: 70px;
                    min-width: 70px;
                    border-radius: 50%;
                    overflow: hidden;
                    border: 2px solid #fc8019;
                }

                .menu-card-image img {
                    width: 100%;
                    height: 100%;
                    object-fit: cover;
                    transition: transform 0.4s ease;
                }

                .menu-card:hover .menu-card-image img {
                    transform: scale(1.1);
                }

                .menu-card-info {
                    flex: 1;
                    padding: 0;
                }

                .menu-card-name {
                    font-size: 14px;
                    font-weight: 600;
                    color: #1c1c1c;
                    margin-bottom: 2px;
                    white-space: nowrap;
                    overflow: hidden;
                    text-overflow: ellipsis;
                }

                .menu-card-category {
                    font-size: 11px;
                    color: #7e808c;
                    margin-bottom: 2px;
                }

                .menu-card-spice {
                    font-size: 10px;
                    color: #93959f;
                    margin-bottom: 4px;
                }

                .menu-card-price {
                    font-size: 16px;
                    font-weight: 700;
                    color: #fc8019;
                    margin-bottom: 6px;
                }

                .menu-card-actions {
                    display: none;
                }

                .qty-input {
                    width: 32px;
                    height: 28px;
                    border: 1px solid #d4d5d9;
                    border-radius: 6px;
                    text-align: center;
                    font-size: 12px;
                    font-weight: 600;
                    font-family: inherit;
                }

                .qty-input:focus {
                    outline: none;
                    border-color: #fc8019;
                }

                .add-to-cart-btn {
                    flex: 1;
                    height: 28px;
                    background: #fc8019;
                    color: white;
                    border: none;
                    border-radius: 14px;
                    font-size: 10px;
                    font-weight: 600;
                    text-transform: uppercase;
                    cursor: pointer;
                    transition: all 0.2s;
                }

                .add-to-cart-btn:hover {
                    background: #e07016;
                }

                .buy-now-btn {
                    flex: 1;
                    height: 28px;
                    background: linear-gradient(135deg, #28a745, #20c997);
                    color: white;
                    border: none;
                    border-radius: 14px;
                    font-size: 10px;
                    font-weight: 600;
                    text-transform: uppercase;
                    cursor: pointer;
                    transition: all 0.2s;
                }

                .buy-now-btn:hover {
                    background: linear-gradient(135deg, #218838, #1db988);
                }

                .menu-card-buttons {
                    display: flex;
                    gap: 4px;
                    margin-top: 4px;
                }

                @media (max-width: 1100px) {
                    .menu-grid {
                        grid-template-columns: repeat(2, 1fr);
                    }
                }

                @media (max-width: 700px) {
                    .menu-grid {
                        grid-template-columns: 1fr;
                    }

                    .menu-container {
                        padding: 20px;
                    }

                    .navbar {
                        padding: 0 20px;
                    }
                }
            </style>
        </head>

        <body>

            <nav class="navbar">
                <div class="nav-left">
                    <a href="home" class="back-btn">← Back</a>
                    <a href="home" class="logo">FoodLoop</a>
                </div>
                <div class="nav-right">
                    <a href="cart" class="nav-item">🛒 Cart</a>
                    <a href="login" class="nav-item">👤 Sign In</a>
                </div>
            </nav>

            <div class="menu-container">
                <div class="menu-header">
                    <h1>Visakhapatnam Beach Restaurant</h1>
                    <p>Seafood, Coastal Andhra • Spicy & Flavorful</p>
                </div>

                <c:if test="${empty menus}">
                    <p style="text-align:center; padding:2rem; color:#999;">No menu items available</p>
                </c:if>

                <div class="menu-grid">
                    <c:forEach var="menu" items="${menus}">
                        <div class="menu-card">
                            <div class="menu-card-image">
                                <c:choose>
                                    <c:when test="${not empty menu.imagePath}">
                                        <img src="${pageContext.request.contextPath}/${menu.imagePath}"
                                            alt="${menu.itemName}">
                                    </c:when>
                                    <c:otherwise>
                                        <img src="${pageContext.request.contextPath}/images/food/traditional%20meal.jpg"
                                            alt="${menu.itemName}">
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="menu-card-info">
                                <div class="menu-card-name">${menu.itemName}</div>
                                <div class="menu-card-category">${menu.category}</div>
                                <div class="menu-card-spice">Spice: ${menu.spiceLevel}</div>
                                <div class="menu-card-price">₹${menu.price}</div>
                                <div class="menu-card-actions">
                                    <input type="number" id="qty-${menu.menuId}" value="1" min="1" max="10"
                                        class="qty-input">
                                </div>
                                <div class="menu-card-buttons">
                                    <form action="cart" method="post" style="flex:1;">
                                        <input type="hidden" name="action" value="add">
                                        <input type="hidden" name="menuId" value="${menu.menuId}">
                                        <input type="hidden" name="quantity" class="qty-hidden-${menu.menuId}"
                                            value="1">
                                        <button type="submit" class="add-to-cart-btn" style="width:100%;"
                                            onclick="this.form.querySelector('.qty-hidden-${menu.menuId}').value = document.getElementById('qty-${menu.menuId}').value;">🛒
                                            ADD</button>
                                    </form>
                                    <form action="cart" method="post" style="flex:1;">
                                        <input type="hidden" name="action" value="add">
                                        <input type="hidden" name="menuId" value="${menu.menuId}">
                                        <input type="hidden" name="quantity" class="qty-hidden2-${menu.menuId}"
                                            value="1">
                                        <input type="hidden" name="redirect" value="checkout">
                                        <button type="submit" class="buy-now-btn" style="width:100%;"
                                            onclick="this.form.querySelector('.qty-hidden2-${menu.menuId}').value = document.getElementById('qty-${menu.menuId}').value;">⚡
                                            BUY NOW</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>

        </body>

        </html>