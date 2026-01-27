Smart Ride Booking & Trip Management App

A Flutter-based ride booking simulation app inspired by platforms like Ola/Uber.
The app demonstrates real-time state updates, offline persistence, analytics, and clean architecture using Flutter + Riverpod + Hive.

📱 Features Overview
🏠 Dashboard

Total trips completed

Total amount spent

Recent trips (latest first)

Ride-type based analytics (Mini, Sedan, Auto, Bike)

Live updates when trips change status

Spending limit alerts

🚗 Trip Booking & Management

Add, view, and delete trips

Pickup & drop locations

Ride type selection

Fare calculated automatically

Date & time tracking

Offline persistence using Hive

Swipe-to-delete with undo (bonus)

🔄 Real-Time Ride Simulation

Automatic status progression:

Requested → Driver Assigned → Ride Started → Completed

Simulated delays using timers

State-driven UI updates (no manual refresh)

📍 Driver Tracking (Mocked)

Animated progress bar

Moving car icon illusion

ETA countdown updating every few seconds

No maps required (lightweight simulation)

💰 Spending Limits

Monthly spending limits per ride type

Color-coded warnings when approaching limits

Real-time recalculation when rides complete

Persisted locally using Hive

🔔 In-App Notifications

Snackbars triggered automatically on:

Driver assigned

Ride started

Ride completed

Notifications driven purely by state changes

🧠 Architecture

The app follows Clean Architecture principles:

lib/
│
├── core/              # Constants, enums, shared utils
│
├── data/              # Hive models & repositories
│
├── models/            # Domain models
│
├── state/             # Riverpod StateNotifiers
│
├── ui/                # Screens & widgets
│
├── tests/             # Unit & widget tests
│
└── main.dart

State Management

Riverpod (StateNotifier)

Centralized business logic

Reactive UI updates

Test-friendly design

💾 Local Storage

Hive for offline persistence

Trips and spending limits are restored on app restart

Enum adapters used for ride type and trip status

🧪 Testing
Unit Tests Included

Trip CRUD operations

Real-time trip lifecycle transitions

Spending limit calculations

Dashboard aggregation logic

Driver tracking state updates

Run Tests
flutter test

🚀 Getting Started
Prerequisites

Flutter 3.x+

Dart

Android Studio / VS Code

Setup
git clone <repo-url>
cd smart_ride
flutter pub get
flutter run