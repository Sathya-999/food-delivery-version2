<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="pageTitle" value="Scan & Pay" scope="request" />
<%@ include file="header.jsp" %>

<div class="container" style="max-width: 800px; margin: 40px auto; background: #fff; padding: 30px; border-radius: 8px; box-shadow: 0 4px 15px rgba(0,0,0,0.1);">
    
    <div class="row">
        <div class="col-md-6" style="border-right: 1px solid #eee;">
            <h2 style="color: #2c3e50;">Scan to Pay</h2>
            <p style="color: #7f8c8d;">Scan the Merchant QR Code to initiate secure payment transaction.</p>
            
            <div id="reader" width="100%" style="border-radius: 8px; overflow: hidden; margin-top: 20px;"></div>
            <div id="scan-status" style="margin-top: 15px; font-weight: bold; color: #555;">Waiting for camera...</div>
        </div>
        
        <div class="col-md-6" style="padding-left: 30px;">
            <h3 style="margin-bottom: 20px;">Transaction Details</h3>
            
            <div id="transaction-step-1" class="step" style="opacity: 0.5;">
                <h4>1. Validation</h4>
                <p id="validation-msg">Waiting for scan...</p>
            </div>

            <div id="transaction-step-2" class="step" style="opacity: 0.5;">
                <h4>2. Payment Processing</h4>
                <p id="payment-msg">Pending validation</p>
            </div>

            <div id="transaction-step-3" class="step" style="opacity: 0.5;">
                <h4>3. Data Transfer & Order</h4>
                <p id="transfer-msg">Pending payment</p>
            </div>
            
            <form action="checkout" method="post" id="hidden-checkout-form" style="display:none;">
                <input type="hidden" name="paymentMode" value="Razorpay">
                <input type="hidden" name="razorpay_payment_id" id="form_payment_id">
                <input type="hidden" name="razorpay_order_id" id="form_order_id">
                <input type="hidden" name="razorpay_signature" id="form_signature">
            </form>
        </div>
    </div>
</div>

<!-- Scripts -->
<script src="https://unpkg.com/html5-qrcode" type="text/javascript"></script>
<script src="https://checkout.razorpay.com/v1/checkout.js"></script>
<script>
    // --- Configuration ---
    const MOCK_MODE = true; // Set to match your backend config
    const RAZORPAY_KEY = "${razorpayKeyId}"; 
    const ORDER_ID = "${razorpayOrderId}";
    const AMOUNT = "${amount}";
    
    // --- Step 1: Scanner Logic ---
    function onScanSuccess(decodedText, decodedResult) {
        // Stop scanning after success
        html5QrcodeScanner.clear();
        document.getElementById('scan-status').innerText = "✅ QR Code Scanned: " + decodedText; // Removed decodedResult
        
        // Trigger Flow
        validateAndPay(decodedText);
    }

    function onScanFailure(error) {
        // console.warn(`Code scan error = ${error}`);
    }

    let html5QrcodeScanner = new Html5QrcodeScanner(
        "reader",
        { fps: 10, qrbox: {width: 250, height: 250} },
        /* verbose= */ false);
    html5QrcodeScanner.render(onScanSuccess, onScanFailure);

    // --- Step 2: Orchestration Flow ---
    async function validateAndPay(qrData) {
        updateStep(1, "Validating QR Data via Secure Backend...", "active");
        
        try {
            const response = await fetch('validate_qr', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({ qrData: qrData })
            });
            
            const result = await response.json();
            
            if(result.status === 'success') {
                 updateStep(1, "✅ " + result.message, "done");
                 initiateRazorpay();
            } else {
                 updateStep(1, "❌ " + result.message, "error");
                 // Allow retry logic if needed, for now we stop
                 setTimeout(() => { 
                     // optional: restart scanner 
                 }, 3000);
            }
        } catch (error) {
            console.error(error);
             updateStep(1, "❌ Network/Server Error", "error");
        }
    }

    function initiateRazorpay() {
        updateStep(2, "Initializing Payment Gateway...", "active");

        if(MOCK_MODE) {
            // Simulate Razorpay Popup & Success
            setTimeout(() => {
                const mockResponse = {
                    razorpay_payment_id: "pay_mock_qr_" + new Date().getTime(),
                    razorpay_order_id: ORDER_ID,
                    razorpay_signature: "mock_sig_qr"
                };
                handlePaymentSuccess(mockResponse);
            }, 1500);
        } else {
            // Real Razorpay (Needs valid keys)
            var options = {
                "key": RAZORPAY_KEY,
                "amount": AMOUNT,
                "name": "FoodLoop QR",
                "order_id": ORDER_ID,
                "handler": function (response){
                    handlePaymentSuccess(response);
                }
            };
            var rzp1 = new Razorpay(options);
            rzp1.open();
        }
    }

    async function handlePaymentSuccess(response) {
        updateStep(2, "✅ Payment Captured: " + response.razorpay_payment_id, "done");
        updateStep(3, "Transferring Logic & Placing Order...", "active");

        // --- Step 3: Secure Transfer & Order ---
        // Here we hit the backend. The Backend should:
        // 1. Log to 'TransactionDB'
        // 2. If success, Move to 'OrderDB'
        
        document.getElementById('form_payment_id').value = response.razorpay_payment_id;
        document.getElementById('form_order_id').value = response.razorpay_order_id;
        document.getElementById('form_signature').value = response.razorpay_signature;

        setTimeout(() => {
             document.getElementById('hidden-checkout-form').submit();
        }, 1000);
    }

    function updateStep(stepNum, msg, status) {
        const el = document.getElementById('transaction-step-' + stepNum);
        const txt = el.querySelector('p');
        txt.innerText = msg;
        
        if(status === 'active') {
            el.style.opacity = '1';
            el.style.borderLeft = '4px solid #3498db';
            el.style.paddingLeft = '10px';
        } else if (status === 'done') {
            el.style.opacity = '1';
            el.style.borderLeft = '4px solid #2ecc71';
            el.style.color = '#27ae60';
             el.style.paddingLeft = '10px';
        } else if (status === 'error') {
            el.style.opacity = '1';
            el.style.borderLeft = '4px solid #e74c3c';
            el.style.color = '#c0392b';
             el.style.paddingLeft = '10px';
        }
    }
</script>

<%@ include file="footer.jsp" %>

