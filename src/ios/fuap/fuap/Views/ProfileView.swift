import SwiftUI

struct ProfileView: View {
    @StateObject private var vm = ProfileViewModel()

    var body: some View {
        VStack(spacing: 20) {
            if let user = vm.user {
                Text("Hello, \(user.displayName ?? "User")")
                    .font(.largeTitle)
                Text("Email: \(user.email ?? "")")
                Button("Edit Profile") {
                    vm.isEditing = true
                }
                Button("Sign Out") {
                    vm.signOut()
                }
            } else {
                ProgressView()
            }
        }
        .sheet(isPresented: $vm.isEditing) {
            ProfileEditView(user: vm.user)
        }
        .onAppear {
            vm.fetchUser()
        }
    }
}
