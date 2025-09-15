# GitPeek

GitPeek is an iOS app for searching and viewing GitHub user profiles.

## Features
- Search for any GitHub user by username
- View profile details: avatar, name, login, bio, public repos, followers
- Elegant UI with blur effects and gradients
- Robust error handling for empty input, user not found, network errors, and parsing issues
- Asynchronous networking using async/await
- Unit tests for ViewModel logic

## Build & Run Instructions

1. **Requirements**
   - Xcode 14 or later
   - iOS 16.0 or later

2. **Clone the repository**
   ```sh
   git clone https://github.com/yourusername/GitPeek.git
   cd GitPeek
   ```
   - Double-click `GitPeek.xcodeproj` or open it from Xcode's File > Open menu.

3. **Build and Run**
   - Select the `GitPeek` scheme.
   - Choose an iOS Simulator (e.g., iPhone 14).
   - Press `Cmd+R` to build and run.

4. **Run Tests**
   - Press `Cmd+U` or go to Product > Test to run the unit tests.

## Architectural Decisions & Structure

- **SwiftUI** is used for all UI, enabling declarative and reactive views.
- **MVVM (Model-View-ViewModel)** architecture separates UI, business logic, and data models for maintainability and testability.
- **Networking Abstraction**: A protocol (`URLSessionProtocol`) abstracts networking, allowing for easy mocking in tests.
- **Testing**: The `GitPeekTests` target includes comprehensive unit tests for the ViewModel, covering all major states and error conditions.

### File Structure
- `GitPeekApp.swift`: App entry point
- `ContentView.swift`: Main UI
- `GitHubUserViewModel.swift`: ViewModel for user search and profile
- `GitHubUserService.swift`: Networking and business logic
- `GitHubUser.swift`: Data model
- `Networking.swift`: Protocol for URLSession abstraction
- `Constants.swift`: Centralized constants
- `GitPeekTests/GitPeekTests.swift`: Unit tests

## Why These Decisions?
- **MVVM & Dependency Injection**: Ensures code is modular, testable, and easy to maintain.
- **Async/Await**: Modern Swift concurrency for better performance and readability.
- **Testing**: High test coverage ensures reliability and confidence in future changes.
- **UI/UX**: A clean, modern interface makes the app enjoyable to use.
