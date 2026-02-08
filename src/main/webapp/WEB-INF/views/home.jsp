<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>FoodLoop - Order Food Online</title>
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
                    background: #f5f5f5;
                    color: #3d4152;
                }

                /* NAVBAR */
                .navbar {
                    position: sticky;
                    top: 0;
                    z-index: 1000;
                    background: #fff;
                    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
                    padding: 0 40px;
                    height: 80px;
                    display: flex;
                    align-items: center;
                    justify-content: space-between;
                }

                .nav-left {
                    display: flex;
                    align-items: center;
                    gap: 30px;
                }

                .logo {
                    font-size: 28px;
                    font-weight: 800;
                    color: #fc8019;
                    text-decoration: none;
                    letter-spacing: -1px;
                }

                .location-selector {
                    display: flex;
                    align-items: center;
                    gap: 8px;
                    cursor: pointer;
                    padding: 8px 12px;
                    border-radius: 8px;
                    transition: background 0.2s;
                }

                .location-selector:hover {
                    background: #f2f2f2;
                }

                .location-icon {
                    font-size: 18px;
                }

                .location-text {
                    font-size: 14px;
                    font-weight: 500;
                    max-width: 200px;
                    overflow: hidden;
                    text-overflow: ellipsis;
                    white-space: nowrap;
                }

                .location-text span {
                    color: #686b78;
                    font-weight: 400;
                }

                .nav-right {
                    display: flex;
                    align-items: center;
                    gap: 40px;
                }

                .nav-item {
                    display: flex;
                    align-items: center;
                    gap: 10px;
                    font-size: 16px;
                    font-weight: 500;
                    color: #3d4152;
                    text-decoration: none;
                    cursor: pointer;
                    transition: color 0.2s;
                }

                .nav-item:hover {
                    color: #fc8019;
                }

                .nav-icon {
                    font-size: 20px;
                }

                .search-container {
                    position: relative;
                    min-width: 400px;
                }

                .search-bar {
                    display: flex;
                    align-items: center;
                    background: #fff;
                    border: 2px solid #e8e8e8;
                    border-radius: 30px;
                    padding: 12px 20px;
                    gap: 12px;
                    transition: all 0.3s ease;
                    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.04);
                }

                .search-bar:focus-within {
                    border-color: #fc8019;
                    box-shadow: 0 4px 20px rgba(252, 128, 25, 0.15);
                    background: #fff;
                }

                .search-bar .search-icon {
                    color: #93959f;
                    font-size: 18px;
                    transition: color 0.3s;
                }

                .search-bar:focus-within .search-icon {
                    color: #fc8019;
                }

                .search-bar input {
                    border: none;
                    background: transparent;
                    outline: none;
                    font-size: 15px;
                    width: 100%;
                    font-family: inherit;
                    color: #3d4152;
                }

                .search-bar input::placeholder {
                    color: #93959f;
                }

                .search-clear {
                    display: none;
                    background: #e8e8e8;
                    border: none;
                    border-radius: 50%;
                    width: 22px;
                    height: 22px;
                    font-size: 14px;
                    cursor: pointer;
                    color: #686b78;
                    transition: all 0.2s;
                }

                .search-clear:hover {
                    background: #fc8019;
                    color: white;
                }

                .search-bar.has-text .search-clear {
                    display: flex;
                    align-items: center;
                    justify-content: center;
                }

                /* Search Suggestions Dropdown */
                .search-suggestions {
                    position: absolute;
                    top: 100%;
                    left: 0;
                    right: 0;
                    background: white;
                    border-radius: 16px;
                    box-shadow: 0 8px 30px rgba(0, 0, 0, 0.12);
                    margin-top: 8px;
                    overflow: hidden;
                    display: none;
                    z-index: 1001;
                    max-height: 400px;
                    overflow-y: auto;
                }

                .search-suggestions.active {
                    display: block;
                    animation: slideDown 0.2s ease;
                }

                @keyframes slideDown {
                    from {
                        opacity: 0;
                        transform: translateY(-10px);
                    }

                    to {
                        opacity: 1;
                        transform: translateY(0);
                    }
                }

                .suggestion-header {
                    padding: 12px 20px 8px;
                    font-size: 12px;
                    font-weight: 600;
                    color: #93959f;
                    text-transform: uppercase;
                    letter-spacing: 0.5px;
                    border-bottom: 1px solid #f2f2f2;
                }

                .suggestion-item {
                    display: flex;
                    align-items: center;
                    padding: 12px 20px;
                    cursor: pointer;
                    transition: background 0.15s;
                    gap: 14px;
                }

                .suggestion-item:hover,
                .suggestion-item.active {
                    background: #fff5ef;
                }

                .suggestion-icon {
                    width: 40px;
                    height: 40px;
                    border-radius: 10px;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    font-size: 18px;
                    flex-shrink: 0;
                }

                .suggestion-icon.restaurant {
                    background: #e3f2fd;
                }

                .suggestion-icon.food {
                    background: #fff3e0;
                }

                .suggestion-icon.cuisine {
                    background: #f3e5f5;
                }

                .suggestion-icon.category {
                    background: #e8f5e9;
                }

                .suggestion-text {
                    flex: 1;
                    min-width: 0;
                }

                .suggestion-name {
                    font-size: 14px;
                    font-weight: 500;
                    color: #3d4152;
                    white-space: nowrap;
                    overflow: hidden;
                    text-overflow: ellipsis;
                }

                .suggestion-name mark {
                    background: #fff3cd;
                    color: #3d4152;
                    padding: 0 2px;
                    border-radius: 2px;
                }

                .suggestion-sub {
                    font-size: 12px;
                    color: #93959f;
                }

                .suggestion-arrow {
                    color: #ccc;
                    font-size: 14px;
                }

                .search-footer {
                    padding: 12px 20px;
                    background: #fafafa;
                    border-top: 1px solid #f2f2f2;
                    display: flex;
                    align-items: center;
                    justify-content: space-between;
                }

                .search-footer span {
                    font-size: 12px;
                    color: #93959f;
                }

                .search-footer kbd {
                    background: #e8e8e8;
                    padding: 2px 6px;
                    border-radius: 4px;
                    font-size: 11px;
                    font-family: inherit;
                }

                .no-results {
                    padding: 30px 20px;
                    text-align: center;
                    color: #93959f;
                }

                .no-results .no-icon {
                    font-size: 40px;
                    margin-bottom: 10px;
                }

                .recent-searches {
                    padding: 8px 0;
                }

                .recent-item {
                    display: flex;
                    align-items: center;
                    padding: 10px 20px;
                    gap: 12px;
                    cursor: pointer;
                    transition: background 0.15s;
                }

                /* Food Suggestions Grid with Images */
                .food-suggestions-grid {
                    display: grid;
                    grid-template-columns: repeat(auto-fill, minmax(150px, 1fr));
                    gap: 12px;
                    padding: 12px 15px;
                    max-height: 280px;
                    overflow-y: auto;
                }

                .food-suggestion-card {
                    background: white;
                    border-radius: 12px;
                    overflow: hidden;
                    cursor: pointer;
                    transition: all 0.2s ease;
                    border: 1px solid #f0f0f0;
                    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.06);
                }

                .food-suggestion-card:hover {
                    transform: translateY(-3px);
                    box-shadow: 0 6px 20px rgba(252, 128, 25, 0.2);
                    border-color: #fc8019;
                }

                .food-card-image {
                    height: 100px;
                    background-size: cover;
                    background-position: center;
                    background-color: #f5f5f5;
                    position: relative;
                }

                .food-card-image::after {
                    content: '';
                    position: absolute;
                    bottom: 0;
                    left: 0;
                    right: 0;
                    height: 40px;
                    background: linear-gradient(transparent, rgba(0, 0, 0, 0.3));
                }

                .food-card-info {
                    padding: 10px;
                }

                .food-card-name {
                    font-size: 13px;
                    font-weight: 600;
                    color: #3d4152;
                    white-space: nowrap;
                    overflow: hidden;
                    text-overflow: ellipsis;
                    margin-bottom: 4px;
                }

                .food-card-name mark {
                    background: #fff3cd;
                    color: #3d4152;
                    padding: 0 2px;
                    border-radius: 2px;
                }

                .food-card-restaurant {
                    font-size: 11px;
                    color: #93959f;
                    white-space: nowrap;
                    overflow: hidden;
                    text-overflow: ellipsis;
                    margin-bottom: 4px;
                }

                .food-card-price {
                    font-size: 13px;
                    font-weight: 600;
                    color: #fc8019;
                }

                .search-suggestions {
                    max-height: 500px;
                }

                .recent-item:hover {
                    background: #f5f5f5;
                }

                .recent-icon {
                    color: #93959f;
                }

                .cart-badge {
                    position: relative;
                }

                .cart-count {
                    position: absolute;
                    top: -8px;
                    right: -8px;
                    background: #fc8019;
                    color: white;
                    font-size: 11px;
                    font-weight: 600;
                    width: 18px;
                    height: 18px;
                    border-radius: 50%;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                }

                /* HERO SECTION */
                .hero {
                    background: linear-gradient(135deg, #ff8a00 0%, #fc8019 50%, #ff5200 100%);
                    padding: 60px 40px;
                    position: relative;
                    overflow: hidden;
                }

                .hero-content {
                    max-width: 1200px;
                    margin: 0 auto;
                    display: flex;
                    align-items: center;
                    justify-content: space-between;
                    position: relative;
                    z-index: 2;
                }

                .hero-text {
                    color: white;
                    max-width: 500px;
                }

                .hero-text h1 {
                    font-size: 48px;
                    font-weight: 800;
                    line-height: 1.2;
                    margin-bottom: 16px;
                }

                .hero-text p {
                    font-size: 18px;
                    opacity: 0.9;
                    margin-bottom: 24px;
                }

                .hero-btn {
                    background: white;
                    color: #fc8019;
                    padding: 14px 32px;
                    border-radius: 10px;
                    font-size: 16px;
                    font-weight: 600;
                    border: none;
                    cursor: pointer;
                    transition: transform 0.2s, box-shadow 0.2s;
                }

                .hero-btn:hover {
                    transform: translateY(-2px);
                    box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
                }

                .hero-image {
                    position: relative;
                }

                .hero-image img {
                    width: 450px;
                    height: 300px;
                    object-fit: cover;
                    border-radius: 20px;
                    box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
                }

                .hero-shapes {
                    position: absolute;
                    top: 0;
                    left: 0;
                    right: 0;
                    bottom: 0;
                    pointer-events: none;
                }

                .hero-shapes::before {
                    content: '';
                    position: absolute;
                    width: 300px;
                    height: 300px;
                    background: rgba(255, 255, 255, 0.1);
                    border-radius: 50%;
                    top: -100px;
                    right: 10%;
                }

                .hero-shapes::after {
                    content: '';
                    position: absolute;
                    width: 200px;
                    height: 200px;
                    background: rgba(255, 255, 255, 0.08);
                    border-radius: 50%;
                    bottom: -50px;
                    left: 5%;
                }

                /* CATEGORIES SECTION */
                .categories-section {
                    background: white;
                    padding: 40px 0;
                    overflow: hidden;
                }

                .section-container {
                    max-width: 1200px;
                    margin: 0 auto;
                    padding: 0 40px;
                }

                .categories-wrapper {
                    overflow: hidden;
                }

                .section-header {
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                    margin-bottom: 24px;
                }

                .section-title {
                    font-size: 24px;
                    font-weight: 700;
                    color: #1c1c1c;
                }

                .see-all {
                    color: #fc8019;
                    font-size: 14px;
                    font-weight: 600;
                    text-decoration: none;
                    display: flex;
                    align-items: center;
                    gap: 4px;
                }

                .categories-scroll {
                    display: flex;
                    gap: 40px;
                    padding: 10px 0;
                    width: max-content;
                    animation: scrollCategories 20s linear infinite;
                }

                .categories-scroll:hover {
                    animation-play-state: paused;
                }

                @keyframes scrollCategories {
                    0% {
                        transform: translateX(0);
                    }

                    100% {
                        transform: translateX(-50%);
                    }
                }

                .category-item {
                    display: flex;
                    flex-direction: column;
                    align-items: center;
                    gap: 12px;
                    cursor: pointer;
                    transition: transform 0.2s;
                    flex-shrink: 0;
                }

                .category-item:hover {
                    transform: scale(1.05);
                }

                .category-icon {
                    width: 100px;
                    height: 100px;
                    border-radius: 50%;
                    overflow: hidden;
                    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
                    background: #f0f0f0;
                }

                .category-icon img {
                    width: 100%;
                    height: 100%;
                    object-fit: cover;
                    display: block;
                }

                .category-name {
                    font-size: 14px;
                    font-weight: 500;
                    color: #3d4152;
                    text-align: center;
                }

                /* RESTAURANTS SECTION - SWIGGY CIRCULAR STYLE */
                .restaurants-section {
                    padding: 40px 0;
                    background: #fff;
                }

                .restaurants-scroll {
                    display: flex;
                    gap: 24px;
                    overflow-x: auto;
                    padding: 20px 0;
                    scrollbar-width: none;
                    -ms-overflow-style: none;
                }

                .restaurants-scroll::-webkit-scrollbar {
                    display: none;
                }

                .restaurant-circle {
                    display: flex;
                    flex-direction: column;
                    align-items: center;
                    gap: 12px;
                    cursor: pointer;
                    transition: transform 0.3s ease;
                    flex-shrink: 0;
                    text-decoration: none;
                }

                .restaurant-circle:hover {
                    transform: scale(1.08);
                }

                .circle-image-wrapper {
                    position: relative;
                    width: 140px;
                    height: 140px;
                }

                .circle-image {
                    width: 140px;
                    height: 140px;
                    border-radius: 50%;
                    overflow: hidden;
                    border: 4px solid #fff;
                    box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
                    position: relative;
                }

                .circle-image img {
                    width: 100%;
                    height: 100%;
                    object-fit: cover;
                    transition: transform 0.4s ease;
                }

                .restaurant-circle:hover .circle-image img {
                    transform: scale(1.15);
                }

                .circle-offer {
                    position: absolute;
                    bottom: -8px;
                    left: 50%;
                    transform: translateX(-50%);
                    background: linear-gradient(135deg, #ff6b35, #fc8019);
                    color: white;
                    padding: 4px 12px;
                    border-radius: 20px;
                    font-size: 10px;
                    font-weight: 700;
                    white-space: nowrap;
                    box-shadow: 0 3px 10px rgba(252, 128, 25, 0.4);
                    text-transform: uppercase;
                    letter-spacing: 0.5px;
                }

                .circle-rating {
                    position: absolute;
                    top: 8px;
                    right: 8px;
                    background: #48c479;
                    color: white;
                    padding: 3px 8px;
                    border-radius: 12px;
                    font-size: 11px;
                    font-weight: 700;
                    display: flex;
                    align-items: center;
                    gap: 3px;
                    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.2);
                }

                .restaurant-details {
                    text-align: center;
                    max-width: 140px;
                }

                .restaurant-title {
                    font-size: 14px;
                    font-weight: 600;
                    color: #1c1c1c;
                    margin-bottom: 2px;
                    white-space: nowrap;
                    overflow: hidden;
                    text-overflow: ellipsis;
                }

                .restaurant-cuisine {
                    font-size: 12px;
                    color: #686b78;
                    margin-bottom: 4px;
                }

                .restaurant-meta {
                    font-size: 11px;
                    color: #93959f;
                }

                /* RESTAURANT CARDS GRID FOR ALL RESTAURANTS */
                .restaurants-grid {
                    display: grid;
                    grid-template-columns: repeat(4, 1fr);
                    gap: 32px;
                }

                .restaurant-card {
                    background: white;
                    border-radius: 20px;
                    overflow: hidden;
                    cursor: pointer;
                    transition: all 0.3s ease;
                    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.04);
                }

                .restaurant-card:hover {
                    transform: scale(1.02);
                    box-shadow: 0 8px 24px rgba(0, 0, 0, 0.12);
                }

                .card-image {
                    position: relative;
                    width: 100%;
                    height: 180px;
                    overflow: hidden;
                }

                .card-image img {
                    width: 100%;
                    height: 100%;
                    object-fit: cover;
                    transition: transform 0.4s ease;
                }

                .restaurant-card:hover .card-image img {
                    transform: scale(1.1);
                }

                .offer-badge {
                    position: absolute;
                    bottom: 0;
                    left: 0;
                    right: 0;
                    background: linear-gradient(transparent, rgba(27, 30, 36, 0.85));
                    padding: 30px 12px 12px;
                }

                .offer-text {
                    color: white;
                    font-size: 18px;
                    font-weight: 700;
                    text-transform: uppercase;
                    letter-spacing: 0.5px;
                }

                .offer-subtext {
                    color: white;
                    font-size: 12px;
                    font-weight: 400;
                }

                .card-info {
                    padding: 16px;
                }

                .restaurant-name {
                    font-size: 18px;
                    font-weight: 600;
                    color: #1c1c1c;
                    margin-bottom: 4px;
                    white-space: nowrap;
                    overflow: hidden;
                    text-overflow: ellipsis;
                }

                .cuisine-tags {
                    font-size: 13px;
                    color: #686b78;
                    margin-bottom: 8px;
                    white-space: nowrap;
                    overflow: hidden;
                    text-overflow: ellipsis;
                }

                .card-meta {
                    display: flex;
                    align-items: center;
                    gap: 12px;
                }

                .rating {
                    display: flex;
                    align-items: center;
                    gap: 4px;
                    background: #48c479;
                    color: white;
                    padding: 4px 6px;
                    border-radius: 6px;
                    font-size: 12px;
                    font-weight: 700;
                }

                .rating-star {
                    font-size: 10px;
                }

                .delivery-time {
                    font-size: 13px;
                    color: #3d4152;
                    font-weight: 500;
                }

                .price-range {
                    font-size: 13px;
                    color: #686b78;
                }

                /* FOOD ITEMS SECTION */
                .food-section {
                    background: white;
                    padding: 40px 0;
                }

                .food-grid {
                    display: grid;
                    grid-template-columns: repeat(4, 1fr);
                    gap: 24px;
                }

                .food-card {
                    background: #fafafa;
                    border-radius: 16px;
                    overflow: hidden;
                    transition: all 0.3s ease;
                    display: flex;
                    flex-direction: column;
                    min-height: 340px;
                }

                .food-card:hover {
                    transform: translateY(-4px);
                    box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
                }

                .food-image {
                    position: relative;
                    width: 100%;
                    height: 160px;
                    overflow: hidden;
                }

                .food-image img {
                    width: 100%;
                    height: 100%;
                    object-fit: cover;
                }

                .veg-badge {
                    position: absolute;
                    top: 10px;
                    left: 10px;
                    width: 20px;
                    height: 20px;
                    background: white;
                    border-radius: 4px;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    font-size: 16px;
                    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
                }

                .veg-badge.veg {
                    color: #0f8a3e;
                }

                .veg-badge.non-veg {
                    color: #e43b4f;
                }

                .food-info {
                    padding: 16px;
                    flex: 1;
                    display: flex;
                    flex-direction: column;
                }

                .food-name {
                    font-size: 16px;
                    font-weight: 600;
                    color: #1c1c1c;
                    margin-bottom: 4px;
                }

                .food-desc {
                    font-size: 13px;
                    color: #93959f;
                    margin-bottom: 12px;
                    display: -webkit-box;
                    -webkit-line-clamp: 2;
                    line-clamp: 2;
                    -webkit-box-orient: vertical;
                    overflow: hidden;
                }

                .food-bottom {
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                    margin-top: auto;
                }

                .food-price {
                    font-size: 16px;
                    font-weight: 600;
                    color: #1c1c1c;
                }

                .add-btn {
                    background: white;
                    color: #60b246;
                    border: 1px solid #60b246;
                    padding: 8px 24px;
                    border-radius: 8px;
                    font-size: 14px;
                    font-weight: 700;
                    cursor: pointer;
                    transition: all 0.2s;
                    text-transform: uppercase;
                }

                .add-btn:hover {
                    background: #60b246;
                    color: white;
                }

                .qty-selector {
                    display: none;
                    align-items: center;
                    gap: 12px;
                    background: #60b246;
                    padding: 4px 8px;
                    border-radius: 8px;
                }

                .qty-btn {
                    width: 28px;
                    height: 28px;
                    background: transparent;
                    border: none;
                    color: white;
                    font-size: 18px;
                    cursor: pointer;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                }

                .qty-value {
                    color: white;
                    font-weight: 600;
                    font-size: 14px;
                    min-width: 20px;
                    text-align: center;
                }

                /* FOOTER */
                .footer {
                    background: #1c1c1c;
                    color: white;
                    padding: 60px 40px 30px;
                }

                .footer-content {
                    max-width: 1200px;
                    margin: 0 auto;
                }

                .footer-top {
                    display: grid;
                    grid-template-columns: repeat(4, 1fr);
                    gap: 40px;
                    padding-bottom: 40px;
                    border-bottom: 1px solid #333;
                }

                .footer-logo {
                    font-size: 32px;
                    font-weight: 800;
                    color: #fc8019;
                    margin-bottom: 16px;
                }

                .footer-desc {
                    color: #93959f;
                    font-size: 14px;
                    line-height: 1.6;
                }

                .footer-heading {
                    font-size: 16px;
                    font-weight: 600;
                    margin-bottom: 20px;
                    color: white;
                }

                .footer-links {
                    list-style: none;
                }

                .footer-links li {
                    margin-bottom: 12px;
                }

                .footer-links a {
                    color: #93959f;
                    text-decoration: none;
                    font-size: 14px;
                    transition: color 0.2s;
                }

                .footer-links a:hover {
                    color: #fc8019;
                }

                .footer-bottom {
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                    padding-top: 30px;
                }

                .copyright {
                    color: #93959f;
                    font-size: 13px;
                }

                .social-links {
                    display: flex;
                    gap: 16px;
                }

                .social-link {
                    width: 36px;
                    height: 36px;
                    background: #333;
                    border-radius: 50%;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    color: white;
                    text-decoration: none;
                    transition: background 0.2s;
                }

                .social-link:hover {
                    background: #fc8019;
                }

                /* RESPONSIVE */
                @media (max-width: 1200px) {

                    .restaurants-grid,
                    .food-grid {
                        grid-template-columns: repeat(3, 1fr);
                    }
                }

                @media (max-width: 992px) {

                    .restaurants-grid,
                    .food-grid {
                        grid-template-columns: repeat(2, 1fr);
                    }

                    .hero-content {
                        flex-direction: column;
                        text-align: center;
                        gap: 40px;
                    }

                    .hero-text {
                        max-width: 100%;
                    }

                    .footer-top {
                        grid-template-columns: repeat(2, 1fr);
                    }
                }

                @media (max-width: 768px) {
                    .navbar {
                        padding: 0 20px;
                        height: 60px;
                    }

                    .nav-right {
                        gap: 20px;
                    }

                    .search-bar {
                        display: none;
                    }

                    .location-text {
                        display: none;
                    }

                    .hero {
                        padding: 40px 20px;
                    }

                    .hero-text h1 {
                        font-size: 32px;
                    }

                    .hero-image img {
                        width: 100%;
                        max-width: 350px;
                    }

                    .section-container {
                        padding: 0 20px;
                    }

                    .restaurants-grid,
                    .food-grid {
                        grid-template-columns: 1fr;
                        gap: 20px;
                    }

                    .footer-top {
                        grid-template-columns: 1fr;
                    }
                }
            </style>
        </head>

        <body>

            <!-- NAVBAR -->
            <nav class="navbar">
                <div class="nav-left">
                    <a href="home" class="logo">FoodLoop</a>
                </div>
                <div class="nav-right">
                    <div class="search-container">
                        <form action="search" method="get" class="search-bar" id="searchForm" autocomplete="off">
                            <span class="search-icon">🔍</span>
                            <input type="text" id="searchInput" name="q"
                                placeholder="Search for restaurants, cuisines, or dishes..." autocomplete="off">
                            <button type="button" class="search-clear" onclick="clearSearch()">✕</button>
                        </form>
                        <div class="search-suggestions" id="searchSuggestions">
                            <!-- Suggestions will be populated via JavaScript -->
                        </div>
                    </div>
                    <a href="#offers-section" class="nav-item" onclick="scrollToOffers()">
                        <span class="nav-icon">🎁</span>
                        Offers
                    </a>
                    <a href="history" class="nav-item">
                        <span class="nav-icon">📋</span>
                        Orders
                    </a>
                    <a href="#" class="nav-item" onclick="showHelp()">
                        <span class="nav-icon">💬</span>
                        Help
                    </a>
                    <a href="login" class="nav-item">
                        <span class="nav-icon">👤</span>
                        Sign In
                    </a>
                    <a href="cart" class="nav-item cart-badge">
                        <span class="nav-icon">🛒</span>
                        Cart
                        <span class="cart-count">${sessionScope.cart != null ? sessionScope.cart.items.size() :
                            0}</span>
                    </a>
                </div>
            </nav>

            <!-- HERO SECTION -->
            <section class="hero">
                <div class="hero-shapes"></div>
                <div class="hero-content">
                    <div class="hero-text">
                        <h1>Hungry? We've got you covered</h1>
                        <p>Order delicious food from top restaurants in Andhra Pradesh. Fast delivery, great taste!</p>
                        <button class="hero-btn"
                            onclick="document.querySelector('.restaurants-section').scrollIntoView({behavior:'smooth'})">Order
                            Now</button>
                    </div>
                    <div class="hero-image">
                        <img src="${pageContext.request.contextPath}/images/food/hero_food.jpg"
                            alt="Delicious Food">
                    </div>
                </div>
            </section>

            <!-- CATEGORIES SECTION -->
            <section class="categories-section">
                <div class="section-container">
                    <div class="section-header">
                        <h2 class="section-title">What's on your mind?</h2>
                        <a href="#" class="see-all">See all →</a>
                    </div>
                    <div class="categories-scroll">
                        <div class="category-item">
                            <div class="category-icon">
                                <img src="${pageContext.request.contextPath}/images/food/biryani.jpg" alt="Biryani">
                            </div>
                            <span class="category-name">Biryani</span>
                        </div>
                        <div class="category-item">
                            <div class="category-icon">
                                <img src="${pageContext.request.contextPath}/images/food/dosa.jpg" alt="Dosa">
                            </div>
                            <span class="category-name">Dosa</span>
                        </div>
                        <div class="category-item">
                            <div class="category-icon">
                                <img src="${pageContext.request.contextPath}/images/food/punugulu.jpg"
                                    alt="Punugulu">
                            </div>
                            <span class="category-name">Punugulu</span>
                        </div>
                        <div class="category-item">
                            <div class="category-icon">
                                <img src="${pageContext.request.contextPath}/images/food/traditional%20meal.jpg"
                                    alt="Thali">
                            </div>
                            <span class="category-name">Thali</span>
                        </div>
                        <div class="category-item">
                            <div class="category-icon">
                                <img src="${pageContext.request.contextPath}/images/food/chicken.jpg" alt="Chicken">
                            </div>
                            <span class="category-name">Chicken</span>
                        </div>
                        <div class="category-item">
                            <div class="category-icon">
                                <img src="${pageContext.request.contextPath}/images/food/prawns.jpg" alt="Seafood">
                            </div>
                            <span class="category-name">Seafood</span>
                        </div>
                        <div class="category-item">
                            <div class="category-icon">
                                <img src="${pageContext.request.contextPath}/images/food/bobbtallu.jpg"
                                    alt="Bobbatlu">
                            </div>
                            <span class="category-name">Bobbatlu</span>
                        </div>
                        <div class="category-item">
                            <div class="category-icon">
                                <img src="${pageContext.request.contextPath}/images/food/mirchibajji.jpg"
                                    alt="Mirchi Bajji">
                            </div>
                            <span class="category-name">Mirchi Bajji</span>
                        </div>
                        <div class="category-item">
                            <div class="category-icon">
                                <img src="${pageContext.request.contextPath}/images/food/pulihora.jpg"
                                    alt="Pulihora">
                            </div>
                            <span class="category-name">Pulihora</span>
                        </div>
                        <div class="category-item">
                            <div class="category-icon">
                                <img src="${pageContext.request.contextPath}/images/food/vada.jpg" alt="Vada">
                            </div>
                            <span class="category-name">Vada</span>
                        </div>
                        <!-- DUPLICATE FOR SEAMLESS LOOP -->
                        <div class="category-item">
                            <div class="category-icon">
                                <img src="${pageContext.request.contextPath}/images/food/biryani.jpg" alt="Biryani">
                            </div>
                            <span class="category-name">Biryani</span>
                        </div>
                        <div class="category-item">
                            <div class="category-icon">
                                <img src="${pageContext.request.contextPath}/images/food/dosa.jpg" alt="Dosa">
                            </div>
                            <span class="category-name">Dosa</span>
                        </div>
                        <div class="category-item">
                            <div class="category-icon">
                                <img src="${pageContext.request.contextPath}/images/food/punugulu.jpg"
                                    alt="Punugulu">
                            </div>
                            <span class="category-name">Punugulu</span>
                        </div>
                        <div class="category-item">
                            <div class="category-icon">
                                <img src="${pageContext.request.contextPath}/images/food/traditional%20meal.jpg"
                                    alt="Thali">
                            </div>
                            <span class="category-name">Thali</span>
                        </div>
                        <div class="category-item">
                            <div class="category-icon">
                                <img src="${pageContext.request.contextPath}/images/food/chicken.jpg" alt="Chicken">
                            </div>
                            <span class="category-name">Chicken</span>
                        </div>
                        <div class="category-item">
                            <div class="category-icon">
                                <img src="${pageContext.request.contextPath}/images/food/prawns.jpg" alt="Seafood">
                            </div>
                            <span class="category-name">Seafood</span>
                        </div>
                        <div class="category-item">
                            <div class="category-icon">
                                <img src="${pageContext.request.contextPath}/images/food/bobbtallu.jpg"
                                    alt="Bobbatlu">
                            </div>
                            <span class="category-name">Bobbatlu</span>
                        </div>
                        <div class="category-item">
                            <div class="category-icon">
                                <img src="${pageContext.request.contextPath}/images/food/mirchibajji.jpg"
                                    alt="Mirchi Bajji">
                            </div>
                            <span class="category-name">Mirchi Bajji</span>
                        </div>
                        <div class="category-item">
                            <div class="category-icon">
                                <img src="${pageContext.request.contextPath}/images/food/pulihora.jpg"
                                    alt="Pulihora">
                            </div>
                            <span class="category-name">Pulihora</span>
                        </div>
                        <div class="category-item">
                            <div class="category-icon">
                                <img src="${pageContext.request.contextPath}/images/food/vada.jpg" alt="Vada">
                            </div>
                            <span class="category-name">Vada</span>
                        </div>
                    </div>
                </div>
            </section>

            <!-- TOP RESTAURANTS SECTION - SWIGGY CIRCULAR STYLE -->
            <section class="restaurants-section">
                <div class="section-container">
                    <div class="section-header">
                        <h2 class="section-title">Top restaurants near you</h2>
                        <a href="#" class="see-all">See all →</a>
                    </div>
                    <div class="restaurants-scroll">
                        <!-- All 10 Restaurants in Circular Format -->
                        <a href="menu?restaurantId=1" class="restaurant-circle">
                            <div class="circle-image-wrapper">
                                <div class="circle-image">
                                    <img src="${pageContext.request.contextPath}/images/restaurant/vijayawada.jpg"
                                        alt="Vijayawada Tiffin Center">
                                </div>
                                <span class="circle-rating">★ 4.2</span>
                                <span class="circle-offer">50% OFF</span>
                            </div>
                            <div class="restaurant-details">
                                <div class="restaurant-title">Vijayawada Tiffin</div>
                                <div class="restaurant-cuisine">South Indian</div>
                                <div class="restaurant-meta">25 mins • ₹200</div>
                            </div>
                        </a>

                        <a href="menu?restaurantId=2" class="restaurant-circle">
                            <div class="circle-image-wrapper">
                                <div class="circle-image">
                                    <img src="${pageContext.request.contextPath}/images/restaurant/guntur_spice.jpg"
                                        alt="Guntur Spice Kitchen">
                                </div>
                                <span class="circle-rating">★ 4.5</span>
                                <span class="circle-offer">40% OFF</span>
                            </div>
                            <div class="restaurant-details">
                                <div class="restaurant-title">Guntur Spice</div>
                                <div class="restaurant-cuisine">Andhra Spicy</div>
                                <div class="restaurant-meta">30 mins • ₹250</div>
                            </div>
                        </a>

                        <a href="menu?restaurantId=3" class="restaurant-circle">
                            <div class="circle-image-wrapper">
                                <div class="circle-image">
                                    <img src="${pageContext.request.contextPath}/images/restaurant/tirupati.jpg"
                                        alt="Tirupati Balaji Meals">
                                </div>
                                <span class="circle-rating">★ 4.4</span>
                                <span class="circle-offer">FREE DEL</span>
                            </div>
                            <div class="restaurant-details">
                                <div class="restaurant-title">Tirupati Balaji</div>
                                <div class="restaurant-cuisine">Pure Veg</div>
                                <div class="restaurant-meta">20 mins • ₹180</div>
                            </div>
                        </a>

                        <a href="menu?restaurantId=4" class="restaurant-circle">
                            <div class="circle-image-wrapper">
                                <div class="circle-image">
                                    <img src="${pageContext.request.contextPath}/images/restaurant/vizag.jpg"
                                        alt="Visakhapatnam Beach Restaurant">
                                </div>
                                <span class="circle-rating">★ 4.6</span>
                                <span class="circle-offer">60% OFF</span>
                            </div>
                            <div class="restaurant-details">
                                <div class="restaurant-title">Vizag Beach</div>
                                <div class="restaurant-cuisine">Seafood</div>
                                <div class="restaurant-meta">35 mins • ₹350</div>
                            </div>
                        </a>

                        <a href="menu?restaurantId=5" class="restaurant-circle">
                            <div class="circle-image-wrapper">
                                <div class="circle-image">
                                    <img src="${pageContext.request.contextPath}/images/restaurant/anatapur.jpg"
                                        alt="Anantapur Biryani House">
                                </div>
                                <span class="circle-rating">★ 4.3</span>
                                <span class="circle-offer">30% OFF</span>
                            </div>
                            <div class="restaurant-details">
                                <div class="restaurant-title">Anantapur Biryani</div>
                                <div class="restaurant-cuisine">Biryani</div>
                                <div class="restaurant-meta">40 mins • ₹280</div>
                            </div>
                        </a>

                        <a href="menu?restaurantId=6" class="restaurant-circle">
                            <div class="circle-image-wrapper">
                                <div class="circle-image">
                                    <img src="${pageContext.request.contextPath}/images/restaurant/kurnool.jpg"
                                        alt="Kurnool Rayalaseema Kitchen">
                                </div>
                                <span class="circle-rating">★ 4.1</span>
                                <span class="circle-offer">25% OFF</span>
                            </div>
                            <div class="restaurant-details">
                                <div class="restaurant-title">Kurnool Kitchen</div>
                                <div class="restaurant-cuisine">Rayalaseema</div>
                                <div class="restaurant-meta">45 mins • ₹220</div>
                            </div>
                        </a>

                        <a href="menu?restaurantId=7" class="restaurant-circle">
                            <div class="circle-image-wrapper">
                                <div class="circle-image">
                                    <img src="${pageContext.request.contextPath}/images/restaurant/nellore.jpg"
                                        alt="Nellore Coastal Delights">
                                </div>
                                <span class="circle-rating">★ 4.7</span>
                                <span class="circle-offer">NEW</span>
                            </div>
                            <div class="restaurant-details">
                                <div class="restaurant-title">Nellore Coastal</div>
                                <div class="restaurant-cuisine">Coastal</div>
                                <div class="restaurant-meta">30 mins • ₹300</div>
                            </div>
                        </a>

                        <a href="menu?restaurantId=8" class="restaurant-circle">
                            <div class="circle-image-wrapper">
                                <div class="circle-image">
                                    <img src="${pageContext.request.contextPath}/images/restaurant/kakinada.jpg"
                                        alt="Kakinada Coastal Kitchen">
                                </div>
                                <span class="circle-rating">★ 4.4</span>
                                <span class="circle-offer">35% OFF</span>
                            </div>
                            <div class="restaurant-details">
                                <div class="restaurant-title">Kakinada Kitchen</div>
                                <div class="restaurant-cuisine">East Godavari</div>
                                <div class="restaurant-meta">35 mins • ₹260</div>
                            </div>
                        </a>

                        <a href="menu?restaurantId=9" class="restaurant-circle">
                            <div class="circle-image-wrapper">
                                <div class="circle-image">
                                    <img src="${pageContext.request.contextPath}/images/restaurant/rajahmundry.jpg"
                                        alt="Rajahmundry Godavari Taste">
                                </div>
                                <span class="circle-rating">★ 4.5</span>
                                <span class="circle-offer">45% OFF</span>
                            </div>
                            <div class="restaurant-details">
                                <div class="restaurant-title">Rajahmundry</div>
                                <div class="restaurant-cuisine">Godavari</div>
                                <div class="restaurant-meta">40 mins • ₹240</div>
                            </div>
                        </a>

                        <a href="menu?restaurantId=10" class="restaurant-circle">
                            <div class="circle-image-wrapper">
                                <div class="circle-image">
                                    <img src="${pageContext.request.contextPath}/images/restaurant/kadapa.jpg"
                                        alt="Kadapa Ruchulu">
                                </div>
                                <span class="circle-rating">★ 4.2</span>
                                <span class="circle-offer">20% OFF</span>
                            </div>
                            <div class="restaurant-details">
                                <div class="restaurant-title">Kadapa Ruchulu</div>
                                <div class="restaurant-cuisine">Rayalaseema</div>
                                <div class="restaurant-meta">50 mins • ₹200</div>
                            </div>
                        </a>
                    </div>
                </div>
            </section>

            <!-- POPULAR FOOD ITEMS SECTION -->
            <section class="food-section">
                <div class="section-container">
                    <div class="section-header">
                        <h2 class="section-title">Popular Dishes</h2>
                        <a href="#" class="see-all">See all →</a>
                    </div>
                    <div class="food-grid">
                        <c:forEach var="menu" items="${popularMenus}">
                            <div class="food-card">
                                <div class="food-image">
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
                                <div class="food-info">
                                    <div class="food-name">${menu.itemName}</div>
                                    <div class="food-desc"
                                        style="white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">
                                        ${menu.description}</div>

                                    <div class="food-bottom"
                                        style="flex-direction: column; align-items: stretch; gap: 10px;">
                                        <div style="display:flex; justify-content:space-between; align-items:center;">
                                            <span class="food-price">₹${menu.price}</span>
                                            <input type="number" id="qty-home-${menu.menuId}" value="1" min="1" max="10"
                                                style="width:40px; text-align:center; border:1px solid #ddd; border-radius:4px;">
                                        </div>

                                        <div style="display: flex; gap: 5px;">
                                            <form action="quickOrder" method="post" style="flex:1;">
                                                <input type="hidden" name="menuId" value="${menu.menuId}">
                                                <input type="hidden" name="quantity"
                                                    class="qty-hidden-home-${menu.menuId}" value="1">
                                                <button type="submit" class="add-btn"
                                                    style="width:100%; font-size:12px;"
                                                    onclick="this.form.querySelector('.qty-hidden-home-${menu.menuId}').value = document.getElementById('qty-home-${menu.menuId}').value;">
                                                    ADD
                                                </button>
                                            </form>
                                            <form action="quickOrder" method="post" style="flex:1;">
                                                <input type="hidden" name="menuId" value="${menu.menuId}">
                                                <input type="hidden" name="quantity"
                                                    class="qty-hidden-buy-${menu.menuId}" value="1">
                                                <button type="submit" class="add-btn"
                                                    style="width:100%; background: linear-gradient(135deg, #28a745, #20c997); font-size:12px;"
                                                    onclick="this.form.querySelector('.qty-hidden-buy-${menu.menuId}').value = document.getElementById('qty-home-${menu.menuId}').value;">
                                                    BUY
                                                </button>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </section>

            <!-- FOOTER -->
            <footer class="footer">
                <div class="footer-content">
                    <div class="footer-top">
                        <div>
                            <div class="footer-logo">FoodLoop</div>
                            <p class="footer-desc">Delivering authentic Andhra Pradesh cuisine to your doorstep.
                                Experience the taste of tradition with every order.</p>
                        </div>
                        <div>
                            <h4 class="footer-heading">Company</h4>
                            <ul class="footer-links">
                                <li><a href="#">About Us</a></li>
                                <li><a href="#">Team</a></li>
                                <li><a href="#">Careers</a></li>
                                <li><a href="#">Blog</a></li>
                            </ul>
                        </div>
                        <div>
                            <h4 class="footer-heading">Contact</h4>
                            <ul class="footer-links">
                                <li><a href="#">Help & Support</a></li>
                                <li><a href="#">Partner with us</a></li>
                                <li><a href="#">Ride with us</a></li>
                            </ul>
                        </div>
                        <div>
                            <h4 class="footer-heading">Legal</h4>
                            <ul class="footer-links">
                                <li><a href="#">Terms & Conditions</a></li>
                                <li><a href="#">Privacy Policy</a></li>
                                <li><a href="#">Cookie Policy</a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="footer-bottom">
                        <span class="copyright">© 2026 FoodLoop. All rights reserved.</span>
                        <div class="social-links">
                            <a href="#" class="social-link">📘</a>
                            <a href="#" class="social-link">📸</a>
                            <a href="#" class="social-link">🐦</a>
                        </div>
                    </div>
                    <div
                        style="text-align: center; padding-top: 20px; border-top: 1px solid #3d4152; margin-top: 20px;">
                        <p style="color: #93959f; font-size: 14px; margin: 0 0 8px 0;">Created by <span
                                style="color: #fc8019; font-weight: 600;">G.Sathya Reddy</span></p>
                        <a href="https://www.linkedin.com/in/sathish-reddy-b035b2378" target="_blank"
                            style="color: #0a66c2; text-decoration: none; font-size: 13px; display: inline-flex; align-items: center; gap: 6px;">
                            <span
                                style="background: #0a66c2; color: white; padding: 4px 8px; border-radius: 4px; font-weight: 500;">in</span>
                            Contact on LinkedIn
                        </a>
                    </div>
                </div>
            </footer>

            <!-- HELP MODAL -->
            <div id="helpModal"
                style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.6); z-index: 9999; justify-content: center; align-items: center;">
                <div
                    style="background: white; border-radius: 16px; max-width: 500px; width: 90%; max-height: 80vh; overflow-y: auto; box-shadow: 0 20px 60px rgba(0,0,0,0.3);">
                    <div
                        style="background: linear-gradient(135deg, #fc8019, #ff6b35); padding: 24px; border-radius: 16px 16px 0 0;">
                        <div style="display: flex; justify-content: space-between; align-items: center;">
                            <h2 style="color: white; margin: 0;">💬 Help & Support</h2>
                            <button onclick="closeHelp()"
                                style="background: rgba(255,255,255,0.2); border: none; color: white; width: 32px; height: 32px; border-radius: 50%; cursor: pointer; font-size: 18px;">✕</button>
                        </div>
                    </div>
                    <div style="padding: 24px;">
                        <div style="margin-bottom: 20px;">
                            <h4 style="color: #333; margin: 0 0 10px;">📞 Contact Us</h4>
                            <p style="color: #666; margin: 0; font-size: 14px;">Email: support@foodloop.com</p>
                            <p style="color: #666; margin: 5px 0 0; font-size: 14px;">Phone: +91 9876543210</p>
                        </div>
                        <div style="margin-bottom: 20px;">
                            <h4 style="color: #333; margin: 0 0 10px;">❓ FAQs</h4>
                            <details
                                style="margin-bottom: 10px; border: 1px solid #eee; border-radius: 8px; padding: 12px;">
                                <summary style="cursor: pointer; font-weight: 500; color: #333;">How do I place an
                                    order?</summary>
                                <p style="color: #666; font-size: 13px; margin: 10px 0 0;">Browse restaurants, select
                                    items, add to cart, and proceed to checkout. Choose your payment method and confirm!
                                </p>
                            </details>
                            <details
                                style="margin-bottom: 10px; border: 1px solid #eee; border-radius: 8px; padding: 12px;">
                                <summary style="cursor: pointer; font-weight: 500; color: #333;">What payment methods
                                    are accepted?</summary>
                                <p style="color: #666; font-size: 13px; margin: 10px 0 0;">We accept Razorpay (Cards,
                                    UPI, Wallets), PhonePe UPI, and Google Pay UPI.</p>
                            </details>
                            <details
                                style="margin-bottom: 10px; border: 1px solid #eee; border-radius: 8px; padding: 12px;">
                                <summary style="cursor: pointer; font-weight: 500; color: #333;">How can I track my
                                    order?</summary>
                                <p style="color: #666; font-size: 13px; margin: 10px 0 0;">Go to Orders in the
                                    navigation menu to view your order history and status.</p>
                            </details>
                            <details
                                style="margin-bottom: 10px; border: 1px solid #eee; border-radius: 8px; padding: 12px;">
                                <summary style="cursor: pointer; font-weight: 500; color: #333;">What is the delivery
                                    time?</summary>
                                <p style="color: #666; font-size: 13px; margin: 10px 0 0;">Delivery typically takes
                                    20-45 minutes depending on the restaurant and your location.</p>
                            </details>
                            <details style="border: 1px solid #eee; border-radius: 8px; padding: 12px;">
                                <summary style="cursor: pointer; font-weight: 500; color: #333;">How do I cancel an
                                    order?</summary>
                                <p style="color: #666; font-size: 13px; margin: 10px 0 0;">Contact our support team
                                    within 5 minutes of placing the order. After that, cancellation may not be possible.
                                </p>
                            </details>
                        </div>
                        <div style="background: #f8f9fa; padding: 15px; border-radius: 10px; text-align: center;">
                            <p style="color: #666; margin: 0 0 10px; font-size: 13px;">Need more help?</p>
                            <a href="mailto:support@foodloop.com"
                                style="background: #fc8019; color: white; padding: 10px 20px; border-radius: 8px; text-decoration: none; font-weight: 500; display: inline-block;">Email
                                Support</a>
                        </div>
                    </div>
                </div>
            </div>

            <script>
                // ===================== PROFESSIONAL SEARCH BAR =====================
                const searchInput = document.getElementById('searchInput');
                const searchForm = document.getElementById('searchForm');
                const searchSuggestions = document.getElementById('searchSuggestions');
                const searchBar = document.querySelector('.search-bar');
                let debounceTimer;
                let selectedIndex = -1;
                let suggestions = [];

                // Recent searches (stored in localStorage)
                function getRecentSearches() {
                    const recent = localStorage.getItem('foodloop_recent_searches');
                    return recent ? JSON.parse(recent) : [];
                }

                function addRecentSearch(query) {
                    let recent = getRecentSearches();
                    recent = recent.filter(s => s.toLowerCase() !== query.toLowerCase());
                    recent.unshift(query);
                    if (recent.length > 5) recent = recent.slice(0, 5);
                    localStorage.setItem('foodloop_recent_searches', JSON.stringify(recent));
                }

                function clearRecentSearches() {
                    localStorage.removeItem('foodloop_recent_searches');
                    showRecentSearches();
                }

                // Show recent searches when input is focused but empty
                function showRecentSearches() {
                    const recent = getRecentSearches();
                    if (recent.length === 0) {
                        searchSuggestions.innerHTML = `
            <div class="no-results">
                <div class="no-icon">🔍</div>
                <p>Start typing to search for restaurants, cuisines, or dishes</p>
            </div>`;
                    } else {
                        let html = '<div class="suggestion-header">Recent Searches</div><div class="recent-searches">';
                        recent.forEach((term, i) => {
                            html += `<div class="recent-item" data-index="${i}" onclick="searchFor('${escapeHtml(term)}')">
                <span class="recent-icon">🕐</span>
                <span style="flex:1">${escapeHtml(term)}</span>
                <span style="color:#ccc">↗</span>
            </div>`;
                        });
                        html += '</div><div class="search-footer"><span>Clear recent searches</span><button onclick="clearRecentSearches()" style="background:#fc8019;color:white;border:none;padding:4px 10px;border-radius:6px;cursor:pointer;font-size:11px">Clear</button></div>';
                        searchSuggestions.innerHTML = html;
                    }
                    searchSuggestions.classList.add('active');
                }

                function escapeHtml(str) {
                    const div = document.createElement('div');
                    div.textContent = str;
                    return div.innerHTML;
                }

                function highlightMatch(text, query) {
                    if (!query) return escapeHtml(text);
                    const escaped = escapeHtml(text);
                    const regex = new RegExp('(' + query.replace(/[.*+?^$\x7B\x7D()|[\]\\]/g, '\\$&') + ')', 'gi');
                    return escaped.replace(regex, '<mark>$1</mark>');
                }

                // Fetch suggestions from API
                async function fetchSuggestions(query) {
                    try {
                        const response = await fetch('searchSuggest?q=' + encodeURIComponent(query));
                        return await response.json();
                    } catch (e) {
                        console.error('Search error:', e);
                        return [];
                    }
                }

                // Render suggestions
                function renderSuggestions(data, query) {
                    suggestions = data;
                    selectedIndex = -1;

                    if (data.length === 0) {
                        searchSuggestions.innerHTML = `
            <div class="no-results">
                <div class="no-icon">😕</div>
                <p>No results found for "<strong>\${escapeHtml(query)}</strong>"</p>
                <p style="font-size:12px;margin-top:8px">Try searching for dishes like biryani, dosa, or chicken</p>
            </div>`;
                        searchSuggestions.classList.add('active');
                        return;
                    }

                    // Separate food items and others
                    const foodItems = data.filter(item => item.type === 'food' && item.image);
                    const otherItems = data.filter(item => item.type !== 'food' || !item.image);

                    let html = '';

                    // Show food items with images in a grid
                    if (foodItems.length > 0) {
                        html += '<div class="suggestion-header">🍽️ Food Items</div>';
                        html += '<div class="food-suggestions-grid">';
                        foodItems.forEach((item, index) => {
                            html += `<div class="food-suggestion-card" data-index="\${index}" data-type="food" data-id="\${item.id}" data-menu-id="\${item.menuId}" data-name="\${escapeHtml(item.name)}">
                <div class="food-card-image" style="background-image: url('\${item.image}')"></div>
                <div class="food-card-info">
                    <div class="food-card-name">\${highlightMatch(item.name, query)}</div>
                    <div class="food-card-restaurant">\${escapeHtml(item.restaurant || '')}</div>
                    <div class="food-card-price">\${item.price}</div>
                </div>
            </div>`;
                        });
                        html += '</div>';
                    }

                    // Show other items (restaurants, cuisines, categories)
                    if (otherItems.length > 0) {
                        html += '<div class="suggestion-header" style="margin-top:10px">🔍 Other Results</div>';
                        otherItems.forEach((item, index) => {
                            const icon = item.type === 'restaurant' ? '🏪' :
                                item.type === 'cuisine' ? '🍳' : '📂';

                            html += `<div class="suggestion-item" data-index="\${foodItems.length + index}" data-type="\${item.type}" data-id="\${item.id}" data-name="\${escapeHtml(item.name)}">
                <div class="suggestion-icon \${item.type}">\${icon}</div>
                <div class="suggestion-text">
                    <div class="suggestion-name">\${highlightMatch(item.name, query)}</div>
                    <div class="suggestion-sub">\${escapeHtml(item.sub)}</div>
                </div>
                <span class="suggestion-arrow">→</span>
            </div>`;
                        });
                    }

                    html += `<div class="search-footer">
        <span><kbd>↑</kbd> <kbd>↓</kbd> to navigate, <kbd>Enter</kbd> to select</span>
        <span>\${data.length} result\${data.length > 1 ? 's' : ''}</span>
    </div>`;

                    searchSuggestions.innerHTML = html;
                    searchSuggestions.classList.add('active');

                    // Add click handlers for food cards
                    document.querySelectorAll('.food-suggestion-card').forEach(item => {
                        item.addEventListener('click', function () {
                            const id = this.dataset.id;
                            const menuId = this.dataset.menuId;
                            const name = this.dataset.name;
                            addRecentSearch(name);
                            searchSuggestions.classList.remove('active');
                            // Go directly to restaurant menu with item highlighted
                            window.location.href = 'menu?restaurantId=' + id + '&highlight=' + menuId;
                        });
                    });

                    // Add click handlers for other items
                    document.querySelectorAll('.suggestion-item').forEach(item => {
                        item.addEventListener('click', function () {
                            const type = this.dataset.type;
                            const id = this.dataset.id;
                            const name = this.dataset.name;
                            handleSuggestionSelect(type, id, name);
                        });
                    });
                }

                function handleSuggestionSelect(type, id, name) {
                    addRecentSearch(name);
                    searchSuggestions.classList.remove('active');

                    if (type === 'restaurant') {
                        window.location.href = 'menu?restaurantId=' + id;
                    } else if (type === 'food') {
                        window.location.href = 'menu?restaurantId=' + id;
                    } else {
                        searchInput.value = name;
                        searchForm.submit();
                    }
                }

                function searchFor(term) {
                    searchInput.value = term;
                    addRecentSearch(term);
                    searchForm.submit();
                }

                function clearSearch() {
                    searchInput.value = '';
                    searchBar.classList.remove('has-text');
                    searchInput.focus();
                    showRecentSearches();
                }

                // Input event handlers
                searchInput.addEventListener('input', function () {
                    const query = this.value.trim();

                    // Toggle clear button
                    if (query.length > 0) {
                        searchBar.classList.add('has-text');
                    } else {
                        searchBar.classList.remove('has-text');
                    }

                    // Debounce API calls
                    clearTimeout(debounceTimer);

                    if (query.length < 2) {
                        if (query.length === 0) {
                            showRecentSearches();
                        } else {
                            searchSuggestions.classList.remove('active');
                        }
                        return;
                    }

                    debounceTimer = setTimeout(async () => {
                        const data = await fetchSuggestions(query);
                        renderSuggestions(data, query);
                    }, 200);
                });

                searchInput.addEventListener('focus', function () {
                    if (this.value.trim().length < 2) {
                        showRecentSearches();
                    } else {
                        searchSuggestions.classList.add('active');
                    }
                });

                // Keyboard navigation
                searchInput.addEventListener('keydown', function (e) {
                    const items = document.querySelectorAll('.suggestion-item');

                    if (e.key === 'ArrowDown') {
                        e.preventDefault();
                        selectedIndex = Math.min(selectedIndex + 1, items.length - 1);
                        updateSelection(items);
                    } else if (e.key === 'ArrowUp') {
                        e.preventDefault();
                        selectedIndex = Math.max(selectedIndex - 1, -1);
                        updateSelection(items);
                    } else if (e.key === 'Enter' && selectedIndex >= 0 && items[selectedIndex]) {
                        e.preventDefault();
                        items[selectedIndex].click();
                    } else if (e.key === 'Escape') {
                        searchSuggestions.classList.remove('active');
                        searchInput.blur();
                    }
                });

                function updateSelection(items) {
                    items.forEach((item, i) => {
                        item.classList.toggle('active', i === selectedIndex);
                        if (i === selectedIndex) {
                            item.scrollIntoView({ block: 'nearest' });
                        }
                    });
                }

                // Close suggestions when clicking outside
                document.addEventListener('click', function (e) {
                    if (!e.target.closest('.search-container')) {
                        searchSuggestions.classList.remove('active');
                    }
                });

                // Form submission
                searchForm.addEventListener('submit', function (e) {
                    const query = searchInput.value.trim();
                    if (query.length < 2) {
                        e.preventDefault();
                        searchInput.focus();
                        return;
                    }
                    addRecentSearch(query);
                });

                // ===================== OTHER FUNCTIONS =====================

                // Scroll to offers
                function scrollToOffers() {
                    document.querySelector('.food-section').scrollIntoView({ behavior: 'smooth' });
                }

                // Help modal
                function showHelp() {
                    document.getElementById('helpModal').style.display = 'flex';
                    document.body.style.overflow = 'hidden';
                }

                function closeHelp() {
                    document.getElementById('helpModal').style.display = 'none';
                    document.body.style.overflow = 'auto';
                }

                // Close modal on outside click
                document.getElementById('helpModal').addEventListener('click', function (e) {
                    if (e.target === this) closeHelp();
                });

                // Add button animation
                document.querySelectorAll('.add-btn').forEach(btn => {
                    btn.addEventListener('click', function (e) {
                        e.stopPropagation();
                        this.textContent = '✓ Added';
                        this.style.background = '#60b246';
                        this.style.color = 'white';
                        setTimeout(() => {
                            this.textContent = 'ADD';
                            this.style.background = 'white';
                            this.style.color = '#60b246';
                        }, 1500);
                    });
                });
            </script>

        </body>

        </html>

