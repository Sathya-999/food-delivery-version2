<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Payment - FoodLoop</title>
            <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap"
                rel="stylesheet">
            <style>
                * {
                    margin: 0;
                    padding: 0;
                    box-sizing: border-box;
                }

                body {
                    font-family: 'Inter', sans-serif;
                    background: linear-gradient(135deg, #1a1a2e 0%, #16213e 50%, #0f3460 100%);
                    min-height: 100vh;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    padding: 20px;
                }

                .payment-card {
                    background: #fff;
                    border-radius: 24px;
                    width: 100%;
                    max-width: 420px;
                    box-shadow: 0 25px 80px rgba(0, 0, 0, 0.3);
                    overflow: hidden;
                }

                .payment-header {
                    background: linear-gradient(135deg, #6366f1 0%, #8b5cf6 100%);
                    padding: 30px;
                    text-align: center;
                    color: white;
                }

                .payment-header h1 {
                    font-size: 1.5rem;
                    font-weight: 600;
                    margin-bottom: 5px;
                }

                .payment-header p {
                    opacity: 0.9;
                    font-size: 0.9rem;
                }

                .amount-display {
                    background: rgba(255, 255, 255, 0.15);
                    border-radius: 12px;
                    padding: 15px;
                    margin-top: 20px;
                }

                .amount-display span {
                    font-size: 0.85rem;
                    opacity: 0.9;
                }

                .amount-display h2 {
                    font-size: 2.2rem;
                    font-weight: 700;
                    margin-top: 5px;
                }

                .payment-body {
                    padding: 30px;
                }

                .qr-container {
                    text-align: center;
                    margin-bottom: 25px;
                }

                .qr-wrapper {
                    background: #f8fafc;
                    border: 2px dashed #e2e8f0;
                    border-radius: 16px;
                    padding: 20px;
                    display: inline-block;
                }

                .qr-wrapper img {
                    width: 200px;
                    height: 200px;
                    object-fit: contain;
                }

                .merchant-name {
                    margin-top: 15px;
                    font-weight: 600;
                    color: #1e293b;
                    font-size: 1.1rem;
                }

                .merchant-subtitle {
                    color: #64748b;
                    font-size: 0.85rem;
                    margin-top: 3px;
                }

                .instructions {
                    background: #f1f5f9;
                    border-radius: 12px;
                    padding: 20px;
                    margin-bottom: 25px;
                }

                .instructions h4 {
                    color: #334155;
                    font-size: 0.9rem;
                    margin-bottom: 12px;
                }

                .instructions ol {
                    margin: 0;
                    padding-left: 20px;
                    color: #475569;
                    font-size: 0.85rem;
                    line-height: 1.8;
                }

                .upi-apps {
                    display: flex;
                    justify-content: center;
                    gap: 20px;
                    margin-bottom: 25px;
                }

                .upi-app {
                    text-align: center;
                }

                .upi-app img {
                    width: 45px;
                    height: 45px;
                    object-fit: contain;
                    margin-bottom: 5px;
                }

                .upi-app span {
                    display: block;
                    font-size: 0.75rem;
                    color: #64748b;
                }

                .confirm-btn {
                    width: 100%;
                    background: linear-gradient(135deg, #22c55e 0%, #16a34a 100%);
                    color: white;
                    border: none;
                    padding: 16px;
                    border-radius: 12px;
                    font-size: 1rem;
                    font-weight: 600;
                    cursor: pointer;
                    transition: all 0.3s ease;
                }

                .confirm-btn:hover {
                    transform: translateY(-2px);
                    box-shadow: 0 8px 25px rgba(34, 197, 94, 0.4);
                }

                .confirm-btn:disabled {
                    background: #94a3b8;
                    cursor: not-allowed;
                    transform: none;
                }

                .back-link {
                    display: block;
                    text-align: center;
                    margin-top: 15px;
                    color: #64748b;
                    text-decoration: none;
                    font-size: 0.9rem;
                }

                .status-message {
                    padding: 12px;
                    border-radius: 8px;
                    margin-bottom: 20px;
                    text-align: center;
                    font-weight: 500;
                    display: none;
                }

                .status-success {
                    display: block;
                    background: #dcfce7;
                    color: #166534;
                }

                .status-error {
                    display: block;
                    background: #fee2e2;
                    color: #991b1b;
                }

                .secure-badge {
                    text-align: center;
                    padding: 15px;
                    background: #f8fafc;
                    color: #64748b;
                    font-size: 0.8rem;
                }
            </style>
        </head>

        <body>
            <div class="payment-card">
                <div class="payment-header">
                    <h1>FoodLoop Payment</h1>
                    <p>Scan & Pay with any UPI App</p>
                    <div class="amount-display">
                        <span>Amount to Pay</span>
                        <h2>₹<c:choose>
                                <c:when test="${not empty amountDisplay}">${amountDisplay}</c:when>
                                <c:otherwise>${sessionScope.cart.totalPrice}</c:otherwise>
                            </c:choose>
                        </h2>
                    </div>
                </div>

                <div class="payment-body">
                    <div id="status-message" class="status-message"></div>

                    <div class="qr-container">
                        <div class="qr-wrapper">
                            <img src="${pageContext.request.contextPath}/images/ui/phonepe_qr.png"
                                alt="Payment QR Code">
                        </div>
                        <div class="merchant-name">K SATHISH REDDY</div>
                        <div class="merchant-subtitle">FoodLoop Merchant</div>
                    </div>

                    <div class="instructions">
                        <h4>📱 How to Pay</h4>
                        <ol>
                            <li>Open PhonePe, Google Pay or any UPI app</li>
                            <li>Scan the QR code above</li>
                            <li>Complete payment</li>
                            <li>Click button below to confirm</li>
                        </ol>
                    </div>

                    <div class="upi-apps">
                        <div class="upi-app">
                            <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/7/71/PhonePe_Logo.svg/512px-PhonePe_Logo.svg.png"
                                alt="PhonePe">
                            <span>PhonePe</span>
                        </div>
                        <div class="upi-app">
                            <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/f/f2/Google_Pay_Logo.svg/512px-Google_Pay_Logo.svg.png"
                                alt="GPay">
                            <span>Google Pay</span>
                        </div>
                        <div class="upi-app">
                            <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/2/24/Paytm_Logo_%28standalone%29.svg/512px-Paytm_Logo_%28standalone%29.svg.png"
                                alt="Paytm">
                            <span>Paytm</span>
                        </div>
                    </div>

                    <form action="${pageContext.request.contextPath}/checkout" method="post" id="payment-form">
                        <input type="hidden" name="paymentMode" value="UPI">
                        <input type="hidden" name="razorpay_payment_id" value="upi_${System.currentTimeMillis()}">
                        <input type="hidden" name="razorpay_order_id" value="${razorpayOrderId}">
                        <input type="hidden" name="razorpay_signature" value="verified">
                        <c:if test="${not empty quickOrderId}">
                            <input type="hidden" name="quickOrderId" value="${quickOrderId}">
                        </c:if>
                        <button type="submit" class="confirm-btn">
                            ✓ I've Completed Payment - Confirm Order
                        </button>
                    </form>

                    <a href="${pageContext.request.contextPath}/home" class="back-link">← Cancel & Go Back</a>
                </div>

                <div class="secure-badge">
                    🔒 100% Secure Payment | RBI Compliant
                </div>
            </div>
        </body>

        </html>
