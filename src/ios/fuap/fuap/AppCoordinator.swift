import SwiftUI
import FirebaseAuth
import FirebaseFirestore

@MainActor
class AppCoordinator: ObservableObject {
    static let shared = AppCoordinator()

    enum Route {
        case welcome
        case nameEntry(email: String)
        case passwordEntry(email: String)
        case magicLinkSent(email: String)
        case profile
    }

    @Published var route: Route = .welcome
    private var handle: AuthStateDidChangeListenerHandle?

    private init() {
        handle = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            Task { @MainActor in
                self?.route = (user != nil) ? .profile : .welcome
            }
        }
    }

    deinit {
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }

    func handleDeepLink(_ url: URL) {
        print("[Coordinator] handleDeepLink:", url.absoluteString)
        let link = url.absoluteString

        if Auth.auth().isSignIn(withEmailLink: link) {
            print("[Coordinator] isSignIn link → proceeding")
            Task {
                guard let email = UserDefaults.standard.string(forKey: "MagicLinkEmail") else {
                    print("[Coordinator] ❌ no MagicLinkEmail in UserDefaults")
                    return
                }
                print("[Coordinator] MagicLinkEmail:", email)

                do {
                    let result = try await Auth.auth().signIn(withEmail: email, link: link)
                    print("[Coordinator] signIn success; isNewUser =", result.additionalUserInfo?.isNewUser ?? false)
                    UserDefaults.standard.removeObject(forKey: "MagicLinkEmail")

                    if result.additionalUserInfo?.isNewUser == true {
                        let name = UserDefaults.standard.string(forKey: "MagicLinkDisplayName") ?? ""
                        let uid  = result.user.uid
                        print("[Coordinator] 🎉 new user. writing profile:", uid, name)

                        do {
                            try await Firestore.firestore()
                                .collection("users")
                                .document(uid)
                                .setData([
                                    "displayName": name,
                                    "email": email,
                                    "bio": "",
                                    "hasPassword": false
                                ])
                            print("[Coordinator] ✔️  profile written for", uid)
                        } catch {
                            print("[Coordinator] ❌ Firestore setData error:", error)
                        }

                        UserDefaults.standard.removeObject(forKey: "MagicLinkDisplayName")
                    }

                    self.route = .profile
                } catch {
                    print("[Coordinator] ❌ signIn(withLink) error:", error)
                }
            }
        } else {
            print("[Coordinator] Not a sign-in link; routing to .profile")
            route = .profile
        }
    }
}
