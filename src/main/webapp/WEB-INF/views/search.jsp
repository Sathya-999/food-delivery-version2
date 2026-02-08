<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Search - FoodLoop</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Poppins', sans-serif; background: linear-gradient(135deg, #fff5f0 0%, #fff 100%); min-height: 100vh; }
        
        .navbar {
            background: #fff;
            padding: 15px 40px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            box-shadow: 0 2px 10px rgba(0,0,0,0.08);
            position: sticky;
            top: 0;
            z-index: 100;
        }
        .logo { font-size: 26px; font-weight: 700; color: #fc8019; text-decoration: none; }
        .search-form {
            display: flex;
            align-items: center;
            background: #f5f5f5;
            border-radius: 25px;
            padding: 12px 20px;
            gap: 10px;
            min-width: 400px;
            border: 2px solid transparent;
            transition: all 0.3s;
        }
        .search-form:focus-within { border-color: #fc8019; background: #fff; }
        .search-form input {
            border: none;
            background: transparent;
            outline: none;
            font-size: 14px;
            width: 100%;
        }
        .nav-links { display: flex; gap: 24px; }
        .nav-links a { color: #3d4152; text-decoration: none; font-weight: 500; transition: color 0.2s; }
        .nav-links a:hover { color: #fc8019; }
        
        .container { max-width: 1200px; margin: 0 auto; padding: 30px 20px; }
        
        .search-header {
            text-align: center;
            margin-bottom: 40px;
        }
        .search-header h1 { 
            font-size: 32px; 
            color: #1c1c1c; 
            margin-bottom: 10px;
        }
        .search-header p { color: #686b78; font-size: 16px; }
        .search-header span { color: #fc8019; font-weight: 600; }
        
        .sort-info {
            text-align: center;
            margin-bottom: 30px;
            color: #686b78;
            font-size: 14px;
        }
        .sort-info span { 
            background: #fc8019; 
            color: white; 
            padding: 5px 15px; 
            border-radius: 20px;
            font-weight: 500;
        }
        
        .food-grid {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 30px;
        }
        
        /* Circular Card Design */
        .food-card {
            width: 280px;
            height: 280px;
            border-radius: 50%;
            background: white;
            box-shadow: 0 10px 40px rgba(252, 128, 25, 0.15);
            overflow: hidden;
            cursor: pointer;
            text-decoration: none;
            color: inherit;
            transition: all 0.3s ease;
            position: relative;
        }
        .food-card:hover {
            transform: scale(1.05);
            box-shadow: 0 15px 50px rgba(252, 128, 25, 0.25);
        }
        
        /* Top half - Image */
        .food-image-half {
            width: 100%;
            height: 50%;
            overflow: hidden;
            position: relative;
        }
        .food-image-half img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        .food-image-half::after {
            content: '';
            position: absolute;
            bottom: -20px;
            left: 0;
            right: 0;
            height: 40px;
            background: white;
            border-radius: 50% 50% 0 0;
        }
        
        /* Bottom half - Details */
        .food-details-half {
            width: 100%;
            height: 50%;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            padding: 10px 20px;
            text-align: center;
            position: relative;
            z-index: 1;
        }
        
        .food-name {
            font-size: 16px;
            font-weight: 700;
            color: #1c1c1c;
            margin-bottom: 5px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            max-width: 200px;
        }
        .food-restaurant {
            font-size: 12px;
            color: #fc8019;
            margin-bottom: 8px;
        }
        .food-price {
            font-size: 22px;
            font-weight: 800;
            color: #fc8019;
            background: linear-gradient(135deg, #fc8019, #ff6b35);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }
        .food-category {
            font-size: 11px;
            color: #999;
            margin-top: 5px;
        }
        
        .no-results {
            text-align: center;
            padding: 80px 20px;
        }
        .no-results-icon { font-size: 80px; margin-bottom: 20px; }
        .no-results h3 { font-size: 24px; margin-bottom: 10px; color: #1c1c1c; }
        .no-results p { color: #686b78; margin-bottom: 25px; }
        .back-btn {
            background: linear-gradient(135deg, #fc8019, #ff6b35);
            color: white;
            padding: 14px 30px;
            border-radius: 30px;
            text-decoration: none;
            font-weight: 600;
            display: inline-block;
            transition: transform 0.2s;
        }
        .back-btn:hover { transform: scale(1.05); }
    </style>
</head>
<body>

<nav class="navbar">
    <a href="home" class="logo">🍽️ FoodLoop</a>
    <form action="search" method="get" class="search-form">
        <span>🔍</span>
        <input type="text" name="q" value="${searchQuery}" placeholder="Search for delicious food...">
    </form>
    <div class="nav-links">
        <a href="home">🏠 Home</a>
        <a href="history">📋 Orders</a>
        <a href="cart">🛒 Cart</a>
    </div>
</nav>

<div class="container">
    <div class="search-header">
        <h1>🔍 Search Results</h1>
        <p>Found <span id="count">${menuItems.size()}</span> delicious items for "<span>${searchQuery}</span>"</p>
    </div>
    
    <c:if test="${not empty menuItems}">
        <div class="sort-info">
            <span>📊 Sorted by Price: Low → High</span>
        </div>
    </c:if>
    
    <c:if test="${empty menuItems}">
        <div class="no-results">
            <div class="no-results-icon">🍽️</div>
            <h3>No dishes found</h3>
            <p>We couldn't find any dishes matching "${searchQuery}"</p>
            <a href="home" class="back-btn">← Back to Home</a>
        </div>
    </c:if>
    
    <c:if test="${not empty menuItems}">
        <div class="food-grid" id="foodGrid">
            <c:forEach var="item" items="${menuItems}">
                <a href="menu?restaurantId=${item.restaurantId}" class="food-card" data-price="${item.price}">
                    <div class="food-image-half">
                        <img src="${item.imagePath}" alt="${item.itemName}"
                             onerror="this.closest('.food-card').remove(); updateCount();">
                    </div>
                    <div class="food-details-half">
                        <div class="food-name">${item.itemName}</div>
                        <div class="food-restaurant">🏪 ${restaurantNames[item.restaurantId]}</div>
                        <div class="food-price">₹${item.price}</div>
                        <div class="food-category">${item.category}</div>
                    </div>
                </a>
            </c:forEach>
        </div>
    </c:if>
</div>

<script>
// Sort cards by price (ascending)
document.addEventListener('DOMContentLoaded', function() {
    const grid = document.getElementById('foodGrid');
    if (grid) {
        const cards = Array.from(grid.querySelectorAll('.food-card'));
        cards.sort((a, b) => {
            const priceA = parseFloat(a.dataset.price) || 0;
            const priceB = parseFloat(b.dataset.price) || 0;
            return priceA - priceB;
        });
        cards.forEach(card => grid.appendChild(card));
    }
});

function updateCount() {
    const count = document.querySelectorAll('.food-card').length;
    const countEl = document.getElementById('count');
    if (countEl) countEl.textContent = count;
    if (count === 0) {
        document.getElementById('foodGrid').innerHTML = '<div class="no-results"><div class="no-results-icon">🍽️</div><h3>No dishes found</h3><a href="home" class="back-btn">← Back to Home</a></div>';
    }
}
</script>

</body>
</html>

