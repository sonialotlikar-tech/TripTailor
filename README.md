# 🌍 Smart Travel Companion & Tour Guide App
### Mobile Application Development (MAD) Project

A self-contained, offline-first cross-platform mobile application built using **Flutter and Dart**. Designed without requiring Docker, external backend microservices, or complex database setups.

---

## 📱 Features

- **Explore Destinations**:
  - Live real-time search across place name, city, and country.
  - Horizontal category filter chips (`All`, `Beaches`, `Mountains`, `Historical`, `Adventure`, `City Life`).
  - Rich destination cards with photos, ratings, price per day, badges, and category tags.
- **Destination Details & Highlights**:
  - `SliverAppBar` with dynamic hero image transitions and collapsible header.
  - Location tag, rating counter with review counts, cost estimation, and key highlights list.
  - One-tap **"Plan This Trip"** modal with integrated date range picker and cost calculator.
- **Favorites Management**:
  - Add/remove destinations to favorites with visual heart icon toggle and animated `SnackBar` with **UNDO** support.
  - Dedicated **Favorites** tab with dynamic badge count badge on navigation bar.
- **Trip & Itinerary Planner**:
  - Interactive dialog with `showDateRangePicker` to schedule travel dates.
  - Select any destination, calculate duration, estimate budget, and add custom travel notes.
  - Real-time plan list with delete capability and confirmation dialog.
- **Modern Material 3 Design**:
  - Light Mode and Dark Mode toggle button directly in the AppBar.
  - Responsive layout adapting to phones (list view), tablets, and web browsers (responsive multi-column grid).

---

## 🏗️ Project Architecture

```
travel_guide_app/
├── lib/
│   ├── data/
│   │   ├── app_state.dart                 # Centralized reactive ChangeNotifier state manager
│   │   └── sample_data.dart               # Curated offline destination dataset
│   ├── models/
│   │   └── destination.dart               # Destination & Itinerary data models
│   ├── screens/
│   │   ├── destination_detail_screen.dart # Collapsible Sliver details view & planner modal
│   │   ├── favorites_screen.dart          # Saved favorites screen & empty state
│   │   ├── home_screen.dart               # Search bar, category filter chips & responsive cards
│   │   └── itinerary_screen.dart          # Trip planner screen, scheduled trips & modal
│   ├── widgets/
│   │   └── destination_card.dart          # Reusable custom card widget with Hero & badges
│   └── main.dart                          # App entry point, M3 themes & navigation bar
├── web/
│   ├── index.html                         # Web entry point
│   └── manifest.json                      # Web app manifest
├── pubspec.yaml                           # Flutter dependencies and assets
└── README.md
```

---

## 🚀 How to Run (Without Docker)

### Step 1: Install Flutter (If not already installed)
1. Download Flutter SDK from [flutter.dev](https://docs.flutter.dev/get-started/install/windows/mobile).
2. Extract to `C:\src\flutter`.
3. Add `C:\src\flutter\bin` to your system environment `PATH`.

### Step 2: Open and Run
1. Open the `travel_guide_app` folder in **VS Code** or **Android Studio**:
   ```bash
   cd travel_guide_app
   ```
2. Resolve packages:
   ```bash
   flutter pub get
   ```
3. Choose your device:
   - **Chrome (Fastest for testing)**:
     ```bash
     flutter run -d chrome
     ```
   - **Android Emulator**:
     Start any emulator from Android Studio, then run:
     ```bash
     flutter run
     ```
   - **Physical Android Device**:
     Connect your phone via USB with USB Debugging enabled, then run:
     ```bash
     flutter run
     ```

---

## 💡 Technical Highlights
- **Zero External Dependencies**: Built entirely using Flutter's built-in Material 3 widgets and `ChangeNotifier` state management, ensuring lightning-fast setup with no external server or database overhead.
- **Offline-First**: Bundled with rich destinations, preloaded itineraries, and persistent in-memory session state.
