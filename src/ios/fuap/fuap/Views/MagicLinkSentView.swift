import SwiftUI

struct MagicLinkSentView: View {
    let email: String
    @EnvironmentObject var coordinator: AppCoordinator

    var body: some View {
        VStack(spacing: 20) {
            Text("Magic Link Sent")
                .font(.largeTitle)
            Text("We have sent you a magic login link to \(email). Please check your email and click on the link to sign in.")
                .multilineTextAlignment(.center)
                .padding()
            Button("Back to Login") {
                coordinator.route = .welcome
            }
        }
        .padding()
    }
}
