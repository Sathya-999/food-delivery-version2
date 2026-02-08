package com.fooddelivery.util;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;

public class ImageRotationUtil {
    
    private static final LocalDate START_DATE = LocalDate.of(2026, 2, 5); // Today's date
    private static final int ROTATION_DAYS = 7;
    
    // Array of featured Andhra dish images that rotate
    private static final String[] FEATURED_IMAGES = {
        "ragi_sangati.jpg",     // Week 1
        "natukodi.jpg",         // Week 2
        "gongura_chicken.jpg",  // Week 3
        "royyala_vepudu.jpg",   // Week 4
        "biryani.jpg",          // Week 5
        "pulihora.jpg"          // Week 6
    };
    
    /**
     * Get the current featured image based on 7-day rotation
     * @return image filename
     */
    public static String getFeaturedImage() {
        long daysSinceStart = ChronoUnit.DAYS.between(START_DATE, LocalDate.now());
        int weekNumber = (int) (daysSinceStart / ROTATION_DAYS);
        int imageIndex = weekNumber % FEATURED_IMAGES.length;
        return FEATURED_IMAGES[imageIndex];
    }
    
    /**
     * Get image for menu item with dynamic rotation
     * @param baseImageName base image name
     * @return rotated image path
     */
    public static String getMenuImage(String baseImageName) {
        return "images/food/" + baseImageName;
    }
    
    /**
     * Get restaurant image
     * @param restaurantId restaurant id
     * @return image path
     */
    public static String getRestaurantImage(int restaurantId) {
        String[] restaurantImages = {
            "vijayawada_tiffin.jpg",
            "guntur_spice.jpg",
            "tirupati_balaji.jpg",
            "vizag_beach.jpg",
            "rayalaseema_ruchulu.jpg",
            "amaravati_grand.jpg",
            "nellore_seafood.jpg",
            "anantapur_biryani.jpg",
            "kadapa_ruchulu.jpg",
            "kakinada_konaseema.jpg"
        };
        
        if (restaurantId > 0 && restaurantId <= restaurantImages.length) {
            return "assets/img/restaurants/" + restaurantImages[restaurantId - 1];
        }
        return "assets/img/restaurants/default.jpg";
    }
    
    /**
     * Get days until next image rotation
     * @return days remaining
     */
    public static int getDaysUntilNextRotation() {
        long daysSinceStart = ChronoUnit.DAYS.between(START_DATE, LocalDate.now());
        int daysInCurrentWeek = (int) (daysSinceStart % ROTATION_DAYS);
        return ROTATION_DAYS - daysInCurrentWeek;
    }
    
    /**
     * Get featured dish name for current week
     * @return dish name
     */
    public static String getFeaturedDishName() {
        String[] dishNames = {
            "Ragi Sangati with Natukodi Pulusu",
            "Natukodi Pulusu (Country Chicken Curry)",
            "Gongura Chicken (Andhra Spicy)",
            "Royyala Vepudu (Prawns Fry)",
            "Andhra Biryani",
            "Pulihora (Tamarind Rice)"
        };
        
        long daysSinceStart = ChronoUnit.DAYS.between(START_DATE, LocalDate.now());
        int weekNumber = (int) (daysSinceStart / ROTATION_DAYS);
        int index = weekNumber % dishNames.length;
        return dishNames[index];
    }
}


