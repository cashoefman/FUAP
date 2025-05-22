# FUAP Onboarding Documentation

## Welcome

Welcome to the FUAP project! This document provides detailed guidelines to quickly onboard you into the development environment, covering essential tools, software versions, and initial setup instructions.

## Project Overview

FUAP is a cross-platform mobile application built natively for iOS and Android, leveraging Firebase services to deliver secure, reliable, and performant user experiences.

**GitHub Repository:** [https://github.com/cashoefman/FUAP](https://github.com/cashoefman/FUAP)

## Prerequisites

### Software Requirements

- **Operating System:** macOS (latest version recommended)
- **IDE:**

  - Xcode 16.3+ (for iOS)
  - Android Studio (latest stable release)

- **Languages and Frameworks:**

  - Swift 6.1+ (SwiftUI)
  - Kotlin (Jetpack Compose)

- **Version Control:** Git
- **Package Managers:** Swift Package Manager (iOS), Gradle (Android)

### Deployment Targets

- **iOS:** 18+
- **Android:** Android API 30+ (Android 11+)

## Environment Setup

### 1. Clone the Repository

```bash
git clone https://github.com/cashoefman/FUAP.git
cd FUAP
git checkout -b develop
```

### 2. Firebase Project Setup in Firebase Console

- Sign in to the [Firebase Console](https://console.firebase.google.com/).
- Click "Add project" and enter "FUAP" as the project name.
- Follow the prompts to set up Analytics if required (can be disabled if not needed).
- Click "Create project."
- Once created, select the platform (iOS or Android) and follow instructions provided by Firebase to complete setup and download configuration files.
- Enable and configure Authentication, Firestore Database, and Cloud Functions as per the project's requirements.

### 3. iOS Development Environment Setup

- **Create the Xcode Project:**

  1. Open Xcode 16.3+ and select "Create a new Xcode project."
  2. Choose "App" under iOS and click "Next."
  3. Set:

     - **Product Name:** `FUAP`
     - **Interface:** `SwiftUI`
     - **Language:** `Swift`
     - **Bundle Identifier:** `io.disruptive.dev.fuap`

  4. Set the minimum deployment target to iOS 18.
  5. **Uncheck** the option "Create Git repository on my Mac."
  6. Choose the location within your cloned repository (`FUAP/src/ios`) and click "Create."
  7. In your terminal, navigate to your repo and commit:

     ```bash
     cd FUAP
     git add .
     git commit -m "Initial Xcode project setup"
     git push origin develop
     ```

- Configure Firebase:

  - After creating the Firebase project (see above), download and add your Firebase configuration file (`GoogleService-Info.plist`) to the project.

- **Add Firebase Dependency via Swift Package Manager:**

  1. In Xcode, select your project under the General tab.
  2. Click on the "+" button under Frameworks, Libraries, and Embedded Content.
  3. Choose "Add Package Dependency."
  4. Paste Firebase SDK URL: `https://github.com/firebase/firebase-ios-sdk.git` and follow prompts to add required Firebase packages.

- **Setup SwiftLint:**

  1. Ensure SwiftLint is installed:

     ```bash
     brew install swiftlint
     ```

  2. In Xcode, select your target and go to the **Build Phases** tab.
  3. Click the "+" button and select **New Run Script Phase**.
  4. Rename this script to "Run SwiftLint".
  5. Paste this script into the script box:

     ```bash
     if which swiftlint >/dev/null; then
       swiftlint
     else
       echo "SwiftLint not installed. Please install it from https://github.com/realm/SwiftLint"
     fi
     ```

  6. Move this Run Script phase above the "Compile Sources" phase.
  7. Uncheck **"Based on dependency analysis"** to run the script on every build.

### 4. Android Development Environment Setup

- **Create Android Studio Project:**

  1. Open Android Studio and click "New Project."
  2. Choose "Empty Compose Activity" and click "Next."
  3. Configure the project:

     - **Name:** `fuap`
     - **Package name:** `io.disruptive.dev.fuap`
     - **Save location:** Select `FUAP/src/android` in your repository.
     - **Language:** Kotlin
     - **Minimum SDK:** API 30 (Android 11)

  4. Click "Finish."
  5. Allow Gradle to complete syncing dependencies.

- Configure Firebase:

  - After creating the Firebase project (see above), download and add your Firebase configuration file (`google-services.json`) to the `app` directory.

### 5. Install Linters and Tools

- **iOS:** Install SwiftLint

  ```bash
  brew install swiftlint
  ```

- **Android:**

  - ktlint:

    ```bash
    brew install ktlint
    ```

  - Detekt (configured via Gradle)

## Workflow Conventions

- **Git Branching:** Feature branches from `develop`.

  ```bash
  git checkout develop
  git pull origin develop
  git checkout -b feature/your-feature-name
  ```

- **Commit Standards:** Follow [Conventional Commit](https://www.conventionalcommits.org/en/v1.0.0/).
- **Pull Requests:** Clearly documented and peer-reviewed.

## Project Structure

```
FUAP/
├── src/
│   ├── android/
│   └── ios/
├── docs/
├── scripts/
└── tests/
```

## Issue Tracking

- Use GitHub Issues for bug tracking and feature requests.
- Clearly label and prioritize issues.

## Coding Standards

- Follow [FUAP Coding Standards and Style Guides](docs/Coding_Standards_and_Style_Guides.md).

## Communication Channels

- GitHub Discussions for project-related questions and clarifications.
- Regular team sync-ups (via designated communication platforms).

## Resources and Support

- [Firebase Documentation](https://firebase.google.com/docs)
- SwiftUI Documentation
- Jetpack Compose Documentation
- Reach out via GitHub Discussions for assistance.

## Next Steps

- Set up your environment as outlined.
- Familiarize yourself with the project's architecture, design, and coding standards.
- Begin by addressing starter tasks labeled "good first issue" in GitHub Issues.
