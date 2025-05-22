import Foundation
import FirebaseAuth
import FirebaseFirestore
import Combine

@MainActor
class NameEntryViewModel: ObservableObject {
    let email: String
    @Published var firstName = ""
    @Published var lastName = ""
    let routePublisher = PassthroughSubject<AppCoordinator.Route, Never>()

    var isValid: Bool { !firstName.isEmpty && !lastName.isEmpty }

    init(email: String) {
        self.email = email
    }

    func continueTapped() {
        let settings = ActionCodeSettings()
        settings.url = URL(string: "https://auth.brickcity.app/login")!
        settings.handleCodeInApp = true
        settings.setIOSBundleID("io.disruptive.dev.fuap")

        Task {
            do {
                try await Auth.auth().sendSignInLink(toEmail: email, actionCodeSettings: settings)
                let displayName = "\(firstName) \(lastName)"
                UserDefaults.standard.set(displayName, forKey: "MagicLinkDisplayName")
                print("[NameEntryVM] sent magic link and saved display name:", displayName)
                await MainActor.run {
                    routePublisher.send(.magicLinkSent(email: email))
                }
            } catch {
                print("Magic link error:", error)
            }
        }
    }
}
