# 🎬 Movie App

A beautiful and modern Flutter application that allows users to browse, search, and discover movies using The Movie Database (TMDB) API. Built with clean architecture principles and modern state management.

![Flutter](https://img.shields.io/badge/Flutter-3.8.1+-02569B?style=flat&logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.8.1+-0175C2?style=flat&logo=dart)
![License](https://img.shields.io/badge/license-MIT-green)

## ✨ Features

- 🎥 **Browse Popular Movies** - Discover trending and popular movies
- 🔜 **Upcoming Movies** - Stay updated with upcoming releases
- 🔍 **Search Functionality** - Search for your favorite movies
- ♾️ **Infinite Scrolling** - Seamlessly load more movies as you scroll
- 🎨 **Dynamic Background** - Movie poster backgrounds with blur effects
- ⭐ **Movie Details** - View ratings, descriptions, and release dates
- 📱 **Responsive Design** - Beautiful UI that works on all screen sizes
- 🌙 **Dark Theme** - Eye-friendly dark interface

## 📸 Screenshots

> Add your app screenshots here

## 🏗️ Architecture

This project follows **Clean Architecture** principles with the following structure:

```
lib/
├── main.dart                  # App entry point
├── controllers/               # State management controllers
│   └── main_page_data_controller.dart
├── models/                    # Data models
│   ├── app_config.dart
│   ├── main_page_data.dart
│   ├── movie.dart
│   └── search_category.dart
├── pages/                     # UI screens
│   ├── main_page.dart
│   └── splash_page.dart
├── services/                  # API and business logic
│   ├── http_service.dart
│   └── movie_service.dart
└── widgets/                   # Reusable UI components
    └── movie_tile.dart
```

## 🛠️ Tech Stack

- **Framework**: [Flutter](https://flutter.dev/) 3.8.1+
- **Language**: [Dart](https://dart.dev/) 3.8.1+
- **State Management**: [Riverpod](https://riverpod.dev/) 2.6.1
- **Dependency Injection**: [GetIt](https://pub.dev/packages/get_it) 8.2.0
- **HTTP Client**: [Dio](https://pub.dev/packages/dio) 5.9.0
- **API**: [The Movie Database (TMDB)](https://www.themoviedb.org/documentation/api)

## 🚀 Getting Started

### Prerequisites

- Flutter SDK 3.8.1 or higher
- Dart SDK 3.8.1 or higher
- Android Studio / VS Code with Flutter extensions
- TMDB API Key (free from [TMDB](https://www.themoviedb.org/settings/api))

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/ImalkaDilakshan99/Movie-app.git
   cd movie_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure API Key**
   
   Update the `assets/config/main.json` file with your TMDB API key:
   ```json
   {
     "API_KEY": "YOUR_TMDB_API_KEY_HERE",
     "BASE_API_URL": "https://api.themoviedb.org/3",
     "BASE_IMAGE_API_URL": "https://image.tmdb.org/t/p/original"
   }
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

## 📱 Supported Platforms

- ✅ Android
- ✅ iOS
- ✅ Web
- ✅ Windows
- ✅ macOS
- ✅ Linux

## 🔑 Getting TMDB API Key

1. Create an account at [TMDB](https://www.themoviedb.org/signup)
2. Go to Settings → API
3. Request an API key (free)
4. Copy your API key to `assets/config/main.json`

## 📦 Dependencies

```yaml
dependencies:
  flutter_riverpod: ^2.6.1    # State management
  dio: ^5.9.0                 # HTTP client
  get_it: ^8.2.0              # Dependency injection
  cupertino_icons: ^1.0.8     # iOS icons
```

## 🎨 Key Features Implementation

### State Management (Riverpod)
- Uses `StateNotifierProvider` for managing app state
- Reactive UI updates based on state changes
- Clean separation of business logic and UI

### API Integration
- Fetches data from TMDB API
- Supports popular movies, upcoming movies, and search
- Pagination for efficient data loading

### UI/UX
- Dynamic background with blur effects
- Smooth infinite scrolling
- Search with real-time results
- Category filtering (Popular/Upcoming)

## 🤝 Contributing

Contributions are welcome! Feel free to open issues and pull requests.

1. Fork the project
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Author

**Imalka Dilakshan**
- GitHub: [@ImalkaDilakshan99](https://github.com/ImalkaDilakshan99)

## 🙏 Acknowledgments

- [The Movie Database (TMDB)](https://www.themoviedb.org/) for providing the API
- [Flutter](https://flutter.dev/) team for the amazing framework
- [Riverpod](https://riverpod.dev/) for state management

## 📧 Contact

For any queries or suggestions, feel free to reach out!

---

⭐ If you like this project, please give it a star on GitHub!
