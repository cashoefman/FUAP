# FUAP Architecture and Design Documentation

## Overview

This document provides a detailed overview of FUAP's system architecture, including design decisions, data flows, and implementation specifics, particularly focusing on Firebase services and client applications (iOS and Android).

## System Architecture

### High-Level Architecture Diagram

```
+----------------------+              +------------------------+
|                      |              |                        |
|   Client Apps        | <----------> |    Firebase Services   |
| (iOS and Android)    |              | (Authentication,       |
|                      |              |  Firestore Database,   |
|                      |              |  Cloud Functions)      |
+----------------------+              +------------------------+
          |                                       |
          |                                       |
          v                                       v
+----------------------+              +------------------------+
|                      |              |                        |
|    User Interface    |              | Cloud Function Actions |
|   (SwiftUI/Compose)  |              | (Image Processing,     |
|                      |              |  Authentication Events)|
+----------------------+              +------------------------+
```

### Components

#### Firebase Authentication

FUAP leverages Firebase Authentication to manage user identities securely and efficiently. Authentication methods include:

* Email/password for traditional user registration and login.
* Magic links for passwordless authentication to enhance user convenience and security.

#### Firestore Database

Firestore provides robust, real-time synchronization and scalable data persistence:

* Data is structured in collections and documents optimized for scalability.
* Real-time updates ensure synchronization across client devices seamlessly.
* Security rules are implemented to safeguard user data.

#### Cloud Functions

Cloud Functions handle server-side operations efficiently:

* **Image processing:** Automatically resizes and optimizes profile images, offloading resource-intensive tasks from client apps.
* **Authentication events:** Manages user registration, email verification, and other background authentication-related tasks.

#### Client Applications (iOS/Android)

The client applications deliver user interfaces and client-side logic:

* **iOS:** SwiftUI for building a declarative, responsive user interface.
* **Android:** Jetpack Compose for similarly creating modern, maintainable UI components.
* Both platforms integrate seamlessly with Firebase backend services.

### Data Flow

```
+----------------------+               +---------------------------+
|                      | User actions  |                           |
|    Client Apps       | ------------> | Firebase Authentication   |
| (iOS and Android)    |               |                           |
+----------------------+               +---------------------------+
           |                                         |
           |                                         |
           v                                         v
+----------------------+               +---------------------------+
|                      | CRUD actions  |                           |
|    User Interface    | ------------> |   Firestore Database      |
| (SwiftUI/Compose)    | <------------ | (Profile data, settings)  |
+----------------------+               +---------------------------+
           |                                         |
           v                                         v
+----------------------+               +---------------------------+
|                      | Image upload  |                           |
|  Profile Management  | ------------> |     Cloud Functions       |
|                      | <------------ | (Image resizing, updates) |
+----------------------+               +---------------------------+
```

## Database Schema (Firestore)

### User Collection

* **User Identification:**

  * `userId`: Unique, immutable identifier (Firebase UID).
  * `authProvider`: Method used for authentication (email, Google, Apple).
* **Basic Profile Information:**

  * `email`: User's email address.
  * `displayName`: User-friendly identifier.
  * `profileImageUrl`: Optimized links (original, thumbnail) from Cloud Function processing.
* **User Preferences and Settings:**

  * `notificationPreferences`: Settings for push notifications and emails.
  * `themePreferences`: UI theme settings (dark mode, light mode).
  * `privacySettings`: Visibility of user information.
* **Security and Compliance Fields:**

  * `emailVerified`: Boolean indicating email verification status.
  * `accountStatus`: Active, suspended, or banned.
  * `gdprCcpaConsent`: Record of user consent status.
* **Metadata & Timestamps:**

  * `accountCreatedAt`: Timestamp for account creation.
  * `lastLoginAt`: Timestamp for last login.
* **App-Specific Information:**

  * `membershipStatus`: Subscription or membership tier.
  * `languagePreference`: Preferred language.
* **Relationships (Optional):**

  * `linkedUsers`: IDs for social connections.
  * `groups`: Membership in groups or teams.

### Security Rules

* Clearly documented rules ensuring data privacy and security.

## Firebase Cloud Functions

### Image Processing Functionality

* **Trigger:** User uploads profile image.
* **Purpose:** Automatic resizing, optimization, and thumbnail generation.

#### Supported Formats

* JPEG, PNG

#### Desired Resolutions

* Full-size: 1080x1080 px
* Thumbnail: 200x200 px

#### Error Handling

* Handle errors related to unsupported formats, upload failures, or processing errors.

## API Design

* Refer to [FUAP API Documentation](docs/api/API_Documentation.md) for detailed endpoint interactions.

## User Interface (UI/UX)

* Modern, minimalistic design.
* Film Noir style with a black-and-white color palette and strategic orange accents.

### Wireframes

* Link or embed wireframe designs.

### Design Principles

* Consistent user experience across platforms.
* Responsive and intuitive interface.

## Technical Decisions

* Firebase selected for rapid development, scalability, and robust feature set.
* SwiftUI and Jetpack Compose chosen for modern, declarative UI development.
* Cloud Functions used for serverless backend processing to enhance app performance and user experience.

## Constraints

* Budget considerations for Firebase usage.
* Adherence to GDPR and CCPA regulations.

## Assumptions

* Initial scaling supports approximately 500 concurrent users.
* Stable internet connection assumed for optimal user experience.

## Risks and Mitigations

* Dependency on Firebase mitigated by clear abstraction layers and regular monitoring.
* Potential performance bottlenecks addressed by proactive performance testing and optimizations.

## Future Considerations

* Possible migration to a dedicated backend if scalability or complexity requires it.
* Continuous evaluation of Firebase cost-efficiency and performance.
