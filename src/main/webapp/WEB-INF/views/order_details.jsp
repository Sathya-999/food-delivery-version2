<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order #${order.orderId} - FoodLoop</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Poppins', sans-serif; background: #f5f5f5; color: #3d4152; min-height: 100vh; }
        
        .navbar {
            background: #fff;
            padding: 16px 40px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
            position: sticky;
            top: 0;
            z-index: 100;
        }
        .logo { font-size: 24px; font-weight: 700; color: #fc8019; text-decoration: none; }
        .nav-links { display: flex; gap: 24px; align-items: center; }
        .nav-links a { color: #3d4152; text-decoration: none; font-weight: 500; display: flex; align-items: center; gap: 6px; }
        .nav-links a:hover { color: #fc8019; }
        
        .container { max-width: 800px; margin: 0 auto; padding: 30px 20px; }
        
        .back-link {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            color: #686b78;
            text-decoration: none;
            font-size: 14px;
            margin-bottom: 20px;
        }
        .back-link:hover { color: #fc8019; }
        
        .order-card {
            background: white;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 4px 20px rgba(0,0,0,0.08);
        }
        
        .order-header {
            background: linear-gradient(135deg, #fc8019, #ff6b35);
            padding: 30px;
            color: white;
            text-align: center;
        }
        .order-header h1 { font-size: 32px; margin-bottom: 8px; }
        .order-header .order-id { font-size: 18px; opacity: 0.9; }
        
        .status-section {
            padding: 24px 30px;
            background: #fafafa;
            border-bottom: 1px solid #eee;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 16px;
        }
        
        .status-badge {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 12px 24px;
            border-radius: 30px;
            font-size: 16px;
            font-weight: 600;
        }
        .status-confirmed { background: #e8f5e9; color: #2e7d32; }
        .status-pending { background: #fff3e0; color: #ef6c00; }
        .status-delivered { background: #e3f2fd; color: #1565c0; }
        .status-cancelled { background: #ffebee; color: #c62828; }
        
        .order-body { padding: 30px; }
        
        .info-section {
            margin-bottom: 30px;
        }
        .info-section h3 {
            font-size: 14px;
            color: #93959f;
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 16px;
            padding-bottom: 10px;
            border-bottom: 2px solid #f2f2f2;
        }
        
        .info-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
        }
        .info-item {
            padding: 16px;
            background: #fafafa;
            border-radius: 12px;
        }
        .info-item label {
            display: block;
            font-size: 12px;
            color: #93959f;
            margin-bottom: 6px;
        }
        .info-item span {
            font-size: 16px;
            font-weight: 600;
            color: #1c1c1c;
        }
        
        .total-section {
            background: linear-gradient(135deg, #1a1a2e, #16213e);
            padding: 24px;
            border-radius: 16px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 20px;
        }
        .total-label {
            color: #aaa;
            font-size: 14px;
        }
        .total-amount {
            color: #fc8019;
            font-size: 32px;
            font-weight: 700;
        }
        
        .action-buttons {
            display: flex;
            gap: 16px;
            margin-top: 24px;
        }
        .btn {
            flex: 1;
            padding: 14px 24px;
            border-radius: 12px;
            font-size: 15px;
            font-weight: 600;
            text-decoration: none;
            text-align: center;
            cursor: pointer;
            transition: all 0.2s;
        }
        .btn-primary {
            background: #fc8019;
            color: white;
            border: none;
        }
        .btn-primary:hover { background: #e67316; transform: translateY(-2px); }
        .btn-outline {
            background: white;
            color: #fc8019;
            border: 2px solid #fc8019;
        }
        .btn-outline:hover { background: #fff5ef; }
        
        .timeline {
            position: relative;
            padding-left: 30px;
        }
        .timeline::before {
            content: '';
            position: absolute;
            left: 8px;
            top: 0;
            bottom: 0;
            width: 2px;
            background: #e8e8e8;
        }
        .timeline-item {
            position: relative;
            padding-bottom: 20px;
        }
        .timeline-item::before {
            content: '';
            position: absolute;
            left: -26px;
            top: 4px;
            width: 14px;
            height: 14px;
            border-radius: 50%;
            background: #fc8019;
            border: 3px solid #fff;
            box-shadow: 0 0 0 2px #fc8019;
        }
        .timeline-item.completed::before { background: #2e7d32; box-shadow: 0 0 0 2px #2e7d32; }
        .timeline-item.pending::before { background: #ef6c00; box-shadow: 0 0 0 2px #ef6c00; }
        .timeline-title { font-weight: 600; color: #1c1c1c; margin-bottom: 4px; }
        .timeline-time { font-size: 12px; color: #93959f; }
    </style>
</head>
<body>

<nav class="navbar">
    <a href="home" class="logo">FoodLoop</a>
    <div class="nav-links">
        <a href="home">🏠 Home</a>
        <a href="history" style="color: #fc8019;">📋 Orders</a>
        <a href="cart">🛒 Cart</a>
        <a href="logout">👤 Logout</a>
    </div>
</nav>

<div class="container">
    <a href="history" class="back-link">← Back to All Orders</a>
    
    <div class="order-card">
        <div class="order-header">
            <h1>🧾 Order Details</h1>
            <div class="order-id">Order #${order.orderId}</div>
        </div>
        
        <div class="status-section">
            <span class="status-badge 
                <c:choose>
                    <c:when test="${order.status == 'Confirmed'}">status-confirmed</c:when>
                    <c:when test="${order.status == 'Pending'}">status-pending</c:when>
                    <c:when test="${order.status == 'Delivered'}">status-delivered</c:when>
                    <c:otherwise>status-cancelled</c:otherwise>
                </c:choose>">
                <c:choose>
                    <c:when test="${order.status == 'Confirmed'}">✓ Order Confirmed</c:when>
                    <c:when test="${order.status == 'Pending'}">⏳ Order Pending</c:when>
                    <c:when test="${order.status == 'Delivered'}">🚚 Order Delivered</c:when>
                    <c:otherwise>✕ Order Cancelled</c:otherwise>
                </c:choose>
            </span>
        </div>
        
        <div class="order-body">
            <div class="info-section">
                <h3>📅 Order Information</h3>
                <div class="info-grid">
                    <div class="info-item">
                        <label>Order Date</label>
                        <span><fmt:formatDate value="${order.orderDate}" pattern="dd MMM yyyy, hh:mm a"/></span>
                    </div>
                    <div class="info-item">
                        <label>Order ID</label>
                        <span>#${order.orderId}</span>
                    </div>
                </div>
            </div>
            
            <div class="info-section">
                <h3>💳 Payment Details</h3>
                <div class="info-grid">
                    <div class="info-item">
                        <label>Payment Method</label>
                        <span>${order.paymentMode}</span>
                    </div>
                    <div class="info-item">
                        <label>Transaction ID</label>
                        <span>${not empty order.transactionId ? order.transactionId : 'N/A'}</span>
                    </div>
                </div>
            </div>
            
            <div class="info-section">
                <h3>📍 Order Status Timeline</h3>
                <div class="timeline">
                    <div class="timeline-item completed">
                        <div class="timeline-title">Order Placed</div>
                        <div class="timeline-time"><fmt:formatDate value="${order.orderDate}" pattern="dd MMM yyyy, hh:mm a"/></div>
                    </div>
                    <c:if test="${order.status == 'Confirmed' || order.status == 'Delivered'}">
                        <div class="timeline-item completed">
                            <div class="timeline-title">Order Confirmed</div>
                            <div class="timeline-time">Restaurant accepted your order</div>
                        </div>
                    </c:if>
                    <c:if test="${order.status == 'Delivered'}">
                        <div class="timeline-item completed">
                            <div class="timeline-title">Out for Delivery</div>
                            <div class="timeline-time">Your food is on the way</div>
                        </div>
                        <div class="timeline-item completed">
                            <div class="timeline-title">Delivered</div>
                            <div class="timeline-time">Order delivered successfully</div>
                        </div>
                    </c:if>
                    <c:if test="${order.status == 'Pending'}">
                        <div class="timeline-item pending">
                            <div class="timeline-title">Awaiting Confirmation</div>
                            <div class="timeline-time">Waiting for restaurant</div>
                        </div>
                    </c:if>
                </div>
            </div>
            
            <div class="total-section">
                <div>
                    <div class="total-label">Total Amount Paid</div>
                </div>
                <div class="total-amount">₹${order.totalAmount}</div>
            </div>
            
            <div class="action-buttons">
                <a href="menu?restaurantId=${order.restaurantId}" class="btn btn-primary">🔄 Reorder</a>
                <a href="history" class="btn btn-outline">📋 All Orders</a>
            </div>
        </div>
    </div>
</div>

</body>
</html>

