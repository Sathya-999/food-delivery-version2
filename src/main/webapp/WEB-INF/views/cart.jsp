<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="pageTitle" value="Cart" scope="request" />
<%@ include file="header.jsp" %>

<h1>Your Cart</h1>

<c:if test="${empty sessionScope.cart || sessionScope.cart.items.size() == 0}">
    <div class="alert alert-danger">Your cart is empty. <a href="home">Go to Restaurants</a></div>
</c:if>

<c:if test="${not empty sessionScope.cart && sessionScope.cart.items.size() > 0}">
    <table class="cart-table">
        <thead>
            <tr>
                <th>Image</th>
                <th>Item</th>
                <th>Price</th>
                <th>Quantity</th>
                <th>Total</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="entry" items="${sessionScope.cart.items}">
                <tr>
                    <td><img src="${pageContext.request.contextPath}/${not empty entry.value.imagePath ? entry.value.imagePath : 'images/food/traditional meal.jpg'}" alt="${entry.value.name}" style="width:50px; height:50px; object-fit:cover; border-radius:4px;"></td>
                    <td>${entry.value.name}</td>
                    <td>&#8377;${entry.value.price}</td>
                    <td>
                        <form action="cart" method="post" style="display:inline;">
                            <input type="hidden" name="action" value="update">
                            <input type="hidden" name="itemId" value="${entry.key}">
                            <input type="number" name="quantity" value="${entry.value.quantity}" min="1" max="10" class="qty-input" onchange="this.form.submit()">
                        </form>
                    </td>
                    <td>&#8377;${entry.value.total}</td>
                    <td>
                        <form action="cart" method="post">
                            <input type="hidden" name="action" value="remove">
                            <input type="hidden" name="itemId" value="${entry.key}">
                            <button type="submit" class="btn ghost" style="color:red; border:1px solid red; padding:5px 10px;">Remove</button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <div class="cart-summary">
        <h2>Total: &#8377;${sessionScope.cart.totalPrice}</h2>
        <a href="scan_pay" class="btn" style="padding: 15px 40px; font-size: 1.1rem; text-decoration:none; display:inline-block;">Proceed to Pay</a>
    </div>
</c:if>

<%@ include file="footer.jsp" %>

