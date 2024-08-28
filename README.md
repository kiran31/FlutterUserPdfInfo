# PDF Manager App

## Overview

The PDF Manager App is a Flutter application that allows users to input their personal information, convert it into a formatted PDF file, and upload it to Firebase. The application includes functionality for listing uploaded PDFs, inputting details, and managing (viewing, editing, and deleting) PDF files.

## Features

- **List Uploaded PDFs**: Display all PDFs uploaded to Firebase on the home screen.
- **Input Personal Details**: Provide a form to input personal information and generate a PDF file.
- **View PDF Details**: View the details of a selected PDF with options to edit or delete.
- **Edit/Delete PDF**: Replace existing PDFs with new ones or remove them from Firebase.

## Installation

1. **Clone the repository**:
    ```bash
    git remote add origin https://github.com/kiran31/FlutterUserPdfInfo.git
    ```

2. **Navigate to the project directory**:
    ```bash
    cd pdf-manager-app
    ```

3. **Install dependencies**:
    ```bash
    flutter pub get
    ```

4. **Set up Firebase**:
    - Follow the instructions in the [Firebase documentation](https://firebase.google.com/docs/flutter/setup) to set up Firebase for your Flutter app.
    - Download the `google-services.json` file and place it in the `android/app` directory.
    - Download the `GoogleService-Info.plist` file and place it in the `ios/Runner` directory.

5. **Run the app**:
    ```bash
    flutter run
    ```

## App Structure

- **`lib/`**: Contains the Dart source files.
    - **`main.dart`**: Entry point of the application.
    - **`screens/`**: Contains the UI screens (`HomeScreen`, `UploadScreen`, `DetailsScreen`).
    - **`controllers/`**: Contains GetX controllers (`HomeController`, `UploadController`, `DetailsController`).
    - **`models/`**: Contains data models and classes for Firebase operations.
    - **`services/`**: Contains services for Firebase interactions and PDF generation.
    - **`widgets/`**: Contains reusable UI components.

## GetX Controller Usage

- **HomeController**: Manages the list of uploaded PDFs and data retrieval from Firebase.
- **UploadController**: Handles user input, PDF generation, and uploading to Firebase.
- **DetailsController**: Manages PDF details, editing, and deletion.

## Firebase Integration

- **Firestore**: Used for storing metadata about uploaded PDFs.
- **Firebase Storage**: Used for storing the actual PDF files.

## PDF Generation

- **`pdf` package**: Used to generate PDF files from user input.
- **`flutter_pdfview` package**: Used to view PDF files within the app.

## Navigation

- **HomeScreen**: Displays the list of uploaded PDFs. Navigate using `Get.to()` for this screen.
- **UploadScreen**: Form for entering personal details and uploading PDFs. Use `Get.to()` for navigation.
- **DetailsScreen**: Shows details of the selected PDF with options to edit or delete. Use `Get.to()` for navigation.

## Contributing

1. **Fork the repository** and clone it to your local machine.
2. **Create a new branch** for your changes:
    ```bash
    git checkout -b feature/your-feature-name
    ```
3. **Commit your changes**:
    ```bash
    git commit -am 'Add some feature'
    ```
4. **Push to the branch**:
    ```bash
    git push origin feature/your-feature-name
    ```
5. **Create a pull request**.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgements

- [Flutter](https://flutter.dev) for the framework.
- [Firebase](https://firebase.google.com) for backend services.
- [GetX](https://pub.dev/packages/get) for state management and navigation.

---

Feel free to modify or expand this template based on your specific project needs and requirements.
