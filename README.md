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
   - Copy the command line instruction below and open 'Terminal' from your list of applications. Then paste and run the instuction.
   ```
   git clone https://github.com/AbdullahNana/GitPeek.git
   ```
   - Navigate the downloaded repository from your files.
   - Double-click `GitPeek.xcodeproj`.

3. **Build and Run**
   - Select the `GitPeek` scheme.
   - Choose an iOS Simulator (e.g., iPhone 14).
   - Press `Cmd+R` to build and run.

4. **Run Tests**
   - Open the `GitPeekTests.swift` file.
   - Click on the diamond-shaped 'play' button on the left of the `GitHubUserViewModelAsyncTests` class.

   OR

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
- `Localizable.strings`: Text used in the app

## Why Implement Testing? (Bonus Feature)
- The `GitPeekTests` target includes comprehensive unit tests for the ViewModel, covering all major states and error conditions. Unit tests are important in every project because they ensure individual components of the app work correctly, helping catch bugs early and maintain code reliability during development. I implemented this in my project as it is something with which I am familiar. It also assisted me with debugging and ensuring that my code was reliable and helped me ensure that the iterative changes I made to my code were working as expected and not introducing unexpected bugs.

### App Demo:

![GitPeek demo](https://github.com/user-attachments/assets/abb0f1ad-7470-4430-af03-f6582ed72140)


