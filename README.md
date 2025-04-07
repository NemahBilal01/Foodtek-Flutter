#  Food Teck – Phase One
<!-- 
 Flutter Team Members:
1. Hourieh Jeibawi
2. Dana Khairallah
-->


##  Project Overview

Food Teck is a food delivery application developed using Flutter. It aims to provide a smooth user experience for browsing products, placing orders, making payments, and communicating with service providers.  
In this first phase, the Flutter team focused on designing and implementing the user interfaces and setting up the core infrastructure of the application.

---

##  Completed Work – Flutter Team (Phase One)

###  Initial Project Setup

- Organized the project structure using the MVC design pattern to ensure clean separation of concerns and ease of development and maintenance.
- Integrated Provider for efficient and scalable state management.
- Activated and connected Firebase to the app to enable authentication and data storage.

---

###  UI/UX Design and User Experience

- Designed and implemented separate Login and Sign-Up screens.
- Integrated Google Sign-In *(currently in progress)*.
- Enabled full Arabic language support across all screens.

---

###  Shopping & Ordering Experience

- Developed a product listing screen with the ability to add items to the Cart.
- Designed the Cart screen to view and manage selected items.
- Implemented the Checkout screen to complete purchases.
- Built a Chat screen to allow communication between users and service providers.

---

###  Order Management

- Enabled viewing of current and previous orders.
- Added a rating system to allow users to rate the service after order completion.

---

### Packages Used

- provider: for state management.
- firebase_core: for Firebase integration.
- firebase_auth: for Firebase authentication.
- google_sign_in: to enable Google authentication.
- flutter_rating_bar: for implementing the order rating feature.
- cupertino_icons: for iOS-style icons.
- firebase_messaging: for push notifications.
- geolocator: for location services.
- flutter_localization: for supporting multiple languages.
- animations: for adding animations to the app.
- lottie: for integrating Lottie animations.
- google_fonts: for easy access to Google Fonts.
- flutter_svg: for displaying SVG images.
- carousel_slider: for implementing image carousels.
- material_color_utilities: for generating material colors.
- lucide_icons: for additional icon sets.
- flutter_screenutil: for responsive screen design.
- google_maps_flutter: for integrating Google Maps.
- http: for making HTTP requests.
- sqflite: for local database storage.
- path: for working with file paths.
- shared_preferences: for saving simple data locally.
- flutter_facebook_auth: for Facebook authentication.
- sign_in_with_apple: for Apple authentication.
- country_code_picker: for selecting country codes.


##  Notes

- The application fully supports both Arabic and English languages.
- Google Sign-In is functional and integrated.
- Facebook and Apple Sign-In are still under testing on a physical device.
- Modern UI/UX standards have been followed to ensure a smooth and intuitive experience.

---

##  Next Steps

- Integrate with an external API to fetch product data and store orders.
- Implement push notifications to enhance user engagement.
- Refine UI design based on feedback and usability testing.
