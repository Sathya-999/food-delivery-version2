<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="pageTitle" value="Order Success" scope="request" />
<%@ include file="header.jsp" %>

<div style="text-align:center; padding: 3rem;">
    <h1 style="color:var(--primary-color);">Order Placed Successfully!</h1>
    <p>Thank you for your order. Your delicious food is on the way.</p>
    <br>
    <a href="history" class="btn">View Order History</a>
    <a href="home" class="btn ghost" style="color:#333; border-color:#333; margin-left:10px;">Continue Shopping</a>
</div>

<%@ include file="footer.jsp" %>

