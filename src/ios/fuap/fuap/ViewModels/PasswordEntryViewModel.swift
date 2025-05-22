import Foundation
import FirebaseAuth
import Combine

@MainActor
class PasswordEntryViewModel: ObservableObject {
    let email: String
    @Published var password = ""
    @Published var errorMessage: String? = nil
    private var attemptCount = 0
    let routePublisher = PassthroughSubject<AppCoordinator.Route, Never>()

    var isValid: Bool { password.count >= 6 }

    init(email: String) {
        self.email = email
    }

    func signIn() {
        Task {
            do {
                _ = try await Auth.auth().signIn(withEmail: email, password: password)
                print("[PasswordVM] sign-in successful for:", email)
                routePublisher.send(.profile)
            } catch {
                handleSignInError(error)
            }
        }
    }

    private func handleSignInError(_ error: Error) {
        let nsError = error as NSError
        let authCode = AuthErrorCode(rawValue: nsError.code)

        // Treat both wrong password and invalid credential as retryable password errors
        if authCode == .wrongPassword || authCode == .invalidCredential {
            attemptCount += 1
            if attemptCount >= 3 {
                sendMagicLink()
                errorMessage = "Too many attempts. Magic link sent to your email."
            } else {
                errorMessage = "Incorrect password. You have \(3 - attemptCount) attempts left."
            }
        } else {
            // Other errors (e.g., network issues) show the raw message
            errorMessage = error.localizedDescription
        }
        print("[PasswordVM] error: \(errorMessage ?? "")")
    }

    private func sendMagicLink() {
        let settings = ActionCodeSettings()
        settings.url = URL(string: "https://auth.brickcity.app/login")!
        settings.handleCodeInApp = true
        settings.setIOSBundleID("io.disruptive.dev.fuap")

        Task {
            do {
                try await Auth.auth().sendSignInLink(toEmail: email, actionCodeSettings: settings)
                UserDefaults.standard.set(email, forKey: "MagicLinkEmail")
                print("[PasswordVM] sent magic link to:", email)
                await MainActor.run {
                    routePublisher.send(.magicLinkSent(email: email))
                }
            } catch {
                print("Magic link error:", error)
                errorMessage = "Failed to send magic link."
            }
        }
    }
}
