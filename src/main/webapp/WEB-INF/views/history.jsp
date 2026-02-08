<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Order History - FoodLoop</title>
                <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
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
                        min-height: 100vh;
                    }

                    .navbar {
                        background: #fff;
                        padding: 16px 40px;
                        display: flex;
                        align-items: center;
                        justify-content: space-between;
                        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
                        position: sticky;
                        top: 0;
                        z-index: 100;
                    }

                    .logo {
                        font-size: 24px;
                        font-weight: 700;
                        color: #fc8019;
                        text-decoration: none;
                    }

                    .nav-links {
                        display: flex;
                        gap: 24px;
                        align-items: center;
                    }

                    .nav-links a {
                        color: #3d4152;
                        text-decoration: none;
                        font-weight: 500;
                        display: flex;
                        align-items: center;
                        gap: 6px;
                    }

                    .nav-links a:hover {
                        color: #fc8019;
                    }

                    .container {
                        max-width: 900px;
                        margin: 0 auto;
                        padding: 30px 20px;
                    }

                    .page-header {
                        background: linear-gradient(135deg, #fc8019, #ff6b35);
                        padding: 30px;
                        border-radius: 16px;
                        margin-bottom: 24px;
                        color: white;
                    }

                    .page-header h1 {
                        font-size: 28px;
                        margin-bottom: 8px;
                    }

                    .page-header p {
                        opacity: 0.9;
                    }

                    .orders-list {
                        display: flex;
                        flex-direction: column;
                        gap: 16px;
                    }

                    .order-card {
                        background: white;
                        border-radius: 16px;
                        overflow: hidden;
                        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.04);
                        transition: box-shadow 0.2s;
                    }

                    .order-card:hover {
                        box-shadow: 0 4px 16px rgba(0, 0, 0, 0.1);
                    }

                    .order-header {
                        background: #fafafa;
                        padding: 16px 20px;
                        display: flex;
                        justify-content: space-between;
                        align-items: center;
                        border-bottom: 1px solid #eee;
                    }

                    .order-id {
                        font-weight: 600;
                        color: #1c1c1c;
                    }

                    .order-date {
                        color: #686b78;
                        font-size: 13px;
                    }

                    .order-body {
                        padding: 20px;
                    }

                    .order-info {
                        display: grid;
                        grid-template-columns: repeat(3, 1fr);
                        gap: 20px;
                        margin-bottom: 16px;
                    }

                    .info-item label {
                        display: block;
                        font-size: 12px;
                        color: #93959f;
                        margin-bottom: 4px;
                    }

                    .info-item span {
                        font-weight: 600;
                        color: #1c1c1c;
                    }

                    .status-badge {
                        display: inline-flex;
                        align-items: center;
                        gap: 6px;
                        padding: 6px 14px;
                        border-radius: 20px;
                        font-size: 13px;
                        font-weight: 600;
                    }

                    .status-confirmed {
                        background: #e8f5e9;
                        color: #2e7d32;
                    }

                    .status-pending {
                        background: #fff3e0;
                        color: #ef6c00;
                    }

                    .status-delivered {
                        background: #e3f2fd;
                        color: #1565c0;
                    }

                    .status-cancelled {
                        background: #ffebee;
                        color: #c62828;
                    }

                    .order-footer {
                        display: flex;
                        justify-content: space-between;
                        align-items: center;
                        padding-top: 16px;
                        border-top: 1px dashed #eee;
                    }

                    .total-amount {
                        font-size: 20px;
                        font-weight: 700;
                        color: #fc8019;
                    }

                    .reorder-btn {
                        background: #fc8019;
                        color: white;
                        border: none;
                        padding: 10px 20px;
                        border-radius: 8px;
                        font-weight: 500;
                        cursor: pointer;
                        text-decoration: none;
                        font-size: 14px;
                    }

                    .reorder-btn:hover {
                        background: #e67316;
                    }

                    .empty-state {
                        text-align: center;
                        padding: 60px 20px;
                        background: white;
                        border-radius: 16px;
                    }

                    .empty-icon {
                        font-size: 64px;
                        margin-bottom: 16px;
                    }

                    .empty-state h3 {
                        margin-bottom: 8px;
                        color: #1c1c1c;
                    }

                    .empty-state p {
                        color: #686b78;
                        margin-bottom: 20px;
                    }

                    .order-now-btn {
                        background: #fc8019;
                        color: white;
                        padding: 12px 24px;
                        border-radius: 10px;
                        text-decoration: none;
                        font-weight: 500;
                        display: inline-block;
                    }
                </style>
            </head>

            <body>

                <nav class="navbar">
                    <a href="home" class="logo">FoodLoop</a>
                    <div class="nav-links">
                        <a href="home">🏠 Home</a>
                        <a href="history" style="color: #fc8019;">📋 Orders</a>
                        <a href="cart">🛒 Cart</a>
                        <c:choose>
                            <c:when test="${sessionScope.user != null}">
                                <a href="logout">👤 Logout</a>
                            </c:when>
                            <c:otherwise>
                                <a href="login">👤 Sign In</a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </nav>

                <div class="container">
                    <div class="page-header">
                        <h1>📋
                            <c:out value="${sessionScope.user.username}" />'s Orders
                        </h1>
                        <p>Your personal order history - Only your orders are shown here</p>
                    </div>

                    <c:if test="${empty history}">
                        <div class="empty-state">
                            <div class="empty-icon">📭</div>
                            <h3>No orders yet,
                                <c:out value="${sessionScope.user.username}" />!
                            </h3>
                            <p>You haven't placed any orders yet. When you order food, it will appear here.</p>
                            <a href="home" class="order-now-btn">🍕 Start Ordering</a>
                        </div>
                    </c:if>

                    <c:if test="${not empty history}">
                        <div class="orders-list">
                            <c:forEach var="order" items="${history}">
                                <a href="history?orderId=${order.orderId}" class="order-card"
                                    style="text-decoration: none; color: inherit; display: block;">
                                    <div class="order-header">
                                        <span class="order-id">Order #${order.orderId}</span>
                                        <span class="order-date">
                                            <fmt:formatDate value="${order.orderDate}" pattern="dd MMM yyyy, hh:mm a" />
                                        </span>
                                    </div>
                                    <div class="order-body">
                                        <div class="order-info">
                                            <div class="info-item">
                                                <label>Payment Method</label>
                                                <span>${order.paymentMode}</span>
                                            </div>
                                            <div class="info-item">
                                                <label>Transaction ID</label>
                                                <span>${not empty order.transactionId ? order.transactionId :
                                                    'N/A'}</span>
                                            </div>
                                            <div class="info-item">
                                                <label>Status</label>
                                                <span class="status-badge 
                                    <c:choose>
                                        <c:when test=" ${order.status=='Confirmed' }">status-confirmed</c:when>
                                                    <c:when test="${order.status == 'Pending'}">status-pending</c:when>
                                                    <c:when test="${order.status == 'Delivered'}">status-delivered
                                                    </c:when>
                                                    <c:otherwise>status-cancelled</c:otherwise>
                                                    </c:choose>">
                                                    <c:choose>
                                                        <c:when test="${order.status == 'Confirmed'}">✓</c:when>
                                                        <c:when test="${order.status == 'Pending'}">⏳</c:when>
                                                        <c:when test="${order.status == 'Delivered'}">🚚</c:when>
                                                        <c:otherwise>✕</c:otherwise>
                                                    </c:choose>
                                                    ${order.status}
                                                </span>
                                            </div>
                                        </div>
                                        <div class="order-footer">
                                            <div>
                                                <span style="color: #686b78; font-size: 13px;">Total Amount</span>
                                                <div class="total-amount">₹${order.totalAmount}</div>
                                            </div>
                                            <span class="reorder-btn" style="pointer-events: none;">View Details
                                                →</span>
                                        </div>
                                    </div>
                                </a>
                            </c:forEach>
                        </div>
                    </c:if>
                </div>

            </body>

            </html>
