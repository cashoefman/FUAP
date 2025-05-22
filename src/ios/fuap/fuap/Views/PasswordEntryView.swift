import SwiftUI
import Combine

struct PasswordEntryView: View {
    let email: String
    @StateObject private var vm: PasswordEntryViewModel

    init(email: String) {
        self.email = email
        _vm = StateObject(wrappedValue: PasswordEntryViewModel(email: email))
    }

    var body: some View {
        VStack(spacing: 20) {
            Text("Enter Your Password")
                .font(.largeTitle)
            SecureField("Password", text: $vm.password)
            Button("Sign In") {
                vm.signIn()
            }
            .disabled(!vm.isValid)
        }
        .padding()
        .onReceive(vm.routePublisher) { route in
            AppCoordinator.shared.route = route
        }
    }
}
