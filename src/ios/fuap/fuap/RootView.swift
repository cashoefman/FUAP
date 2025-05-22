import SwiftUI

struct RootView: View {
    @EnvironmentObject var coordinator: AppCoordinator

    var body: some View {
        NavigationStack {
            switch coordinator.route {
            case .magicLinkSent(let email):
                MagicLinkSentView(email: email)
            case .welcome:
                WelcomeView()
            case .nameEntry(let email):
                NameEntryView(email: email)
            case .passwordEntry(let email):
                PasswordEntryView(email: email)
            case .profile:
                ProfileView()
            }
        }
    }
}
