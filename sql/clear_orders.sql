-- Clear all existing orders from the database
-- Run this to start fresh - only new orders will appear

-- First delete order items (child table)
DELETE FROM orderitems;

-- Then delete orders (parent table)
DELETE FROM orders;

-- Also clear payments if exists
DELETE FROM payments;

-- Optionally reset auto-increment
ALTER TABLE orders AUTO_INCREMENT = 1;
ALTER TABLE orderitems AUTO_INCREMENT = 1;

-- Verify tables are empty
SELECT 'Orders cleared successfully!' AS Status;
SELECT COUNT(*) AS RemainingOrders FROM orders;
