# Hamsafar

<div align="center">

# هم‌سفر | Hamsafar

**A trip coordination and management application for small group trips**

Plan together. Coordinate together. Travel together.

[![Flutter](https://img.shields.io/badge/Flutter-3.x-blue?logo=flutter)](https://flutter.dev/)
[![Dart](https://img.shields.io/badge/Dart-3.12.2-blue?logo=dart)](https://dart.dev/)
[![Supabase](https://img.shields.io/badge/Backend-Supabase-3ECF8E?logo=supabase)](https://supabase.com/)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

</div>

---

## 📖 About

**Hamsafar (هم‌سفر)** is a Flutter application designed to simplify planning and coordinating short trips with friends.

The idea behind Hamsafar is simple:

> A group trip should be organized before it starts, not while everyone is already asking what to do next.

Hamsafar brings the important parts of a group trip into one shared space:

- Finding a suitable time for everyone
- Coordinating departure time
- Inviting and managing trip members
- Managing things that members will bring
- Defining trip rules
- Assigning responsibilities
- Managing shared expenses
- Tracking each member's financial share
- Keeping trip information accessible to the whole group

The project is being developed as a **real-world Flutter application**, with a focus on maintainable architecture, clear separation of responsibilities, and a backend that can support real-time group coordination.

---

# 🎯 Project Goals

Hamsafar aims to solve the coordination problems that usually appear before and during a group trip.

### Before the trip

- Create a trip
- Invite friends
- Define the trip schedule
- Coordinate available dates and times
- Decide on the departure time
- Define group rules
- Decide what should be brought
- Assign responsibilities
- Set up the trip budget

### During the trip

- View trip information
- See members and their roles/status
- Track responsibilities
- Track shared expenses
- See each member's financial status
- Keep important trip information in one place

### After the trip

The application is designed so that future versions can also support:

- Final expense settlement
- Trip history
- Expense summaries
- Member contribution history
- Trip statistics

---

# ✨ Core Features

## 👤 Authentication

Hamsafar uses Supabase Authentication as the planned backend authentication layer.

Current architecture includes:

- Sign up
- Login
- Current-user retrieval
- Authentication state management
- Repository abstraction
- Supabase remote data source

The authentication layer follows a separation between:

```text
Presentation
     ↓
Use Case
     ↓
Repository
     ↓
Remote Data Source
     ↓
Supabase
```

---

## 🏠 Home

The Home feature acts as the main entry point after authentication.

It is intended to provide quick access to:

- Current trips
- Upcoming trips
- Important trip information
- Main application sections

The Home feature is currently primarily part of the application UI structure and will become more data-driven as backend functionality is completed.

---

## 🧳 Trips

The Trips module is responsible for the user's trip collection and trip-level navigation.

Current structure includes:

- Trips page
- Trip search
- Trip details
- Trip members section
- Trip rules section
- Trip summary
- Member status concepts
- Member rules concepts

The intended flow is:

```text
Trips
  │
  ├── Search
  │
  ├── Trip
  │    ├── Summary
  │    ├── Members
  │    ├── Rules
  │    ├── Budget
  │    ├── Tasks
  │    └── Coordination
  │
  └── Create Trip
```

---

# 🛠️ Trip Creation

Creating a trip is designed as a multi-step process rather than a single large form.

Current creation flow contains dedicated sections for:

1. Common trip information
2. Schedule setup
3. Expense setup
4. Trip rules
5. Member invitations
6. Creation success

The current implementation also includes:

- Stepper state management
- Trip date coordination state
- Member type concepts
- Date/time options
- Invitation code UI
- Rule configuration UI

Conceptually:

```text
Create Trip
     │
     ├── Basic Information
     │
     ├── Schedule
     │
     ├── Expenses
     │
     ├── Rules
     │
     ├── Invite Members
     │
     └── Finish
```

The exact business logic and persistence layer will be expanded as backend development progresses.

---

# 🗳️ Trip Coordination

Trip Coordination is one of the main concepts of Hamsafar.

Its purpose is to allow trip members to collectively make decisions instead of relying on separate messaging conversations.

Current coordination areas include:

### 🕐 Departure Time Voting

Members can vote on proposed departure times.

This allows the group to determine a suitable departure time based on member availability.

### 💰 Budget

The budget section is designed to manage:

- Trip expenses
- Expense totals
- Member shares
- Payment status
- Financial summaries

### ✅ Tasks

Responsibilities can be assigned to members before the trip.

Examples:

- Buy food
- Bring camping equipment
- Prepare transportation
- Bring cooking equipment

### 📋 Rules

Groups can define shared rules for a specific trip.

Rules belong to the trip rather than being global application settings.

---

# 👥 Friends

The Friends module is responsible for managing relationships between users inside Hamsafar.

The planned system can support:

- Finding users
- Sending friend requests
- Accepting/rejecting requests
- Managing friends
- Selecting friends while creating a trip
- Inviting friends to trips

The current project already contains the Friends feature structure and related presentation state.

---

# 👤 Profile

The Profile feature manages user-specific information.

The current architecture includes separate:

- Data layer
- Domain layer
- Presentation layer

It also contains:

- Profile state management
- Profile editing
- Remote profile data source
- Profile repository
- Edit-profile use case

This separation makes it possible to connect the profile UI to Supabase without coupling the UI directly to the backend.

---

# ⚙️ Settings

The Settings section is responsible for application-level preferences.

Current UI includes:

- Settings page
- Reusable settings tiles
- Settings footer
- Bug reporting page

Future settings can include:

- Language
- Theme
- Notifications
- Account settings
- Privacy
- About Hamsafar

---

# 🚀 Splash & Application Entry

Hamsafar contains a dedicated Splash feature.

The application startup flow is designed around:

```text
Application Start
       │
       ▼
   Load .env
       │
       ▼
Initialize Supabase
       │
       ▼
Initialize Dependency Injection
       │
       ▼
     Run App
       │
       ▼
     Router
       │
       ├── Authentication
       │
       └── Main Application
```

---

# 🏗️ Architecture

Hamsafar uses a **feature-first architecture**.

The project is organized around application features rather than grouping every page, widget, and service into global folders.

At a high level:

```text
lib/
│
├── core/
│
├── features/
│   ├── auth/
│   ├── friends/
│   ├── home/
│   ├── main_wrapper/
│   ├── profile/
│   ├── settings/
│   ├── splash/
│   ├── trip_coordination/
│   ├── trip_creation/
│   └── trips/
│
├── assets/
│
├── locator.dart
└── main.dart
```

---

# 🧱 Core Layer

The `core` directory contains functionality shared across multiple features.

```text
core/
├── enums/
├── extensions/
├── params/
├── resources/
├── router/
├── theme/
├── usecase/
├── utils/
└── widgets/
```

### `enums/`

Shared enumerations used by multiple parts of the application.

Examples include:

- Avatar types
- Badge types
- Button types
- Note types
- Snack-bar types

### `extensions/`

Reusable Dart and Flutter extensions.

Examples include:

- Badge extensions
- Snack-bar extensions
- Theme extensions

### `params/`

Shared parameter objects used by use cases and application logic.

### `resources/`

Shared application resources and constants.

### `router/`

Central navigation and route configuration using GoRouter.

### `theme/`

Application-wide visual configuration.

Hamsafar supports:

- Light theme
- Dark theme
- System theme detection

### `usecase/`

Base/shared use-case abstractions.

### `utils/`

General-purpose utilities that are not specific to a single feature.

### `widgets/`

Reusable UI components shared between multiple features.

This is intentionally different from feature-specific widgets.

A widget belongs in `core/widgets` when its responsibility is genuinely application-wide and it does not depend on one particular feature.

---

# 🧩 Feature Architecture

Features that require more complex business logic follow a layered structure.

For example:

```text
auth/
├── data/
├── domain/
└── presentation/
```

## Data

Responsible for external data access.

Examples:

- Remote data sources
- Repository implementations
- API/backend communication

## Domain

Contains business-facing abstractions.

Examples:

- Repository interfaces
- Use cases
- Domain models

## Presentation

Responsible for the UI and state management.

Examples:

- Pages
- Widgets
- BLoCs
- Cubits

Conceptually:

```text
┌─────────────────────────────┐
│        Presentation         │
│ Pages / Widgets / BLoC      │
└──────────────┬──────────────┘
               │
               ▼
┌─────────────────────────────┐
│           Domain            │
│ Use Cases / Repositories    │
└──────────────┬──────────────┘
               │
               ▼
┌─────────────────────────────┐
│            Data             │
│ Data Sources / Repositories │
└──────────────┬──────────────┘
               │
               ▼
┌─────────────────────────────┐
│          Supabase           │
└─────────────────────────────┘
```

Not every feature currently requires all three layers. The architecture is being introduced where the feature has meaningful business/data responsibilities.

---

# 🔄 State Management

Hamsafar uses **BLoC/Cubit** for state management.

Main technologies:

- `bloc`
- `flutter_bloc`

Examples currently present in the project include:

- `AuthBloc`
- `ProfileBloc`
- `BottomNavCubit`
- `FriendsTabBarCubit`
- `TripStepperCubit`
- `TripDateCoordinationCubit`

The goal is to keep UI rendering separate from application state and business operations.

---

# 💉 Dependency Injection

Dependency injection is handled using **GetIt**.

The central service locator is:

```text
lib/locator.dart
```

Current dependency graph includes:

```text
SupabaseClient
      │
      ├── SupabaseAuthDatasource
      │        │
      │        ▼
      │   AuthRepository
      │        │
      │        ├── LoginUsecase
      │        ├── SignUpUsecase
      │        └── GetCurrentUserUsecase
      │
      └── SupabaseProfileDatasource
               │
               ▼
        ProfileRepository
               │
               ▼
        EditProfileUsecase
```

This makes backend implementations replaceable without forcing UI code to know how data is retrieved.

---

# 🧭 Navigation

Hamsafar uses **GoRouter** for application navigation.

The routing layer is centralized inside:

```text
lib/core/router/
```

The intended navigation model separates:

```text
Authentication Routes
        │
        ▼
Main Application
        │
        ├── Home
        ├── Trips
        ├── Friends
        ├── Profile
        └── Settings

Trip-specific routes
        │
        ├── Trip Details
        ├── Trip Creation
        └── Trip Coordination
```

---

# 🎨 UI & Design System

The application is designed with a reusable component approach.

Instead of implementing repeated UI directly inside pages, reusable widgets are extracted where appropriate.

The project contains shared components for concepts such as:

- Tiles
- Cards
- Buttons
- Inputs
- Member displays
- Trip summaries
- Budget summaries
- Voting options
- Rules
- Tasks

The architecture is intentionally evolving as repeated components are identified and consolidated.

---

# 🌐 Localization

Hamsafar is prepared for multilingual UI.

Currently supported locales:

- Persian (`fa`)
- English (`en`)

Persian is currently the default application locale.

The application also uses **Vazirmatn** as its primary Persian-compatible font family.

Available font weights include:

```text
300  Light
400  Regular
500  Medium
600  SemiBold
700  Bold
800  ExtraBold
900  Black
```

---

# 📱 Responsive UI

The application uses `flutter_screenutil`.

The current design baseline is:

```text
375 × 812
```

This allows UI dimensions to scale across different device sizes while maintaining the intended visual proportions.

---

# ☁️ Backend

Hamsafar is being integrated with **Supabase** as its backend platform.

Current project dependencies include:

- `supabase_flutter`
- `dio`
- `flutter_dotenv`

Supabase is currently used for the authentication/profile data architecture.

The backend is expected to eventually handle:

```text
Authentication
     │
     ├── Users
     │
     ├── Profiles
     │
     ├── Friends
     │
     ├── Trips
     │
     ├── Trip Members
     │
     ├── Schedules
     │
     ├── Votes
     │
     ├── Rules
     │
     ├── Tasks
     │
     ├── Expenses
     │
     └── Payments
```

The database structure and Row Level Security policies will be developed alongside the application business logic.

---

# 🔐 Security

Sensitive configuration should not be committed directly to the repository.

Hamsafar loads environment configuration through:

```text
.env
```

Example:

```env
SUPABASE_URL=your-project-url
SUPABASE_ANON_KEY=your-publishable-key
```

> Never commit private secrets, service-role keys, database passwords, or other privileged credentials to Git.

For Supabase, database access should be protected using **Row Level Security (RLS)**.

The intended security model is:

```text
User
 │
 ▼
Authentication
 │
 ▼
Authenticated Session
 │
 ▼
RLS Policies
 │
 ▼
Allowed Records
```

The client application should never be treated as a trusted environment.

---

# 🧠 Business Logic Philosophy

Hamsafar is not intended to be just a collection of UI screens.

The goal is to build a coherent application flow where:

- A user has an identity
- Users can have relationships
- Friends can become trip members
- Trips have their own lifecycle
- Trip members have permissions/statuses
- Group decisions can be coordinated
- Expenses belong to trips
- Responsibilities can belong to members
- Rules belong to individual trips
- Important state is persisted remotely

Business logic should live outside widgets whenever possible.

The UI should represent application state rather than become the place where business rules are implemented.

---

# 🧪 Testing

The project uses Flutter's testing framework.

Run tests with:

```bash
flutter test
```

As business logic is added, testing will expand toward:

```text
Unit Tests
    │
    ├── Use Cases
    ├── Repositories
    └── Business Rules

Widget Tests
    │
    ├── Forms
    ├── Pages
    └── Reusable Components

Integration Tests
    │
    └── Complete User Flows
```

---

# 🛠️ Tech Stack

| Area | Technology |
|---|---|
| Framework | Flutter |
| Language | Dart |
| State Management | BLoC / Cubit |
| Navigation | GoRouter |
| Dependency Injection | GetIt |
| Backend | Supabase |
| Authentication | Supabase Auth |
| HTTP Client | Dio |
| Local Storage | GetStorage |
| Environment Configuration | flutter_dotenv |
| Equality | Equatable |
| Responsive UI | flutter_screenutil |
| Localization | Flutter Localizations |
| Icons | Lucide Icons |
| Font | Vazirmatn |
| Testing | Flutter Test |

---

# 📦 Main Dependencies

### State Management

```yaml
bloc
flutter_bloc
```

### Backend & Networking

```yaml
supabase_flutter
dio
```

### Architecture

```yaml
get_it
equatable
```

### Navigation

```yaml
go_router
```

### Local Configuration & Storage

```yaml
flutter_dotenv
get_storage
```

### UI

```yaml
flutter_screenutil
lucide_icons_flutter
cupertino_icons
```

### Localization

```yaml
flutter_localization
flutter_localizations
```

---

# 📂 Project Structure

A simplified view of the current repository:

```text
hamsafar/
│
├── android/
│
├── lib/
│   │
│   ├── assets/
│   │   ├── fonts/
│   │   └── images/
│   │
│   ├── core/
│   │   ├── enums/
│   │   ├── extensions/
│   │   ├── params/
│   │   ├── resources/
│   │   ├── router/
│   │   ├── theme/
│   │   ├── usecase/
│   │   ├── utils/
│   │   └── widgets/
│   │
│   ├── features/
│   │   │
│   │   ├── auth/
│   │   │   ├── data/
│   │   │   ├── domain/
│   │   │   └── presentation/
│   │   │
│   │   ├── friends/
│   │   │   ├── enums/
│   │   │   └── presentation/
│   │   │
│   │   ├── home/
│   │   │   └── presentation/
│   │   │
│   │   ├── main_wrapper/
│   │   │   └── presentation/
│   │   │
│   │   ├── profile/
│   │   │   ├── data/
│   │   │   ├── domain/
│   │   │   └── presentation/
│   │   │
│   │   ├── settings/
│   │   │   └── presentation/
│   │   │
│   │   ├── splash/
│   │   │   └── presentation/
│   │   │
│   │   ├── trip_coordination/
│   │   │   ├── enums/
│   │   │   └── presentation/
│   │   │
│   │   ├── trip_creation/
│   │   │   ├── enums/
│   │   │   └── presentation/
│   │   │
│   │   └── trips/
│   │       ├── enums/
│   │       └── presentation/
│   │
│   ├── locator.dart
│   └── main.dart
│
├── test/
│
├── android/
│
├── .env
├── analysis_options.yaml
├── pubspec.yaml
├── pubspec.lock
├── LICENSE
└── README.md
```

---

# 🚀 Getting Started

## Requirements

Install:

- Flutter SDK
- Dart SDK
- Android Studio or VS Code
- Android SDK for Android development
- Xcode for iOS development

The repository currently targets Dart `3.12.2` or compatible SDK versions according to `pubspec.yaml`.

---

## 1. Clone

```bash
git clone https://github.com/AminSources/hamsafar.git
cd hamsafar
```

---

## 2. Install Dependencies

```bash
flutter pub get
```

---

## 3. Configure Environment

Create a `.env` file in the project root:

```env
SUPABASE_URL=your-supabase-project-url
SUPABASE_ANON_KEY=your-supabase-publishable-key
```

Do not commit private credentials.

---

## 4. Run

```bash
flutter run
```

---

# 🧹 Code Quality

Before submitting changes, it is recommended to run:

```bash
flutter analyze
```

and:

```bash
flutter test
```

Code should follow the project's existing architecture and naming conventions.

When adding a new feature, prefer:

```text
features/
└── feature_name/
    ├── data/
    ├── domain/
    └── presentation/
```

when the feature requires a meaningful domain/data layer.

Shared components should only be moved into `core` when they are genuinely reusable across multiple features.

---

# 🤝 Contributing

Contributions, suggestions, bug reports, and architectural discussions are welcome.

For significant changes:

1. Open an issue first.
2. Explain the problem or proposed change.
3. Keep changes focused.
4. Follow the existing architecture.
5. Avoid introducing feature-specific logic into `core`.
6. Add tests when introducing important business logic.
7. Submit a Pull Request with a clear description.

---

# 📌 Current Project Status

Hamsafar is currently in active development.

The application has a substantial UI and architectural foundation, while backend integration and complete business logic are still being developed.

### Current focus

```text
UI Foundation
      ↓
Architecture
      ↓
Authentication
      ↓
Supabase Integration
      ↓
Data Model
      ↓
Trip Business Logic
      ↓
Real-time Coordination
      ↓
Production Hardening
```

The repository should therefore be considered a **development-stage project**, not a finished production application.

---

# 📜 License

Hamsafar is released under the **MIT License**.

See [LICENSE](LICENSE) for the complete license text.

The MIT License permits use, modification, and distribution of the source code according to its terms.

However, the **Hamsafar name and branding are project identifiers** and should not be used to represent an unofficial derivative as the official Hamsafar application.

---

# 👨‍💻 Project

**Hamsafar / هم‌سفر**

Repository:

https://github.com/AminSources/hamsafar

Built with:

**Flutter + Dart + BLoC + Supabase**

---

# 👨‍💻 About the Developer

Hamsafar is an independent project designed and developed by **Amin**.

I'm a software development enthusiast focused on **Flutter, Dart, backend development, and software architecture**. Hamsafar is one of my projects for turning ideas into real, maintainable applications while continuously learning and improving my development skills.

### 🌐 Find Me

<p align="center">
  <a href="https://github.com/AminSources">
    <img src="https://cdn.simpleicons.org/github/181717" width="32" alt="GitHub" />
  </a>
  &nbsp;&nbsp;&nbsp;
  <a href="https://t.me/YOUR_TELEGRAM_ID">
    <img src="https://cdn.simpleicons.org/telegram/26A5E4" width="32" alt="Telegram" />
  </a>
  &nbsp;&nbsp;&nbsp;
  <a href="https://instagram.com/YOUR_INSTAGRAM_ID">
    <img src="https://cdn.simpleicons.org/instagram/E4405F" width="32" alt="Instagram" />
  </a>
</p>

> 💬 Feel free to reach out for questions, suggestions, collaboration, or just to talk about software development.


<div align="center">

### Hamsafar

**Make the trip easier before the journey begins.**

</div>
