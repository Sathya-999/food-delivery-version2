<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login - FoodLoop</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #fc8019 0%, #ff6b35 100%);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }
        
        h2 {
            color: white;
            text-align: center;
            margin-bottom: 30px;
            font-size: 28px;
            text-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        
        .container {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.2);
            overflow: hidden;
            width: 100%;
            max-width: 800px;
            min-height: 480px;
            position: relative;
        }
        
        .form-container {
            position: absolute;
            top: 0;
            height: 100%;
            transition: all 0.6s ease-in-out;
            padding: 40px;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
        }
        
        .sign-in-container {
            left: 0;
            width: 50%;
            z-index: 2;
        }
        
        .sign-up-container {
            left: 0;
            width: 50%;
            opacity: 0;
            z-index: 1;
        }
        
        .container.right-panel-active .sign-in-container {
            transform: translateX(100%);
            opacity: 0;
        }
        
        .container.right-panel-active .sign-up-container {
            transform: translateX(100%);
            opacity: 1;
            z-index: 5;
        }
        
        form { width: 100%; text-align: center; }
        
        form h1 {
            font-size: 28px;
            margin-bottom: 20px;
            color: #333;
        }
        
        form span {
            font-size: 13px;
            color: #777;
            margin-bottom: 20px;
            display: block;
        }
        
        form input {
            width: 100%;
            padding: 14px 20px;
            margin: 8px 0;
            border: 1px solid #ddd;
            border-radius: 10px;
            font-size: 14px;
            font-family: inherit;
            transition: border-color 0.3s;
        }
        
        form input:focus {
            outline: none;
            border-color: #fc8019;
        }
        
        form button {
            width: 100%;
            padding: 14px;
            margin-top: 20px;
            background: #fc8019;
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.3s;
        }
        
        form button:hover {
            background: #e67316;
        }
        
        .error-msg {
            color: #e74c3c;
            font-size: 13px;
            margin-bottom: 10px;
        }
        
        .success-msg {
            color: #27ae60;
            font-size: 13px;
            margin-bottom: 10px;
        }
        
        .overlay-container {
            position: absolute;
            top: 0;
            left: 50%;
            width: 50%;
            height: 100%;
            overflow: hidden;
            transition: transform 0.6s ease-in-out;
            z-index: 100;
        }
        
        .container.right-panel-active .overlay-container {
            transform: translateX(-100%);
        }
        
        .overlay {
            background: linear-gradient(135deg, #fc8019 0%, #ff6b35 100%);
            color: white;
            position: relative;
            left: -100%;
            height: 100%;
            width: 200%;
            transition: transform 0.6s ease-in-out;
        }
        
        .container.right-panel-active .overlay {
            transform: translateX(50%);
        }
        
        .overlay-panel {
            position: absolute;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-direction: column;
            padding: 40px;
            text-align: center;
            top: 0;
            height: 100%;
            width: 50%;
            transition: transform 0.6s ease-in-out;
        }
        
        .overlay-panel h1 {
            font-size: 32px;
            margin-bottom: 15px;
        }
        
        .overlay-panel p {
            font-size: 14px;
            margin-bottom: 25px;
            opacity: 0.9;
        }
        
        .overlay-left { transform: translateX(-20%); }
        .container.right-panel-active .overlay-left { transform: translateX(0); }
        
        .overlay-right { right: 0; transform: translateX(0); }
        .container.right-panel-active .overlay-right { transform: translateX(20%); }
        
        .ghost {
            background: transparent;
            border: 2px solid white;
            color: white;
            padding: 12px 40px;
            border-radius: 25px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
        }
        
        .ghost:hover {
            background: white;
            color: #fc8019;
        }
    </style>
</head>
<body>

<h2>Welcome to FoodLoop</h2>

<div class="container" id="container">
    
    <!-- SIGN UP FORM -->
    <div class="form-container sign-up-container">
        <form action="${pageContext.request.contextPath}/signup" method="post">
            <h1>Create Account</h1>
            <c:if test="${not empty error}">
                <p class="error-msg">${error}</p>
            </c:if>
            <input type="text" name="name" placeholder="Full Name" required>
            <input type="email" name="email" placeholder="Email" required>
            <input type="number" name="mobile" placeholder="Mobile Number" required>
            <input type="password" name="password" placeholder="Password" required>
            <input type="password" name="confirmPassword" placeholder="Confirm Password" required>
            <button type="submit">Sign Up</button>
        </form>
    </div>
    
    <!-- SIGN IN FORM -->
    <div class="form-container sign-in-container">
        <form action="${pageContext.request.contextPath}/login" method="post">
            <h1>Sign In</h1>
            <span>Use your email and password</span>
            <c:if test="${not empty loginError}">
                <p class="error-msg">${loginError}</p>
            </c:if>
            <c:if test="${not empty success}">
                <p class="success-msg">${success}</p>
            </c:if>
            <input type="email" name="email" placeholder="Email" required>
            <input type="password" name="pwd" placeholder="Password" required>
            <button type="submit">Sign In</button>
        </form>
    </div>
    
    <!-- OVERLAY -->
    <div class="overlay-container">
        <div class="overlay">
            <div class="overlay-panel overlay-left">
                <h1>Welcome Back!</h1>
                <p>Already have an account? Sign in to continue your food journey</p>
                <button class="ghost" id="signIn">Sign In</button>
            </div>
            <div class="overlay-panel overlay-right">
                <h1>Hello, Friend!</h1>
                <p>New here? Create an account and start ordering delicious food</p>
                <button class="ghost" id="signUp">Sign Up</button>
            </div>
        </div>
    </div>
</div>

<script>
const signUpButton = document.getElementById('signUp');
const signInButton = document.getElementById('signIn');
const container = document.getElementById('container');

signUpButton.addEventListener('click', () => {
    container.classList.add('right-panel-active');
});

signInButton.addEventListener('click', () => {
    container.classList.remove('right-panel-active');
});

// If there's an error from signup, show signup panel
<c:if test="${not empty error || not empty showSignup}">
container.classList.add('right-panel-active');
</c:if>
</script>

</body>
</html>

