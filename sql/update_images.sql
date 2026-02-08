-- Add imagePath column (ignore error if already exists)
-- If this fails, the column already exists - that's OK
SET @col_exists = (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'fooddelivery' AND TABLE_NAME = 'menu' AND COLUMN_NAME = 'imagePath');
SET @sql = IF(@col_exists = 0, 'ALTER TABLE menu ADD COLUMN imagePath VARCHAR(255) DEFAULT NULL', 'SELECT "imagePath column already exists"');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- Update ALL menu items with matching image paths
-- Restaurant 1: Vijayawada Tiffin Center
UPDATE menu SET imagePath = 'assets/img/food/pesarattu.jpg' WHERE itemName = 'Pesarattu';
UPDATE menu SET imagePath = 'assets/img/food/upma.jpg' WHERE itemName = 'Upma';
UPDATE menu SET imagePath = 'assets/img/food/idli_sambar.jpg' WHERE itemName = 'Idli Sambar';
UPDATE menu SET imagePath = 'assets/img/food/dosa.jpg' WHERE itemName = 'Dosa';
UPDATE menu SET imagePath = 'assets/img/food/vada.jpg' WHERE itemName = 'Vada';

-- Restaurant 2: Guntur Spice Kitchen
UPDATE menu SET imagePath = 'assets/img/food/gongura_chicken.jpg' WHERE itemName = 'Gongura Chicken';
UPDATE menu SET imagePath = 'assets/img/food/chicken65.jpg' WHERE itemName = 'Chicken 65';
UPDATE menu SET imagePath = 'assets/img/food/gutti_vankaya.jpg' WHERE itemName = 'Gutti Vankaya';
UPDATE menu SET imagePath = 'assets/img/food/mirchibajji.jpg' WHERE itemName = 'Mirchi Bajji';
UPDATE menu SET imagePath = 'assets/img/food/punugulu.jpg' WHERE itemName = 'Punugulu';

-- Restaurant 3: Tirupati Balaji Meals
UPDATE menu SET imagePath = 'assets/img/food/pulihora.jpg' WHERE itemName = 'Pulihora';
UPDATE menu SET imagePath = 'assets/img/food/boondi_laddu.jpg' WHERE itemName = 'Boondi Laddu';
UPDATE menu SET imagePath = 'assets/img/food/curd rice.jpg' WHERE itemName = 'Curd Rice';
UPDATE menu SET imagePath = 'assets/img/food/rasam.jpg' WHERE itemName = 'Rasam';
UPDATE menu SET imagePath = 'assets/img/food/papad.jpg' WHERE itemName = 'Papad';

-- Restaurant 4: Visakhapatnam Beach Restaurant
UPDATE menu SET imagePath = 'assets/img/food/royyala_vepudu.jpg' WHERE itemName = 'Royyala Vepudu';
UPDATE menu SET imagePath = 'assets/img/food/fish_pulusu.jpg' WHERE itemName = 'Fish Pulusu';
UPDATE menu SET imagePath = 'assets/img/food/chapala pulusu.jpg' WHERE itemName = 'Chepala Pulusu';
UPDATE menu SET imagePath = 'assets/img/food/prawns.jpg' WHERE itemName = 'Prawns Fry';
UPDATE menu SET imagePath = 'assets/img/food/crab_masala.jpg' WHERE itemName = 'Crab Masala';

-- Restaurant 5: Rayalaseema Ruchulu
UPDATE menu SET imagePath = 'assets/img/food/ragi_sangati.jpg' WHERE itemName = 'Ragi Sangati';
UPDATE menu SET imagePath = 'assets/img/food/natukodi_pulusu.jpg' WHERE itemName = 'Natukodi Pulusu';
UPDATE menu SET imagePath = 'assets/img/food/paya_curry.jpg' WHERE itemName = 'Paya Curry';
UPDATE menu SET imagePath = 'assets/img/food/gongura_pachadi.jpg' WHERE itemName = 'Gongura Pachadi';
UPDATE menu SET imagePath = 'assets/img/food/ulava_charu.jpg' WHERE itemName = 'Ulava Charu';

-- Restaurant 6: Amaravati Grand Kitchen
UPDATE menu SET imagePath = 'assets/img/food/andhra_meals.jpg' WHERE itemName = 'Andhra Meals';
UPDATE menu SET imagePath = 'assets/img/food/biryani.jpg' WHERE itemName = 'Biryani';
UPDATE menu SET imagePath = 'assets/img/food/pulusu.jpg' WHERE itemName = 'Pulusu';
UPDATE menu SET imagePath = 'assets/img/food/pappu.jpg' WHERE itemName = 'Pappu';
UPDATE menu SET imagePath = 'assets/img/food/avakaya.jpg' WHERE itemName = 'Avakaya Pickle';

-- Restaurant 7: Nellore Seafood Paradise
UPDATE menu SET imagePath = 'assets/img/food/chepala_vepudu.jpg' WHERE itemName = 'Chepala Vepudu';
UPDATE menu SET imagePath = 'assets/img/food/royyala_iguru.jpg' WHERE itemName = 'Royyala Iguru';
UPDATE menu SET imagePath = 'assets/img/food/nellore_chepala.jpg' WHERE itemName = 'Nellore Chepala Pulusu';
UPDATE menu SET imagePath = 'assets/img/food/gongura_royyalu.jpg' WHERE itemName = 'Gongura Royyalu';

-- Restaurant 8: Anantapur Biryani House
UPDATE menu SET imagePath = 'assets/img/food/mutton_biryani.jpg' WHERE itemName = 'Mutton Biryani';
UPDATE menu SET imagePath = 'assets/img/food/chicken_biryani.jpg' WHERE itemName = 'Chicken Biryani';
UPDATE menu SET imagePath = 'assets/img/food/veg_biryani.jpg' WHERE itemName = 'Veg Biryani';
UPDATE menu SET imagePath = 'assets/img/food/raita.jpg' WHERE itemName = 'Raita';

-- Restaurant 9: Kadapa Ruchulu
UPDATE menu SET imagePath = 'assets/img/food/ragi_sangati.jpg' WHERE itemName = 'Ragi Mudde';
UPDATE menu SET imagePath = 'assets/img/food/natukodi.jpg' WHERE itemName = 'Natu Kodi';
UPDATE menu SET imagePath = 'assets/img/food/boti_curry.jpg' WHERE itemName = 'Boti Curry';

-- Restaurant 10: Kakinada Konaseema Kitchen
UPDATE menu SET imagePath = 'assets/img/food/kaaja.jpg' WHERE itemName = 'Kaaja';
UPDATE menu SET imagePath = 'assets/img/food/boorelu.jpg' WHERE itemName = 'Boorelu';
UPDATE menu SET imagePath = 'assets/img/food/ariselu.jpg' WHERE itemName = 'Ariselu';
UPDATE menu SET imagePath = 'assets/img/food/pootharekulu.jpg' WHERE itemName = 'Pootharekulu';
UPDATE menu SET imagePath = 'assets/img/food/madugula_halwa.jpg' WHERE itemName = 'Madugula Halwa';
UPDATE menu SET imagePath = 'assets/img/food/bobbtallu.jpg' WHERE itemName = 'Bobbatlu';

-- Extra items that might exist
UPDATE menu SET imagePath = 'assets/img/food/dosa.jpg' WHERE itemName = 'Masala Dosa';
UPDATE menu SET imagePath = 'assets/img/food/general_tso.jpg' WHERE itemName = 'General Tso Chicken';
UPDATE menu SET imagePath = 'assets/img/food/chow_mein.jpg' WHERE itemName = 'Chow Mein';
UPDATE menu SET imagePath = 'assets/img/food/egg_rolls.jpg' WHERE itemName = 'Egg Rolls';
UPDATE menu SET imagePath = 'assets/img/food/paya_curry.jpg' WHERE itemName = 'Paya Curry';

-- Catch-all: Set default image for any remaining NULL imagePath based on category
UPDATE menu SET imagePath = 'assets/img/food/dosa.jpg' WHERE imagePath IS NULL AND category = 'Breakfast';
UPDATE menu SET imagePath = 'assets/img/food/natukodi.jpg' WHERE imagePath IS NULL AND category = 'Non-Veg';
UPDATE menu SET imagePath = 'assets/img/food/punugulu.jpg' WHERE imagePath IS NULL AND category = 'Snack';
UPDATE menu SET imagePath = 'assets/img/food/biryani.jpg' WHERE imagePath IS NULL AND category IN ('Rice', 'Biryani', 'Main');
UPDATE menu SET imagePath = 'assets/img/food/prawns.jpg' WHERE imagePath IS NULL AND category = 'Seafood';
UPDATE menu SET imagePath = 'assets/img/food/bobbtallu.jpg' WHERE imagePath IS NULL AND category IN ('Sweet', 'Dessert');
UPDATE menu SET imagePath = 'assets/img/food/rasam.jpg' WHERE imagePath IS NULL AND category IN ('Soup', 'Dal', 'Curry');
UPDATE menu SET imagePath = 'assets/img/food/andhra_meals.jpg' WHERE imagePath IS NULL AND category IN ('Veg', 'Thali', 'Side', 'Pickle');
UPDATE menu SET imagePath = 'assets/img/food/dosa.jpg' WHERE imagePath IS NULL AND category = 'Bread';

-- Final catch-all for anything still NULL
UPDATE menu SET imagePath = 'assets/img/food/andhra_meals.jpg' WHERE imagePath IS NULL;

-- Verify
SELECT menuId, itemName, imagePath FROM menu ORDER BY menuId;
SELECT CONCAT('Items with images: ', COUNT(*)) FROM menu WHERE imagePath IS NOT NULL;
SELECT CONCAT('Items without images: ', COUNT(*)) FROM menu WHERE imagePath IS NULL;
