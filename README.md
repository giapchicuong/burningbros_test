# BurningBros Test Project

This is a Flutter project designed to implement an infinite scrolling list of products, fetch product data from an API, and provide a search functionality. The app also includes a feature to mark products as favorites and stores this data locally.

## Features

- Infinite scrolling: Load the next 20 products when the user scrolls to the end of the list.
- Product Search: Users can search for products by name.
- Product Favorites: Mark products as favorites and store them in a local database.
- Network connectivity check and error handling.
- Simple UI and UX for managing product listings.

## Setup Instructions

### 1. Clone the repository

First, clone the repository:

```bash
git clone https://github.com/giapchicuong/burningbros_test.git
```

After cloning the repository, navigate into the project folder:

```bash
cd burningbros_test
```

### 2. Install dependencies

Next, run the following command to install the required dependencies defined in the `pubspec.yaml` file:

```bash
flutter pub get
```

This will download and set up all the necessary packages for the project.

### 3. Run the application

Once the dependencies are installed, you can run the Flutter application using the following command:

```bash
flutter run
```
This will compile and launch the app on your connected device or emulator.

### 4. **Run on a specific device**

If you have multiple devices connected (e.g., an emulator and a physical device), you can specify which device to run the app on. To list the available devices, use the following command:

```bash
flutter devices
```

Then, run the app on a specific device by providing its device ID:

```bash
flutter run -d <device_id>
```

### 5. **Run in different build modes**

Flutter allows you to run your application in different build modes:

- **Debug mode** (default when running `flutter run`): For development purposes, with debugging and logging enabled.
- **Release mode**: For testing the final performance of the app without debug information.

To run in release mode, use the following command:

```bash
flutter run --release
```

### 6. **Flutter SDK and Dart SDK Setup**

Ensure that you have Flutter and Dart SDK installed on your machine. You can check the installation guides for both:

- [Flutter Installation Guide](https://flutter.dev/docs/get-started/install)
- [Dart Installation Guide](https://dart.dev/get-dart)

Once you have set up Flutter and Dart, run `flutter doctor` to check that everything is installed correctly.

```bash
flutter doctor
```

This will help identify any missing dependencies or configuration issues.

