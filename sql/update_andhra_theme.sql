-- Update restaurants with Andhra Pradesh theme and images
UPDATE restaurant SET 
    name = 'Vijayawada Tiffin Center',
    cuisineType = 'Andhra',
    address = 'MG Road, Vijayawada',
    ratings = 4.7
WHERE restaurantId = 1;

UPDATE restaurant SET 
    name = 'Guntur Spice Kitchen',
    cuisineType = 'Andhra Spicy',
    address = 'Guntur Main Road',
    ratings = 4.8
WHERE restaurantId = 2;

UPDATE restaurant SET 
    name = 'Tirupati Balaji Meals',
    cuisineType = 'South Indian',
    address = 'Temple Street, Tirupati',
    ratings = 4.6
WHERE restaurantId = 3;

UPDATE restaurant SET 
    name = 'Visakhapatnam Beach Restaurant',
    cuisineType = 'Coastal Andhra',
    address = 'Beach Road, Vizag',
    ratings = 4.9
WHERE restaurantId = 4;

UPDATE restaurant SET 
    name = 'Rayalaseema Ruchulu',
    cuisineType = 'Rayalaseema',
    address = 'Kurnool Highway',
    ratings = 4.5
WHERE restaurantId = 5;

UPDATE restaurant SET 
    name = 'Amaravati Grand Kitchen',
    cuisineType = 'Andhra Traditional',
    address = 'Capital Road, Amaravati',
    ratings = 4.7
WHERE restaurantId = 6;

UPDATE restaurant SET 
    name = 'Nellore Seafood Paradise',
    cuisineType = 'Coastal Andhra',
    address = 'Harbor Road, Nellore',
    ratings = 4.8
WHERE restaurantId = 7;

UPDATE restaurant SET 
    name = 'Anantapur Biryani House',
    cuisineType = 'Biryani Specialist',
    address = 'Station Road, Anantapur',
    ratings = 4.6
WHERE restaurantId = 8;

UPDATE restaurant SET 
    name = 'Kadapa Ruchulu',
    cuisineType = 'Rayalaseema Style',
    address = 'YSR Road, Kadapa',
    ratings = 4.7
WHERE restaurantId = 9;

UPDATE restaurant SET 
    name = 'Kakinada Konaseema Kitchen',
    cuisineType = 'East Godavari',
    address = 'Canal Road, Kakinada',
    ratings = 4.5
WHERE restaurantId = 10;

-- Update menu items with Andhra dishes and images
-- Restaurant 1: Vijayawada Tiffin Center
UPDATE menu SET itemName='Pesarattu', category='Breakfast', price=8.99, spiceLevel='Medium' WHERE menuId=1;
UPDATE menu SET itemName='Upma', category='Breakfast', price=6.99, spiceLevel='Mild' WHERE menuId=2;
UPDATE menu SET itemName='Idli Sambar', category='Breakfast', price=7.99, spiceLevel='Medium' WHERE menuId=3;
UPDATE menu SET itemName='Dosa', category='Breakfast', price=8.99, spiceLevel='Medium' WHERE menuId=4;
UPDATE menu SET itemName='Vada', category='Snack', price=5.99, spiceLevel='Medium' WHERE menuId=5;

-- Restaurant 2: Guntur Spice Kitchen
UPDATE menu SET itemName='Gongura Chicken', category='Non-Veg', price=14.99, spiceLevel='Hot' WHERE menuId=6;
UPDATE menu SET itemName='Chicken 65', category='Non-Veg', price=12.99, spiceLevel='Hot' WHERE menuId=7;
UPDATE menu SET itemName='Gutti Vankaya', category='Veg', price=10.99, spiceLevel='Medium' WHERE menuId=8;
UPDATE menu SET itemName='Mirchi Bajji', category='Snack', price=4.99, spiceLevel='Hot' WHERE menuId=9;
UPDATE menu SET itemName='Punugulu', category='Snack', price=6.99, spiceLevel='Medium' WHERE menuId=10;

-- Restaurant 3: Tirupati Balaji Meals
UPDATE menu SET itemName='Pulihora', category='Rice', price=9.99, spiceLevel='Mild' WHERE menuId=11;
UPDATE menu SET itemName='Boondi Laddu', category='Sweet', price=5.99, spiceLevel='None' WHERE menuId=12;
UPDATE menu SET itemName='Curd Rice', category='Rice', price=7.99, spiceLevel='Mild' WHERE menuId=13;
UPDATE menu SET itemName='Rasam', category='Soup', price=4.99, spiceLevel='Medium' WHERE menuId=14;
UPDATE menu SET itemName='Papad', category='Side', price=2.99, spiceLevel='Mild' WHERE menuId=15;

-- Restaurant 4: Visakhapatnam Beach Restaurant
UPDATE menu SET itemName='Royyala Vepudu', category='Seafood', price=16.99, spiceLevel='Hot' WHERE menuId=16;
UPDATE menu SET itemName='Fish Pulusu', category='Seafood', price=15.99, spiceLevel='Medium' WHERE menuId=17;
UPDATE menu SET itemName='Chepala Pulusu', category='Seafood', price=14.99, spiceLevel='Medium' WHERE menuId=18;
UPDATE menu SET itemName='Prawns Fry', category='Seafood', price=17.99, spiceLevel='Hot' WHERE menuId=19;
UPDATE menu SET itemName='Crab Masala', category='Seafood', price=18.99, spiceLevel='Hot' WHERE menuId=20;

-- Restaurant 5: Rayalaseema Ruchulu
UPDATE menu SET itemName='Ragi Sangati', category='Main', price=11.99, spiceLevel='Mild' WHERE menuId=21;
UPDATE menu SET itemName='Natukodi Pulusu', category='Non-Veg', price=15.99, spiceLevel='Hot' WHERE menuId=22;
UPDATE menu SET itemName='Paya Curry', category='Non-Veg', price=16.99, spiceLevel='Medium' WHERE menuId=23;
UPDATE menu SET itemName='Gongura Pachadi', category='Side', price=4.99, spiceLevel='Medium' WHERE menuId=24;
UPDATE menu SET itemName='Ulava Charu', category='Soup', price=6.99, spiceLevel='Medium' WHERE menuId=25;

-- Restaurant 6: Amaravati Grand Kitchen
UPDATE menu SET itemName='Andhra Meals', category='Thali', price=13.99, spiceLevel='Medium' WHERE menuId=26;
UPDATE menu SET itemName='Biryani', category='Rice', price=14.99, spiceLevel='Medium' WHERE menuId=27;
UPDATE menu SET itemName='Pulusu', category='Curry', price=11.99, spiceLevel='Medium' WHERE menuId=28;
UPDATE menu SET itemName='Pappu', category='Dal', price=8.99, spiceLevel='Mild' WHERE menuId=29;
UPDATE menu SET itemName='Avakaya Pickle', category='Pickle', price=3.99, spiceLevel='Hot' WHERE menuId=30;

-- Restaurant 7: Nellore Fish Market
UPDATE menu SET itemName='Chepala Vepudu', category='Seafood', price=15.99, spiceLevel='Hot' WHERE menuId=31;
UPDATE menu SET itemName='Royyala Iguru', category='Seafood', price=17.99, spiceLevel='Hot' WHERE menuId=32;
UPDATE menu SET itemName='Nellore Chepala Pulusu', category='Seafood', price=16.99, spiceLevel='Medium' WHERE menuId=33;
UPDATE menu SET itemName='Gongura Royyalu', category='Seafood', price=18.99, spiceLevel='Hot' WHERE menuId=34;

-- Restaurant 8: Anantapur Biryani House
UPDATE menu SET itemName='Mutton Biryani', category='Biryani', price=16.99, spiceLevel='Medium' WHERE menuId=35;
UPDATE menu SET itemName='Chicken Biryani', category='Biryani', price=14.99, spiceLevel='Medium' WHERE menuId=36;
UPDATE menu SET itemName='Veg Biryani', category='Biryani', price=12.99, spiceLevel='Mild' WHERE menuId=37;
UPDATE menu SET itemName='Raita', category='Side', price=3.99, spiceLevel='None' WHERE menuId=38;

-- Restaurant 9: Kadapa Ruchulu
UPDATE menu SET itemName='Ragi Mudde', category='Main', price=10.99, spiceLevel='Mild' WHERE menuId=39;
UPDATE menu SET itemName='Natu Kodi', category='Non-Veg', price=16.99, spiceLevel='Hot' WHERE menuId=40;
UPDATE menu SET itemName='Boti Curry', category='Non-Veg', price=15.99, spiceLevel='Hot' WHERE menuId=41;

-- Restaurant 10: Kakinada Kitchen
UPDATE menu SET itemName='Kaaja', category='Sweet', price=6.99, spiceLevel='None' WHERE menuId=42;
UPDATE menu SET itemName='Boorelu', category='Sweet', price=5.99, spiceLevel='None' WHERE menuId=43;
UPDATE menu SET itemName='Ariselu', category='Sweet', price=7.99, spiceLevel='None' WHERE menuId=44;

-- Add new menu items with images for remaining items
INSERT INTO menu (restaurantId, itemName, category, price, availability, spiceLevel) VALUES
(10, 'Pootharekulu', 'Sweet', 8.99, 1, 'None'),
(10, 'Madugula Halwa', 'Sweet', 6.99, 1, 'None'),
(10, 'Bobbatlu', 'Sweet', 5.99, 1, 'None');

SELECT 'Database updated with Andhra Pradesh theme!' as Status;
SELECT CONCAT('Restaurants: ', COUNT(*)) FROM restaurant;
SELECT CONCAT('Menu Items: ', COUNT(*)) FROM menu;
