# Hamsafar - Travel Companion App

<div align="center">

![Flutter](https://img.shields.io/badge/Flutter-3.12.2-blue?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.12.2-blue?logo=dart)
![License](https://img.shields.io/badge/license-MIT-green)

**Your ultimate travel companion for planning and coordinating trips with friends**

</div>

## 📱 About

Hamsafar (همسفر) is a modern Flutter mobile application designed to make travel planning and coordination seamless. The app helps users create trips, coordinate with friends, and manage all their travel plans in one place.

## ✨ Features

### Core Features
- **🚀 Trip Management** - Create, view, and manage your trips
- **👥 Friends & Social** - Connect with friends and plan trips together
- **📅 Trip Coordination** - Coordinate dates and details with travel companions
- **🎨 Beautiful UI** - Modern design with both light and dark themes
- **🌍 Multi-language Support** - Available in Persian (Farsi) and English
- **📱 Responsive Design** - Adapts to different screen sizes using ScreenUtil

### Feature Modules
- **Authentication** - Secure user authentication flow
- **Splash Screen** - Engaging app entry experience
- **Home** - Main dashboard and navigation
- **Trips** - View and manage all your trips
- **Trip Creation** - Step-by-step trip creation wizard
- **Trip Coordination** - Coordinate trip details with friends
- **Friends** - Manage your friend list
- **Profile** - User profile management
- **Settings** - App customization and preferences

## 🏗️ Architecture

Hamsafar follows a **feature-first architecture** with clean separation of concerns:

```
lib/
├── core/           # Core functionality (routing, theme, cubits)
├── features/       # Feature modules
│   ├── auth_feature/
│   ├── friends_feature/
│   ├── home_feature/
│   ├── trip_creation_feature/
│   ├── trip_coordination_feature/
│   ├── trips_feature/
│   ├── profile_feature/
│   ├── settings_feature/
│   └── splash_feature/
├── assets/         # Images and fonts
├── main.dart       # App entry point
└── locator.dart    # Dependency injection setup
```

### State Management
- **BLoC Pattern** - Predictable state management using `flutter_bloc`
- **Dependency Injection** - Service locator pattern with `get_it`

### Navigation
- **GoRouter** - Declarative routing with deep linking support

## 🛠️ Tech Stack

| Category | Technology |
|----------|------------|
| **Framework** | Flutter 3.12.2+ |
| **Language** | Dart 3.12.2+ |
| **State Management** | BLoC / flutter_bloc |
| **Navigation** | GoRouter |
| **Dependency Injection** | GetIt |
| **Network** | Dio |
| **Local Storage** | get_storage |
| **UI Components** | Material UI, Cupertino UI |
| **Icons** | Lucide Icons, Material Icons |
| **Responsive** | flutter_screenutil |
| **Localization** | flutter_localizations |

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (>= 3.12.2)
- Dart SDK (>= 3.12.2)
- Android Studio / VS Code
- Xcode (for iOS development)

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd hamsafar
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### Configuration

The app comes pre-configured with:
- Custom Vazirmatn font family for Persian text support
- Image assets in `lib/assets/images/`
- Default locale set to Persian (fa)

## 📦 Dependencies

### Production Dependencies
- `bloc` & `flutter_bloc` - State management
- `dio` - HTTP client
- `go_router` - Navigation and routing
- `get_it` & `get_storage` - DI and local storage
- `equatable` - Value equality
- `flutter_screenutil` - Responsive UI
- `lucide_icons_flutter` - Icon library
- `material_ui` & `cupertino_ui` - UI components

### Development Dependencies
- `flutter_lints` - Linting rules
- `flutter_test` - Testing framework

## 🎨 Theming

The app supports both light and dark themes with automatic system theme detection:

```dart
theme: AppTheme.light,
darkTheme: AppTheme.dark,
themeMode: ThemeMode.system,
```

## 🌐 Localization

Currently supported languages:
- 🇮🇷 Persian (Farsi) - Default
- 🇬🇧 English

## 📁 Project Structure

```
hamsafar/
├── android/          # Android-specific files
├── lib/
│   ├── assets/       # Fonts and images
│   ├── core/         # Shared components
│   │   ├── cubit/    # Global BLoCs
│   │   ├── router/   # App routing configuration
│   │   └── theme/    # App themes
│   ├── features/     # Feature modules
│   ├── main.dart     # Entry point
│   └── locator.dart  # Service locator
├── test/             # Unit and widget tests
├── pubspec.yaml      # Dependencies
└── README.md         # This file
```

## 🧪 Testing

Run tests with:
```bash
flutter test
```

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📄 License

This project is licensed under the MIT License.

## 👥 Team

Built with ❤️ using Flutter

---

<div align="center">

**Hamsafar** - Your journey, our priority

[Report Issue](link) · [Request Feature](link)

</div>
