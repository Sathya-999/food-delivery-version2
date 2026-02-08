-- Add more restaurants
INSERT INTO restaurant (name, cuisineType, address, ratings, delivery, isActive) VALUES
('Pizza Palace', 'Italian', '123 Main St', 4.5, '00:25:00', 1),
('Burger Kingdom', 'American', '456 Oak Ave', 4.3, '00:20:00', 1),
('Sushi Master', 'Japanese', '789 Pine Rd', 4.7, '00:35:00', 1),
('Curry House', 'Indian', '321 Elm St', 4.6, '00:30:00', 1),
('Taco Fiesta', 'Mexican', '654 Maple Dr', 4.4, '00:22:00', 1),
('Dragon Wok', 'Chinese', '987 Cedar Ln', 4.8, '00:28:00', 1)
ON DUPLICATE KEY UPDATE name=VALUES(name);

-- Add menu items for restaurants
INSERT INTO menu (restaurantId, itemName, category, price, availability, spiceLevel) VALUES
-- Restaurant 1 items
(1, 'Margherita Pizza', 'Pizza', 12.99, 1, 'Mild'),
(1, 'Pepperoni Pizza', 'Pizza', 14.99, 1, 'Mild'),
(1, 'Garlic Bread', 'Appetizer', 4.99, 1, 'Mild'),
(1, 'Caesar Salad', 'Salad', 7.99, 1, 'Mild'),
-- Restaurant 2 items
(2, 'Classic Burger', 'Burger', 9.99, 1, 'Mild'),
(2, 'Cheese Burger', 'Burger', 11.99, 1, 'Mild'),
(2, 'French Fries', 'Side', 3.99, 1, 'Mild'),
(2, 'Onion Rings', 'Side', 4.99, 1, 'Mild'),
(2, 'Milkshake', 'Beverage', 5.99, 1, 'None'),
-- Restaurant 3 items
(3, 'California Roll', 'Sushi', 8.99, 1, 'Mild'),
(3, 'Spicy Tuna Roll', 'Sushi', 10.99, 1, 'Medium'),
(3, 'Salmon Nigiri', 'Sushi', 12.99, 1, 'None'),
(3, 'Tempura Shrimp', 'Appetizer', 9.99, 1, 'Mild'),
(3, 'Miso Soup', 'Soup', 3.99, 1, 'None'),
-- Restaurant 4 items
(4, 'Chicken Tikka Masala', 'Curry', 13.99, 1, 'Medium'),
(4, 'Butter Chicken', 'Curry', 14.99, 1, 'Mild'),
(4, 'Vegetable Biryani', 'Rice', 11.99, 1, 'Medium'),
(4, 'Garlic Naan', 'Bread', 2.99, 1, 'Mild'),
(4, 'Samosas', 'Appetizer', 5.99, 1, 'Medium'),
-- Restaurant 5 items (Pizza Palace)
(5, 'Beef Tacos', 'Tacos', 8.99, 1, 'Medium'),
(5, 'Chicken Burrito', 'Burrito', 10.99, 1, 'Mild'),
(5, 'Quesadilla', 'Main', 9.99, 1, 'Mild'),
(5, 'Guacamole Chips', 'Appetizer', 6.99, 1, 'Mild'),
(5, 'Churros', 'Dessert', 5.99, 1, 'None'),
-- Restaurant 6 items (Burger Kingdom)
(6, 'Kung Pao Chicken', 'Chinese', 12.99, 1, 'Hot'),
(6, 'Sweet Sour Pork', 'Chinese', 13.99, 1, 'Mild'),
(6, 'Vegetable Fried Rice', 'Rice', 8.99, 1, 'Mild'),
(6, 'Spring Rolls', 'Appetizer', 5.99, 1, 'Mild'),
(6, 'Wonton Soup', 'Soup', 6.99, 1, 'Mild'),
-- Restaurant 7 items (Sushi Master)
(7, 'BBQ Ribs', 'BBQ', 18.99, 1, 'Medium'),
(7, 'Grilled Chicken', 'Grilled', 15.99, 1, 'Mild'),
(7, 'Pulled Pork Sandwich', 'Sandwich', 11.99, 1, 'Mild'),
(7, 'Coleslaw', 'Side', 3.99, 1, 'None'),
-- Restaurant 8 items (Curry House)
(8, 'Spaghetti Carbonara', 'Pasta', 13.99, 1, 'Mild'),
(8, 'Fettuccine Alfredo', 'Pasta', 12.99, 1, 'Mild'),
(8, 'Lasagna', 'Pasta', 14.99, 1, 'Mild'),
(8, 'Tiramisu', 'Dessert', 7.99, 1, 'None')
ON DUPLICATE KEY UPDATE itemName=VALUES(itemName);

-- Add more test users
INSERT INTO user (username, email, pwd, mobile) VALUES
('testuser1', 'test1@email.com', 'pass123', 1234567890),
('testuser2', 'test2@email.com', 'pass123', 2345678901),
('testuser3', 'test3@email.com', 'pass123', 3456789012),
('johnsmith', 'john@email.com', 'pass123', 4567890123),
('sarahchen', 'sarah@email.com', 'pass123', 5678901234)
ON DUPLICATE KEY UPDATE email=VALUES(email);

-- Verify data
SELECT 'Database populated successfully!' as Status;
SELECT CONCAT('Total Restaurants: ', COUNT(*)) as Result FROM restaurant;
SELECT CONCAT('Total Menu Items: ', COUNT(*)) as Result FROM menu;
SELECT CONCAT('Total Users: ', COUNT(*)) as Result FROM user;
