# Flutter User Management Application

This is a **Flutter-based User Management Application** designed to demonstrate core functionalities like fetching user data from an API, displaying user posts, saving users to a local database, and navigating through different screens using a `BottomNavigationBar`. The application uses **SQLite** for local storage and **JSONPlaceholder API** for fetching user and post data.

---
## Features

This application showcases the following features:

### **1. Fetch Users**
- Fetches user data including **ID**, **Name**, and **Email** from the JSONPlaceholder API.
- Displays user data in a clean and simple list format.
- Includes **user ID** alongside the **user name** for better identification.

### **2. View Posts**
- Displays posts for a specific user, fetched dynamically from the API.
- Lists posts with sequential numbering starting from `1` for each user.
- Shows the **Post Title** and **Post Body** for each entry.

### **3. Save Users**
- Allows users to save specific user profiles to a local SQLite database.
- Provides feedback using a `Snackbar` when a user is successfully saved.

### **4. View Saved Users**
- Displays a list of users saved locally in the SQLite database.
- Includes both **User ID** and **User Name** for each saved entry.

### **5. Bottom Navigation**
- Provides easy navigation between:
    - **Users Screen**: Displays all users fetched from the API.
    - **Saved Users Screen**: Displays users stored in the local database.

## Technologies Used

### **1. Frontend**
- **Flutter**: A UI toolkit for building natively compiled applications for mobile, web, and desktop from a single codebase.
- **Dart**: Programming language used with Flutter for building the application.

### **2. Backend**
- **SQLite**: A lightweight database engine for storing user data locally on the device.

### **3. Networking**
- **http**: Dart package for making HTTP requests to fetch data from APIs.

---
## Application Workflow

1. **Users Screen**:
    - Fetches user data from the API and displays it in a list.
    - Allows saving specific users to the local SQLite database.

2. **Posts Screen**:
    - Displays posts for a selected user, fetched dynamically from the API.
    - Lists posts with proper numbering and formatting.

3. **Saved Users Screen**:
    - Displays users saved to the SQLite database.
    - Enables viewing posts for saved users.

4. **Navigation**:
    - `BottomNavigationBar` allows easy switching between the Users Screen and Saved Users Screen.

## Screenshots 

- ![ss0.png](/ScreenShots/ss0.png)

- ![ss1.png](/ScreenShots/ss1.png)

- ![ss2.png](/ScreenShots/ss2.png)

- ![ss3.png](/ScreenShots/ss3.png)

- ![ss4.png](/ScreenShots/ss4.png)
