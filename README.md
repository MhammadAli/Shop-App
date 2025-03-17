# Cart Crashers Application

Welcome to the **Cart Crashers Application**, a modern e-commerce app built with Flutter. This application provides users with a seamless shopping experience, offering user registration, login, product browsing, and category-based filtering. The app is fully integrated with an API to manage user authentication, product data, and user preferences.

## Features

- **User Authentication**
  - Register and login using email credentials.
  - Securely store user session data with `shared_preferences`.

- **Product Browsing**
  - Explore a wide variety of products fetched dynamically from an API.
  - Smooth category-based product filtering.
  - Save favorite items for quick access.

- **User Preferences**
  - Save and manage user favorites persistently.
  - Personalized shopping experience tailored to user preferences.

- **Interactive UI**
  - Attractive and responsive design with rich animations and smooth navigation.
  - Carousel sliders and smooth page indicators for a delightful browsing experience.

## Packages Used

The following packages were used to implement the application's features:

| Package | Version | Description |
|---------|---------|-------------|
| [cupertino_icons](https://pub.dev/packages/cupertino_icons) | ^1.0.6 | Provides iOS-style icons. |
| [font_awesome_flutter](https://pub.dev/packages/font_awesome_flutter) | ^10.7.0 | Access to FontAwesome icons. |
| [bloc](https://pub.dev/packages/bloc) | ^8.1.4 | Business Logic Component for state management. |
| [flutter_bloc](https://pub.dev/packages/flutter_bloc) | ^8.1.5 | Integration of Bloc for Flutter. |
| [conditional_builder_null_safety](https://pub.dev/packages/conditional_builder_null_safety) | ^0.0.6 | Simplifies conditional UI rendering. |
| [dio](https://pub.dev/packages/dio) | ^4.0.6 | Handles API requests with ease. |
| [hexcolor](https://pub.dev/packages/hexcolor) | ^3.0.1 | Custom color support with hex codes. |
| [shared_preferences](https://pub.dev/packages/shared_preferences) | ^2.2.3 | Local storage for user preferences. |
| [smooth_page_indicator](https://pub.dev/packages/smooth_page_indicator) | ^1.1.0 | Beautiful page indicators for carousel sliders. |
| [fluttertoast](https://pub.dev/packages/fluttertoast) | ^8.2.6 | Toast notifications for user feedback. |
| [carousel_slider](https://pub.dev/packages/carousel_slider) | ^5.0.0 | Carousel slider widget. |

## API Integration

The app communicates with a RESTful API to provide the following functionalities:

1. **User Authentication**
   - Register new users with email and password.
   - Login to retrieve user-specific data.

2. **Product Management**
   - Fetch and display a list of products dynamically.
   - Categorize products for easy navigation.

3. **Favorites Management**
   - Save user-selected favorites persistently on the server.

---

Thank you for checking out the **Shop Application**! Happy shopping! 🎉
