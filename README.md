
# FUAP iOS App

FUAP ("Firebase User Authentication Project") is an iOS application demonstrating robust and privacy-compliant user authentication using Firebase. The project leverages Swift, SwiftUI, Combine, and Firebase Authentication (Magic Links and Password Authentication), along with Firestore for user profile management.

**Note:** An Android version of FUAP is currently under active development.

## 🚀 Key Features

- **Magic Link Authentication:** Users can sign in seamlessly via email without needing a password.
- **Email/Password Authentication:** Optional traditional authentication with password management.
- **Dynamic User Onboarding:** Automatically detects new users, prompting them for name details and creating a profile dynamically.
- **Firebase Firestore Integration:** User profiles are securely managed using Firestore.
- **Clean Architecture (MVVM):** Clearly separated ViewModels and Views with Combine for reactive event handling.

## 📱 App Flow Overview

1. **Welcome Screen:**  
   - Users enter their email.
   - App checks Firestore for existing user status:
     - Existing user with password: prompted to enter password.
     - Existing user without password: magic link sent automatically.
     - New users: prompted for name entry, then sent a magic link.

2. **Magic Link Authentication:**  
   - Users click on a magic link sent via email.
   - App handles deep link to authenticate and signs in the user.
   - New user profiles are created on-the-fly in Firestore.

3. **User Profile:**  
   - Displays user details (name, email, bio).
   - Allows profile editing and optional password setting.
   - Users can securely log out at any time.

## 🛠️ Technical Stack

- **Swift & SwiftUI:** Modern declarative UI development.
- **Firebase Authentication:** Magic link (email link) and password sign-in support.
- **Firestore:** Persistent storage of user profiles.
- **Combine:** Reactive programming for state management.
- **Swift Concurrency:** Async/Await for clear asynchronous operations.

## 📁 Project Structure

```
src/ios/fuap/
├── AppCoordinator.swift        # Handles app-wide routing and deep link management.
├── FUAPApp.swift               # Entry point, Firebase setup, root view injection.
├── RootView.swift              # Main navigation container.
├── ViewModels/                 # MVVM ViewModels handling logic and Firebase interactions.
│   ├── WelcomeViewModel.swift
│   ├── PasswordEntryViewModel.swift
│   ├── NameEntryViewModel.swift
│   └── ProfileViewModel.swift
├── Views/                      # SwiftUI Views representing UI screens.
│   ├── WelcomeView.swift
│   ├── PasswordEntryView.swift
│   ├── NameEntryView.swift
│   ├── MagicLinkSentView.swift
│   ├── ProfileView.swift
│   └── ProfileEditView.swift
└── Assets.xcassets             # App icons and color assets
```

## 🧑‍💻 Getting Started

1. **Clone the repository:**

```bash
git clone <repository-url>
cd src/ios/fuap
```

2. **Install dependencies:**

- Configure your Firebase project.
- Replace `GoogleService-Info.plist` with your own Firebase configuration file.

3. **Open & Run Project:**

- Open `fuap.xcodeproj` with Xcode 16.3+.
- Build and run the app on an iOS 18+ device or simulator.

## 🔗 Firebase Configuration

- Ensure Firebase Authentication has Email/Password and Email Link sign-in enabled.
- Set Firestore security rules to protect user data appropriately.

Example rules for Firestore security:
```javascript
match /users/{uid} {
  allow read, write: if request.auth.uid == uid;
}
```

## 📌 Important Notes

- **Privacy Compliance:** Uses Firestore explicitly for user identification, avoiding deprecated Firebase methods affected by Email Enumeration Protection.
- **Debugging:** Comprehensive logging statements are included to ease debugging and provide clarity during development.

## 📃 License

This project is available under the MIT License.
