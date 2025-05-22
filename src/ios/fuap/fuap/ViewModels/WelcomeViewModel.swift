import Foundation
import FirebaseAuth
import FirebaseFirestore
import Combine

@MainActor
class WelcomeViewModel: ObservableObject {
    @Published var email = ""
    let routePublisher = PassthroughSubject<AppCoordinator.Route, Never>()

    var isEmailValid: Bool { email.contains("@") }

    func getStarted() {
        Task {
            do {
                // 1. Check Firestore for existing user document
                let snapshot = try await Firestore.firestore()
                    .collection("users")
                    .whereField("email", isEqualTo: email)
                    .getDocuments()
                print("[WelcomeVM] Firestore docs count: \(snapshot.documents.count)")

                if let doc = snapshot.documents.first {
                    let data = doc.data()
                    print("[WelcomeVM] Doc data: \(data)")
                    let hasPassword = data["hasPassword"] as? Bool ?? false
                    print("[WelcomeVM] hasPassword flag: \(hasPassword)")

                    if hasPassword {
                        // User with a password: go to password entry
                        await MainActor.run {
                            routePublisher.send(.passwordEntry(email: email))
                        }
                    } else {
                        // Existing user without password: send magic link
                        try await sendMagicLink()
                        await MainActor.run {
                            routePublisher.send(.magicLinkSent(email: email))
                        }
                    }
                    return
                }

                // 2. No existing user: start signup flow
                await MainActor.run {
                    routePublisher.send(.nameEntry(email: email))
                }

            } catch {
                print("[WelcomeVM] Error in getStarted:", error)
            }
        }
    }

    private func sendMagicLink() async throws {
        let settings = ActionCodeSettings()
        settings.url = URL(string: "https://auth.brickcity.app/login")!
        settings.handleCodeInApp = true
        settings.setIOSBundleID("io.disruptive.dev.fuap")

        try await Auth.auth().sendSignInLink(toEmail: email, actionCodeSettings: settings)
        print("[WelcomeVM] sent magic link to: \(email)")
        UserDefaults.standard.set(email, forKey: "MagicLinkEmail")
    }
}
