# FUAP Coding Standards and Style Guides

## Overview

This document outlines the coding standards and style guidelines specific to the FUAP project to ensure consistency, readability, maintainability, and collaboration across all codebases.

## General Principles

* **Write clean, readable, and maintainable code.**

  * Example: Separate complex methods into smaller, single-responsibility functions.
* **Follow consistent naming conventions and code structure.**

  * Example: Use `fetchUserData()` consistently rather than variations like `fetchDataForUser()` or `userDataFetch()`.
* **Ensure proper documentation and comments for clarity.**

  * Example: Clearly comment complex logic to explain the intent and reasoning behind certain decisions.

## iOS (Swift, SwiftUI)

### Architecture

* Follow MVVM+C (Model-View-ViewModel + Coordinator) architectural pattern.

### Naming Conventions

* Classes and structs: UpperCamelCase (e.g., `UserProfile`)
* Functions and variables: lowerCamelCase (e.g., `fetchUserData`)
* Constants: lowerCamelCase (e.g., `maxRetryAttempts`)

### Code Formatting

* Indentation: 4 spaces
* Line Length: Aim for a maximum of 120 characters per line
* Use spaces around operators and after commas

### Tools and Linters

* Utilize **SwiftLint** for enforcing Swift coding conventions, detecting stylistic issues, and maintaining code quality.

### Commenting and Documentation

* Use descriptive inline comments for complex logic
* Follow Apple's markup format for method and class documentation

## Android (`Kotlin`, Jetpack Compose)

### Architecture

* Follow MVVM (Model-View-ViewModel) architectural pattern using Jetpack Compose and Navigation Components.

### Naming Conventions

* Classes and Interfaces: UpperCamelCase (e.g., `UserRepository`)
* Methods and variables: lowerCamelCase (e.g., `getUserProfile`)
* Constants: UPPER\_SNAKE\_CASE (e.g., `MAX_RETRY_ATTEMPTS`)

### Code Formatting

* Indentation: 4 spaces
* Line Length: Maximum of 120 characters
* Spaces around operators and after commas

### Tools and Linters

* Utilize **`ktlint`** for enforcing `Kotlin` coding conventions and formatting guidelines.
* Utilize **`Detekt`** for static code analysis, detecting code smells, maintainability issues, and potential bugs.

### Commenting and Documentation

* Descriptive inline comments for clarity
* Use KDoc for public method and class documentation

## Firebase Integration

* **Error Handling and Logging**

  * Implement consistent error handling patterns across all Firebase interactions.
  * Log meaningful, structured messages to Firebase `Crashlytics` for easier debugging.
  * Example: Capture and log specific error types clearly, such as authentication failures or database read/write errors.

* **Firebase Security Rules**

  * Clearly document and enforce strict security rules tailored to your database (`Firestore` or Realtime Database).
  * Regularly review security rules and ensure they reflect changes in data access requirements.

* **Data Structuring**

  * Follow Firebase best practices for efficient data retrieval and scalability:

    * Keep data shallow to reduce query complexity.
    * Avoid deeply nested data structures to optimize performance.
    * Use indexes appropriately to enhance query efficiency.

* **Authentication**

  * Clearly document and consistently handle authentication states (authenticated, unauthenticated, expired sessions).
  * Implement secure and user-friendly authentication flows, including proper handling of Firebase magic links.

## UI Implementation (Film Noir Style)

* Adhere strictly to the project's thematic color scheme (Black and White, hint of Orange)
* Maintain minimalistic, modern UI designs
* Ensure responsiveness and smooth animations

## Version Control Practices

* Follow the established branching strategy (feature, develop, main)
* Clear, descriptive commit messages following Conventional Commit standards

## Code Reviews

* Mandatory for every pull request
* Review criteria: readability, maintainability, security, adherence to coding standards

## Accessibility and Compliance

* Follow WCAG accessibility guidelines in UI implementation
* Comply strictly with GDPR and CCPA data handling standards

This document provides the foundational coding standards and style guidelines to promote a consistent, high-quality codebase for the FUAP project.
