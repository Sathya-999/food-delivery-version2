-- Update image paths from assets/img/food to images/food
UPDATE menu SET imagePath = REPLACE(imagePath, 'assets/img/food/', 'images/food/') WHERE imagePath LIKE 'assets/img/food/%';
UPDATE menu SET imagePath = REPLACE(imagePath, 'assets/img/', 'images/') WHERE imagePath LIKE 'assets/img/%';
