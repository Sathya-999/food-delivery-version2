# Food Delivery Application 🍕

A modern, full-stack food delivery web application built with Java Servlets, JSP, and MySQL.

## 🌟 Features

- **User Authentication** - Secure login and registration system
- **Restaurant Browsing** - Browse restaurants by cuisine and location
- **Menu Management** - View detailed menu with images and pricing
- **Shopping Cart** - Add/remove items with quantity management
- **Quick Order** - One-click ordering for faster checkout
- **Payment Integration** - Integrated payment gateway simulation
- **Order Tracking** - Track order status in real-time
- **Responsive Design** - Works on all devices

## 🛠️ Tech Stack

- **Backend**: Java Servlets, JSP
- **Frontend**: HTML5, CSS3, JavaScript
- **Database**: MySQL
- **Server**: Apache Tomcat 9.0
- **Build Tool**: Maven

## 📁 Project Structure

```
food-delivery-app/
├── src/
│   ├── main/
│   │   ├── java/com/fooddelivery/
│   │   │   ├── controller/     # Servlet controllers
│   │   │   ├── dao/            # Data Access Objects
│   │   │   ├── model/          # Entity classes
│   │   │   ├── util/           # Utility classes
│   │   │   └── config/         # Configuration classes
│   │   ├── resources/          # Configuration files
│   │   └── webapp/
│   │       ├── css/            # Stylesheets
│   │       ├── js/             # JavaScript files
│   │       ├── images/         # Image assets
│   │       │   ├── food/       # Food item images
│   │       │   ├── restaurant/ # Restaurant images
│   │       │   └── ui/         # UI elements
│   │       ├── WEB-INF/
│   │       │   ├── views/      # JSP view files
│   │       │   └── web.xml     # Deployment descriptor
│   │       └── index.jsp
│   └── test/java/              # Test classes
├── sql/                        # Database scripts
├── pom.xml                     # Maven configuration
├── README.md
├── .gitignore
└── LICENSE
```

## 🚀 Getting Started

### Prerequisites

- Java JDK 11 or higher
- Apache Maven 3.6+
- MySQL 8.0+
- Apache Tomcat 9.0

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/Sathya-999/food-delivery-project.git
   cd food-delivery-app
   ```

2. **Setup Database**
   ```bash
   mysql -u root -p < sql/populate_db.sql
   ```

3. **Configure Database Connection**
   Update `src/main/java/com/fooddelivery/util/DBConnection.java` with your MySQL credentials.

4. **Build the Project**
   ```bash
   mvn clean package
   ```

5. **Deploy to Tomcat**
   Copy `target/food-delivery-app.war` to Tomcat's `webapps` directory.

6. **Access the Application**
   Open browser and navigate to `http://localhost:8080/food-delivery-app`

## 📸 Screenshots

### Home Page
- Modern UI with restaurant listings
- Category-based browsing
- Search functionality

### Menu Page
- Beautiful food cards with images
- Add to cart functionality
- Quick buy option

### Cart & Checkout
- Cart management
- Order summary
- Payment integration

## 🔧 Configuration

### Database Configuration
Edit `DBConnection.java`:
```java
private static final String URL = "jdbc:mysql://localhost:3306/fooddelivery";
private static final String USER = "your_username";
private static final String PASSWORD = "your_password";
```

## 📝 API Endpoints

| Endpoint | Method | Description |
|----------|--------|-------------|
| `/home` | GET | Home page with restaurants |
| `/menu` | GET | Restaurant menu |
| `/cart` | GET/POST | Shopping cart |
| `/quickOrder` | POST | Quick order placement |
| `/payment` | GET/POST | Payment processing |
| `/login` | GET/POST | User authentication |
| `/register` | GET/POST | User registration |

## 👨‍💻 Author

**G. Sathya Reddy**

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-blue)](https://www.linkedin.com/in/sathish-reddy-b035b2378)

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Andhra Pradesh cuisine inspiration
- Modern web design patterns
- Open source community

---

⭐ Star this repository if you find it helpful!
