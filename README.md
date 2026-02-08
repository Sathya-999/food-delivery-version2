# 🍕 FoodLoop - Food Delivery Application

A complete, production-ready food delivery web application featuring authentic **Andhra Pradesh cuisine**. Built with Java Servlets, JSP, and MySQL.

![Java](https://img.shields.io/badge/Java-ED8B00?style=for-the-badge&logo=java&logoColor=white)
![MySQL](https://img.shields.io/badge/MySQL-005C84?style=for-the-badge&logo=mysql&logoColor=white)
![Apache Tomcat](https://img.shields.io/badge/Apache%20Tomcat-F8DC75?style=for-the-badge&logo=apachetomcat&logoColor=black)

---

## 📖 About This Project

**FoodLoop** is a food delivery application similar to Swiggy/Zomato, designed specifically for Andhra Pradesh regional cuisine. Users can browse restaurants, view menus, add items to cart, and place orders with payment integration.

### Why This Project?
- Learn **real-world Java web development**
- Understand **MVC architecture** with Servlets and JSP
- Practice **database operations** with MySQL
- Implement **user authentication** and **session management**
- Build a **responsive UI** that works on all devices

---

## ✨ Features

| Feature | Description |
|---------|-------------|
| 🔐 **User Authentication** | Login, Register with OTP verification |
| 🏪 **Restaurant Browsing** | 10+ restaurants with ratings and offers |
| 🍛 **Menu Display** | Beautiful circular food cards with images |
| 🛒 **Shopping Cart** | Add, remove, update quantities |
| ⚡ **Quick Order** | One-click buy for faster ordering |
| 💳 **Payment Integration** | UPI/Razorpay simulation |
| 📜 **Order History** | Track all your past orders |
| 📱 **Responsive Design** | Works on mobile, tablet, and desktop |

---

## 🛠️ Technologies Used

| Technology | Purpose |
|------------|---------|
| **Java 11+** | Backend logic |
| **Servlets/JSP** | Web framework |
| **MySQL** | Database |
| **HTML/CSS/JS** | Frontend |
| **Apache Tomcat 9** | Web server |
| **Maven** | Build tool |

---

## 📁 Project Structure

```
food-delivery-app/
│
├── src/main/java/com/fooddelivery/
│   ├── controller/          # Servlet controllers (login, cart, order, etc.)
│   ├── dao/                  # Database access objects
│   ├── model/                # Java models (User, Menu, Order, etc.)
│   ├── util/                 # Utility classes (DBConnection, etc.)
│   └── config/               # Configuration files
│
├── src/main/webapp/
│   ├── WEB-INF/views/        # JSP pages (home, menu, cart, login, etc.)
│   ├── images/               # Food and restaurant images
│   ├── css/                  # Stylesheets
│   └── js/                   # JavaScript files
│
├── sql/                      # Database setup scripts
├── pom.xml                   # Maven configuration
└── README.md                 # This file
```

---

## 🚀 How to Run This Project

### Step 1: Prerequisites
Make sure you have installed:
- ☕ **Java JDK 11** or higher
- 🗄️ **MySQL 8.0** or higher
- 🐱 **Apache Tomcat 9.0**
- 📦 **Maven** (optional, for building)

### Step 2: Clone the Repository
```bash
git clone https://github.com/Sathya-999/food-delivery-version2.git
cd food-delivery-version2
```

### Step 3: Setup Database
1. Open MySQL and create a database:
   ```sql
   CREATE DATABASE fooddelivery;
   USE fooddelivery;
   ```

2. Run the SQL scripts in order:
   ```bash
   mysql -u root -p fooddelivery < sql/populate_db.sql
   mysql -u root -p fooddelivery < sql/add_test_data.sql
   ```

### Step 4: Configure Database Connection
Edit `src/main/java/com/fooddelivery/util/DBConnection.java`:
```java
private static final String URL = "jdbc:mysql://localhost:3306/fooddelivery";
private static final String USER = "your_mysql_username";
private static final String PASSWORD = "your_mysql_password";
```

### Step 5: Deploy to Tomcat
1. Copy the `src/main/webapp` folder contents to Tomcat's `webapps/ROOT/` directory
2. Copy compiled classes to `webapps/ROOT/WEB-INF/classes/`
3. Add required JAR files to `webapps/ROOT/WEB-INF/lib/`

### Step 6: Start and Access
1. Start Tomcat server
2. Open browser: **http://localhost:8080/home**

---

## 📸 Application Pages

| Page | URL | Description |
|------|-----|-------------|
| Home | `/home` | Restaurant listings, categories, popular dishes |
| Menu | `/menu?restaurantId=1` | Restaurant's food menu |
| Cart | `/cart` | Shopping cart with items |
| Login | `/login` | User login page |
| Register | `/register` | New user registration |
| Orders | `/history` | Order history |
| Payment | `/payment` | Payment processing |

---

## 🎨 UI Highlights

- **Orange Theme** - Swiggy-inspired color scheme (#fc8019)
- **Circular Restaurant Cards** - Modern, clean design
- **Animated Categories** - Scrolling food category carousel
- **Responsive Layout** - 4-column grid on desktop, 1-column on mobile
- **Custom Favicon** - Orange "F" logo

---

## 👨‍💻 Author

**G. Sathya Reddy**

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-0A66C2?style=for-the-badge&logo=linkedin)](https://www.linkedin.com/in/sathish-reddy-b035b2378)
[![GitHub](https://img.shields.io/badge/GitHub-Follow-181717?style=for-the-badge&logo=github)](https://github.com/Sathya-999)

📧 Email: sathishreddykothuru@gmail.com

---

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

---

## 🌟 Support

If you found this project helpful, please give it a ⭐ star!

---

*Made with ❤️ in Andhra Pradesh, India*
