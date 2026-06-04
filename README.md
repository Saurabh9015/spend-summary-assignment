# Spend Summary — Flutter Take-Home

A mobile-first **Spend Summary** screen built with **Flutter** and **Material 3**, using mock data only. Designed as a recruiter-ready take-home assignment with a modern fintech UI, subtle animations, and clean layered structure.

## Project Overview

This app presents a single **Spend Summary** experience: monthly spend overview, category breakdown, spending insights, recent transactions, and quick actions via a floating action button. All data is hardcoded—no backend or persistence.

## Features

- **Premium header card** — Gradient hero card with monthly spend, % change vs last month, and sparkline-style analytics
- **Spending insights** — Top category and highest transaction derived from mock data
- **Category carousel** — Horizontally scrollable category cards with icons and amounts
- **Recent transactions** — Seven mock transactions with improved hierarchy and styling
- **FAB + bottom sheet** — Add Expense / Add Income options (UI demo only)
- **Dark mode** — `ThemeMode.system` by default; in-app light/dark toggle
- **Animations** — Subtle fade/slide on header, categories, and transactions
- **Pull to refresh** — Simulated 1s refresh with success feedback
- **App bar actions** — Search (demo) and theme toggle

## Architecture

Simple, assignment-friendly layering (no over-engineering):

| Layer | Responsibility |
|-------|----------------|
| **models/** | Plain data classes (`CategoryModel`, `TransactionModel`) |
| **data/** | Mock data and computed insights |
| **theme/** | Material 3 light & dark themes |
| **screens/** | Screen layout and orchestration |
| **widgets/** | Reusable UI components |
| **utils/** | Formatting helpers |
| **core/constants/** | Shared spacing and layout values |

Data flows **top-down**: `DummyData` → widgets. The screen is the only `StatefulWidget` (refresh, animation keys, theme callbacks).

## Folder Structure

```
lib/
├── main.dart
├── core/
│   └── constants/
│       └── app_layout.dart
├── models/
│   ├── category_model.dart
│   └── transaction_model.dart
├── data/
│   └── dummy_data.dart
├── theme/
│   └── app_theme.dart
├── utils/
│   └── format_utils.dart
├── screens/
│   └── spend_summary_screen.dart
└── widgets/
    ├── spend_header_card.dart
    ├── spending_insights_card.dart
    ├── category_item.dart
    ├── transaction_tile.dart
    ├── staggered_fade_in.dart
    └── add_transaction_sheet.dart

assets/
└── screenshots/          # Add emulator screenshots here
```

## Screenshots

Add emulator screenshots to `assets/screenshots/` before submission, for example:

- `spend_summary_light.png`
- `spend_summary_dark.png`
- `bottom_sheet.png`

## Run Instructions

### Prerequisites

- Flutter SDK (3.10+)
- Android Studio / VS Code with Flutter extension, or Xcode for iOS

### Setup & run

```bash
cd spend_summary_assignment
flutter pub get
flutter run
```

### Tests & analysis

```bash
flutter analyze
flutter test
```

## AI Tools Used

| Tool | How it was used |
|------|-----------------|
| **Cursor** | Primary IDE agent for architecture, widget implementation, theming, and refactors |
| **ChatGPT** | Requirements analysis, UI/UX feedback, and documentation review |

**All generated code was reviewed, modified, and tested manually.**

---

Built for a Flutter take-home assignment. Mock data only — no API integration.
