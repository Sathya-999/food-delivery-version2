-- Add more restaurants
INSERT INTO restaurant (restaurantName, cuisineType, deliveryTime, address, adminUserId, rating, isActive, imagePath) VALUES
('Pizza Palace', 'Italian', 25, '123 Main St, City Center', 1, 4.5, 1, 'pizzapalace.jpg'),
('Burger Kingdom', 'American', 20, '456 Oak Ave, Downtown', 1, 4.3, 1, 'burgerkingdom.jpg'),
('Sushi Master', 'Japanese', 35, '789 Pine Rd, East Side', 1, 4.7, 1, 'sushimaster.jpg'),
('Curry House', 'Indian', 30, '321 Elm St, West End', 1, 4.6, 1, 'curryhouse.jpg'),
('Taco Fiesta', 'Mexican', 22, '654 Maple Dr, South', 1, 4.4, 1, 'tacofiesta.jpg'),
('Dragon Wok', 'Chinese', 28, '987 Cedar Ln, North', 1, 4.8, 1, 'dragonwok.jpg'),
('Pasta Paradise', 'Italian', 26, '159 Birch St, Center', 1, 4.5, 1, 'pastaparadise.jpg'),
('Grill Masters', 'BBQ', 32, '753 Ash Ave, East', 1, 4.6, 1, 'grillmasters.jpg')
ON DUPLICATE KEY UPDATE restaurantName=VALUES(restaurantName);

-- Add menu items for each restaurant
INSERT INTO menu (restaurantId, itemName, description, price, isAvailable, category, imagePath, rating) VALUES
-- Pizza Palace (restaurantId 1 or 5)
(5, 'Margherita Pizza', 'Classic tomato, mozzarella, basil', 12.99, 1, 'Main Course', 'margherita.jpg', 4.5),
(5, 'Pepperoni Pizza', 'Pepperoni, cheese, tomato sauce', 14.99, 1, 'Main Course', 'pepperoni.jpg', 4.7),
(5, 'Veggie Supreme', 'Mixed vegetables, cheese', 13.99, 1, 'Main Course', 'veggie.jpg', 4.3),
(5, 'Garlic Bread', 'Toasted bread with garlic butter', 4.99, 1, 'Appetizer', 'garlicbread.jpg', 4.6),
(5, 'Caesar Salad', 'Fresh romaine, parmesan, croutons', 7.99, 1, 'Salad', 'caesar.jpg', 4.4),

-- Burger Kingdom (restaurantId 6)
(6, 'Classic Burger', 'Beef patty, lettuce, tomato, cheese', 9.99, 1, 'Main Course', 'classicburger.jpg', 4.5),
(6, 'Cheese Burger', 'Double cheese, beef patty', 11.99, 1, 'Main Course', 'cheeseburger.jpg', 4.6),
(6, 'Veggie Burger', 'Plant-based patty, veggies', 10.99, 1, 'Main Course', 'veggieburger.jpg', 4.2),
(6, 'French Fries', 'Crispy golden fries', 3.99, 1, 'Side', 'fries.jpg', 4.7),
(6, 'Onion Rings', 'Crispy battered onion rings', 4.99, 1, 'Side', 'onionrings.jpg', 4.5),
(6, 'Milkshake', 'Chocolate, vanilla, or strawberry', 5.99, 1, 'Beverage', 'milkshake.jpg', 4.8),

-- Sushi Master (restaurantId 7)
(7, 'California Roll', 'Crab, avocado, cucumber', 8.99, 1, 'Sushi Roll', 'california.jpg', 4.7),
(7, 'Spicy Tuna Roll', 'Tuna, spicy mayo, cucumber', 10.99, 1, 'Sushi Roll', 'spicytuna.jpg', 4.8),
(7, 'Salmon Nigiri', 'Fresh salmon on rice (6 pcs)', 12.99, 1, 'Nigiri', 'salmon.jpg', 4.9),
(7, 'Tempura Shrimp', 'Battered fried shrimp (5 pcs)', 9.99, 1, 'Appetizer', 'tempura.jpg', 4.6),
(7, 'Miso Soup', 'Traditional Japanese soup', 3.99, 1, 'Soup', 'miso.jpg', 4.5),

-- Curry House (restaurantId 8)
(8, 'Chicken Tikka Masala', 'Creamy tomato curry with chicken', 13.99, 1, 'Main Course', 'tikka.jpg', 4.8),
(8, 'Butter Chicken', 'Rich buttery tomato curry', 14.99, 1, 'Main Course', 'butterchicken.jpg', 4.9),
(8, 'Vegetable Biryani', 'Spiced rice with vegetables', 11.99, 1, 'Main Course', 'biryani.jpg', 4.6),
(8, 'Garlic Naan', 'Soft flatbread with garlic', 2.99, 1, 'Bread', 'naan.jpg', 4.7),
(8, 'Samosas', 'Crispy pastry with spiced filling (3 pcs)', 5.99, 1, 'Appetizer', 'samosa.jpg', 4.5),

-- Taco Fiesta (restaurantId 9)
(9, 'Beef Tacos', 'Seasoned beef, lettuce, cheese (3 pcs)', 8.99, 1, 'Main Course', 'beeftaco.jpg', 4.4),
(9, 'Chicken Burrito', 'Grilled chicken, rice, beans, wrapped', 10.99, 1, 'Main Course', 'burrito.jpg', 4.6),
(9, 'Quesadilla', 'Cheese, chicken, grilled tortilla', 9.99, 1, 'Main Course', 'quesadilla.jpg', 4.5),
(9, 'Guacamole & Chips', 'Fresh guacamole with tortilla chips', 6.99, 1, 'Appetizer', 'guac.jpg', 4.7),
(9, 'Churros', 'Sweet fried pastry with chocolate', 5.99, 1, 'Dessert', 'churros.jpg', 4.8),

-- Dragon Wok (restaurantId 10)
(10, 'Kung Pao Chicken', 'Spicy chicken with peanuts', 12.99, 1, 'Main Course', 'kungpao.jpg', 4.7),
(10, 'Sweet & Sour Pork', 'Crispy pork in sweet sauce', 13.99, 1, 'Main Course', 'sweetsour.jpg', 4.6),
(10, 'Vegetable Fried Rice', 'Stir-fried rice with vegetables', 8.99, 1, 'Main Course', 'friedrice.jpg', 4.5),
(10, 'Spring Rolls', 'Crispy vegetable rolls (4 pcs)', 5.99, 1, 'Appetizer', 'springrolls.jpg', 4.6),
(10, 'Wonton Soup', 'Dumplings in clear broth', 6.99, 1, 'Soup', 'wonton.jpg', 4.7),

-- Pasta Paradise (restaurantId 11)
(11, 'Spaghetti Carbonara', 'Creamy pasta with bacon', 13.99, 1, 'Main Course', 'carbonara.jpg', 4.8),
(11, 'Fettuccine Alfredo', 'Creamy white sauce pasta', 12.99, 1, 'Main Course', 'alfredo.jpg', 4.7),
(11, 'Lasagna', 'Layered pasta with meat sauce', 14.99, 1, 'Main Course', 'lasagna.jpg', 4.9),
(11, 'Bruschetta', 'Toasted bread with tomatoes', 6.99, 1, 'Appetizer', 'bruschetta.jpg', 4.5),
(11, 'Tiramisu', 'Classic Italian dessert', 7.99, 1, 'Dessert', 'tiramisu.jpg', 4.8),

-- Grill Masters (restaurantId 12)
(12, 'BBQ Ribs', 'Slow-cooked ribs with BBQ sauce', 18.99, 1, 'Main Course', 'ribs.jpg', 4.9),
(12, 'Grilled Chicken', 'Half chicken grilled with spices', 15.99, 1, 'Main Course', 'grilledchicken.jpg', 4.7),
(12, 'Pulled Pork Sandwich', 'Slow-cooked pork in bun', 11.99, 1, 'Main Course', 'pulledpork.jpg', 4.6),
(12, 'Coleslaw', 'Creamy cabbage salad', 3.99, 1, 'Side', 'coleslaw.jpg', 4.4),
(12, 'Cornbread', 'Sweet cornbread (2 pcs)', 4.99, 1, 'Side', 'cornbread.jpg', 4.5);

-- Add more test users
INSERT INTO user (username, email, password, phoneNumber, address, role) VALUES
('testuser1', 'test1@email.com', 'password123', '1234567890', '123 Test St', 'customer'),
('testuser2', 'test2@email.com', 'password123', '2345678901', '456 Test Ave', 'customer'),
('testuser3', 'test3@email.com', 'password123', '3456789012', '789 Test Rd', 'customer'),
('johnsmith', 'john@email.com', 'password123', '4567890123', '321 Main St', 'customer'),
('sarahchen', 'sarah@email.com', 'password123', '5678901234', '654 Oak Ave', 'customer'),
('mikeross', 'mike@email.com', 'password123', '6789012345', '987 Pine Rd', 'customer'),
('emilydavis', 'emily@email.com', 'password123', '7890123456', '147 Elm St', 'customer'),
('davidlee', 'david@email.com', 'password123', '8901234567', '258 Maple Dr', 'customer'),
('lisawang', 'lisa@email.com', 'password123', '9012345678', '369 Cedar Ln', 'customer'),
('jamesbrown', 'james@email.com', 'password123', '0123456789', '741 Birch St', 'customer')
ON DUPLICATE KEY UPDATE email=VALUES(email);

-- Add sample orders with proper relationships
INSERT INTO orders (userId, restaurantId, menuId, totalAmount, status, orderDate, deliveryAddress) VALUES
(1, 5, 1, 25.98, 'delivered', '2026-02-01 12:30:00', '123 Test St'),
(2, 6, 6, 35.97, 'delivered', '2026-02-01 13:15:00', '456 Test Ave'),
(3, 7, 11, 45.96, 'preparing', '2026-02-05 11:00:00', '789 Test Rd'),
(4, 8, 16, 33.97, 'delivered', '2026-02-02 18:20:00', '321 Main St'),
(5, 9, 21, 28.97, 'on_the_way', '2026-02-05 12:30:00', '654 Oak Ave'),
(6, 10, 26, 38.96, 'delivered', '2026-02-03 14:45:00', '987 Pine Rd'),
(7, 11, 31, 41.97, 'delivered', '2026-02-04 17:00:00', '147 Elm St'),
(8, 12, 36, 54.96, 'preparing', '2026-02-05 13:15:00', '258 Maple Dr');

SELECT 'Database populated successfully!' as Status;
SELECT CONCAT('Total Restaurants: ', COUNT(*)) as Result FROM restaurant;
SELECT CONCAT('Total Menu Items: ', COUNT(*)) as Result FROM menu;
SELECT CONCAT('Total Users: ', COUNT(*)) as Result FROM user;
SELECT CONCAT('Total Orders: ', COUNT(*)) as Result FROM orders;
