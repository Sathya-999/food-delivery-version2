package com.fooddelivery.dao;

public interface OtpDao {
    void saveOtp(int userId, int otp);
    boolean validateOtp(int userId, int otp);
    void markOtpUsed(int userId, int otp);
}

