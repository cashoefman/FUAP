import SwiftUI
import FirebaseCore

@main
struct FUAPApp: App {
    @StateObject private var coordinator = AppCoordinator.shared

    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(coordinator)
                .onOpenURL { url in
                    print("[App] onOpenURL:", url.absoluteString)
                    coordinator.handleDeepLink(url)
                }
        }
    }
}
