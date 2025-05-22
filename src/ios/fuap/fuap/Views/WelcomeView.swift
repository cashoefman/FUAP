import SwiftUI
import Combine

struct WelcomeView: View {
    @StateObject private var vm = WelcomeViewModel()

    var body: some View {
        VStack(spacing: 20) {
            Text("Welcome")
                .font(.largeTitle)
            TextField("Email", text: $vm.email)
                .textInputAutocapitalization(.never)
                .keyboardType(.emailAddress)
            Button("Get Started") {
                vm.getStarted()
            }
            .disabled(!vm.isEmailValid)
        }
        .padding()
        .onReceive(vm.routePublisher) { route in
            AppCoordinator.shared.route = route
        }
    }
}
