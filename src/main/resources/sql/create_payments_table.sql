-- Create payments table for FoodLoop
-- This table stores all payment transactions

CREATE TABLE IF NOT EXISTS payments (
    paymentId VARCHAR(100) PRIMARY KEY,
    userId INT NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    status ENUM(
        'Pending',
        'Success',
        'Failed',
        'Refunded'
    ) DEFAULT 'Pending',
    provider VARCHAR(50) DEFAULT 'UPI_QR',
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    order_id INT,
    FOREIGN KEY (userId) REFERENCES users (user_id),
    FOREIGN KEY (order_id) REFERENCES orders (order_id)
);

-- Add indexes for faster lookups
CREATE INDEX idx_payment_user ON payments (userId);

CREATE INDEX idx_payment_status ON payments (status);

CREATE INDEX idx_payment_order ON payments (order_id);

-- Sample query to check if payment exists:
-- SELECT paymentId, amount FROM payments WHERE userId = ? AND status = 'Success' ORDER BY timestamp DESC LIMIT 1;