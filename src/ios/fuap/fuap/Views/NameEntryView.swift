import SwiftUI
import Combine

struct NameEntryView: View {
    let email: String
    @StateObject private var vm: NameEntryViewModel

    init(email: String) {
        self.email = email
        _vm = StateObject(wrappedValue: NameEntryViewModel(email: email))
    }

    var body: some View {
        VStack(spacing: 20) {
            Text("Enter Your Name")
                .font(.largeTitle)
            TextField("First Name", text: $vm.firstName)
            TextField("Last Name", text: $vm.lastName)
            Button("Continue") {
                vm.continueTapped()
            }
            .disabled(!vm.isValid)
        }
        .padding()
        .onReceive(vm.routePublisher) { route in
            AppCoordinator.shared.route = route
        }
    }
}
