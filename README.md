# Food Budget App

## Overview
The Food Budget App is an iOS application designed to help students manage their food expenses during a semester. It allows users to set a budget, input meal expenses, and view various statistics about their spending habits.

## Main Components and Functionalities

### 1. FoodBudgetApp.swift
This is the main entry point of the application. It sets up the app structure and initializes the main ContentView.

### 2. ContentView.swift
The ContentView serves as the main container for the app, implementing a tab-based navigation system with three main views:
- Budget Input
- Meal Input
- Statistics

It uses SwiftUI's TabView for navigation and applies smooth transitions between tabs.

### 3. BudgetManager.swift
This file contains the core logic of the app:

- `BudgetManager` class: Manages the app's data and calculations.
  - Stores and updates the total budget and meal data.
  - Implements data persistence using UserDefaults.
  - Provides methods for statistical calculations:
    - Average cost per meal
    - Average cost per restaurant
    - Monthly spending
    - Semester total spending

- `Meal` struct: Represents individual meal entries with properties like name, cost, restaurant, and date.

### 4. BudgetInputView.swift
This view allows users to set their total food budget for the semester:
- Provides a text field for budget input.
- Implements input validation to ensure a valid budget is entered.
- Uses animations for a more engaging user experience.

### 5. MealInputView.swift
This view enables users to add new meal entries:
- Includes fields for meal name, cost, and restaurant.
- Implements input validation for all fields.
- Automatically saves new entries to the BudgetManager.
- Uses animations for smooth transitions and updates.

### 6. StatisticsView.swift
This view displays various statistics and charts about the user's spending:
- Average Cost per Meal
- Restaurant Average Costs (bar chart)
- Monthly Spending (line chart)
- Semester Spending (progress bar)

Each statistic is presented in its own subview with custom styling and animations:
- `AverageCostPerMealView`
- `RestaurantAverageCostsView`
- `MonthlySpendingView`
- `SemesterSpendingView`

## Key Features
1. Set and update semester food budget
2. Add individual meal expenses
3. View average cost per meal
4. Analyze spending by restaurant
5. Track monthly spending trends
6. Monitor total semester spending against budget
7. Data persistence across app sessions
8. Input validation and error handling
9. Smooth animations and transitions for enhanced user experience

## Technologies Used
- Swift
- SwiftUI
- Charts framework for data visualization
- UserDefaults for local data storage

## Getting Started
1. Clone the repository
2. Open the project in Xcode
3. Build and run the app on an iOS simulator or device

## Future Enhancements
- Implement Core Data for more robust data management
- Add the ability to edit or delete meal entries
- Introduce categories for meal types
- Implement data export functionality
- Add user authentication for multi-user support