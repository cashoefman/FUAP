import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct ProfileEditView: View {
    @Environment(\.dismiss) var dismiss
    @State var displayName: String
    @State var bio: String
    @State var newPassword: String = ""
    @State var confirmPassword: String = ""
    let uid: String

    init(user: ProfileViewModel.UserProfile?) {
        _displayName = State(initialValue: user?.displayName ?? "")
        _bio = State(initialValue: user?.bio ?? "")
        uid = Auth.auth().currentUser?.uid ?? ""
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Profile Info")) {
                    TextField("Display Name", text: $displayName)
                    TextField("Bio", text: $bio)
                }
                Section(header: Text("Change Password")) {
                    SecureField("New Password", text: $newPassword)
                    SecureField("Confirm Password", text: $confirmPassword)
                }
            }
            .navigationTitle("Edit Profile")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        save()
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }

    func save() {
        Task {
            do {
                var updates: [String: Any] = [
                    "displayName": displayName,
                    "bio": bio
                ]
                // Update password if provided
                if !newPassword.isEmpty {
                    guard newPassword == confirmPassword else {
                        print("Error: Passwords do not match.")
                        return
                    }
                    try await Auth.auth().currentUser?.updatePassword(to: newPassword)
                    print("[ProfileEdit] password updated for user:", uid)
                    updates["hasPassword"] = true
                }
                // Write updates to Firestore
                try await Firestore.firestore().collection("users").document(uid).updateData(updates)
                print("[ProfileEdit] profile updated for user:", uid)
                dismiss()
            } catch {
                print("Error updating profile:", error)
            }
        }
    }
}
