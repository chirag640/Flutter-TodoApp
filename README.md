# Flutter Todo App

A simple and elegant Todo App built with Flutter. This app allows users to manage their tasks efficiently with features like user authentication, theming, and persistent storage using SQLite.

## Features

- User Authentication
- Add, Update, and Delete Todos
- Search Todos
- Dark and Light Theme Support
- Persistent Storage with SQLite
- User-specific Todos


## Getting Started

### Prerequisites

- [Flutter](https://flutter.dev/docs/get-started/install) (version 2.0 or later)
- [Dart](https://dart.dev/get-dart)
- [Android Studio](https://developer.android.com/studio) or [Visual Studio Code](https://code.visualstudio.com/)

### Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/chirag640/flutter_todo_app.git
   cd flutter_todo_app
   ```

2. Install dependencies:
    ```bash
    flutter pub get
    ```
3. Run the app:
    ```bash
    flutter run
    ```

### Project Structure
```bash
lib/
├── constants/
│   └── colors.dart
├── database/
│   └── database_helper.dart
├── model/
│   └── todo.dart
│   └── user.dart
├── provider/
│   └── theme_provider.dart
├── screens/
│   └── home.dart
│   └── login.dart
│   └── register.dart
│   └── settings.dart
├── widgets/
│   └── todo_items.dart
└── main.dart
```
## Usage

#### User Authentication

- Register a new user.
- Login with the registered user credentials.
- The app will remember the last logged-in user and automatically log them in when the app is reopened.
#### Managing Todos
- Add a new todo by entering the task in the input field and pressing the add button.
- Update a todo by tapping on it to mark it as completed or not completed.
- Delete a todo by pressing the delete button next to the task.
- Search for todos using the search bar.
#### Theming
- Toggle between dark and light themes in the settings screen.

### Contributing
- Contributions are welcome! Please open an issue or submit a
pull request for any improvements or bug fixes.