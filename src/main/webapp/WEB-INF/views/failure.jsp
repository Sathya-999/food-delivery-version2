<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login Failed</title>
</head>
<body>

<h2 style="color:red;">Login Failed</h2>

<p>Invalid email or password.</p>

<a href="<%= request.getContextPath() %>/login">Try Again</a>

</body>
</html>

