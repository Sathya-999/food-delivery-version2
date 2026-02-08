package com.fooddelivery.dao;

import com.fooddelivery.model.User;
import java.util.List;

public interface UserDao {
    void insert(User user);
    List<User> fetchAll();
    User fetchByEmail(String email);
    User fetchByMobile(long mobile);
    void update(User user);
    void delete(int userId);
    int insertUser(String name, String email, String mobile);
    void updatePassword(int userId, String password);
}

