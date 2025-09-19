<h1 align="center" id="title">Ahwa App</h1>

<p id="description">The Smart Ahwa App is a user-friendly and scalable application designed to manage a ahwa's menu orders and reports.with two interface user flow It allows managers to efficiently handle menu items track orders and generate reports on sales and performance and allow user to navigate through menu items and order . The app follows SOLID principles and OOP to ensure maintainability flexibility and ease of expansion.</p>

<h2>🚀 Demo</h2>

<h2>Project Screenshots:</h2>

<img src="https://github.com/mernaatef28/Ahwa_Manager/blob/main/assets/Green%20and%20Pale%20Yellow%20Simple%20Food%20Apps%20Instagram%20Post/1.png?raw=true" alt="project-screenshot"  >

## Key Features

### 1. Menu Management
- **Add Menu Items**: Create new items with details like name, category, price, and image.
- **Update Menu Items**: Modify existing items (e.g., price, category, or image).
- **Delete Menu Items**: Remove menu items from the list.
- **View Menu**: Display a list of all menu items, with the option to filter by category (e.g., drinks, snacks).
- **Search/Filter**: Find specific items based on criteria (e.g., price range or category).

### 2. Order Management
- **Track Orders**: View and manage orders with statuses (e.g., "pending", "complete").
- **Order Display**: The manager can see a list of all orders, with filtering options:
  - **Pending Orders**: Orders that are placed but not yet processed.
  - **Complete Orders**: Orders that have been fulfilled and delivered.
- **Order Status Update**: The manager can update the status of orders (e.g., from pending to complete).

### 3. Reporting
- **Sales Report**: Generate reports on sales performance over a specified period.
  - Report may include total sales, top-selling items, and average order value.
- **Order Report**: Track and report on the total number of orders and their statuses (pending vs. complete).
- **Custom Reporting**: The manager can view reports based on specific filters such as date range, category, or product.

### 4. Manager Dashboard
- **Centralized View**: The manager can see both the menu and order status in one place.
- **Pending Orders/Status**: A dedicated area to track orders that need attention (pending or completed).
- **Data Insights**: The dashboard shows aggregated sales and order metrics to help the manager make informed decisions.

### 5. Responsive Design
- The UI adapts to different screen sizes, ensuring that menu items and orders are easily accessible on both desktop and mobile devices.

---
## Manager user flow 
<img src="https://github.com/mernaatef28/Ahwa_Manager/blob/main/assets/Green%20and%20Pale%20Yellow%20Simple%20Food%20Apps%20Instagram%20Post/2.png?raw=true" alt="project-screenshot"  >
## Customer user flow 
<img src="https://github.com/mernaatef28/Ahwa_Manager/blob/main/assets/Green%20and%20Pale%20Yellow%20Simple%20Food%20Apps%20Instagram%20Post/3.png?raw=true" alt="project-screenshot"  >
## SOLID & OOP Principles Used

- **Single Responsibility**: Each class and module has one job, e.g., `MenuItem` is for item data, `MenuService` handles business logic, `MenuRepository` manages data access, and `OrderService` manages order workflows.
- **Open/Closed**: The system is open for extension (e.g., adding new features like reporting or changing data storage) but closed for modification.
- **Liskov Substitution**: Different implementations of repositories (e.g., in-memory or database) can be swapped without breaking functionality.
- **Interface Segregation**: Interfaces like `MenuRepository` focus solely on menu-related operations, and `OrderRepository` does the same for order-related operations.
- **Dependency Inversion**: The app depends on abstractions like `MenuService`, `OrderService`, and `MenuRepository`, making it flexible and testable.

---

## Conclusion
This app provides a clean and efficient way to manage a café's **menu**, **orders**, and **reports** with easy-to-use filtering and status tracking, all while following **SOLID** principles for maintainable and scalable architecture.

---

## Setup and Installation

To set up the project locally, follow these steps:

1. Clone the repository:
    ```bash
    git clone https://github.com/yourusername/smart-cafe-app.git
    ```

2. Install dependencies:
    ```bash
    flutter pub get
    ```

3. Run the app:
    ```bash
    flutter run
    ```

Make sure to configure the required database or repository implementation (e.g., in-memory or database storage) as per your needs.

---

## Future Enhancements
- Implement payment processing for orders.
- Add detailed user authentication and role-based access.
- Expand reporting features (e.g., weekly/monthly sales analytics).
