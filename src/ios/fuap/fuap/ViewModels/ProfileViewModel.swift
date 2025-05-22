import Foundation
import FirebaseAuth
import FirebaseFirestore

class ProfileViewModel: ObservableObject {
    struct UserProfile {
        var displayName: String?
        var email: String?
        var bio: String?
    }

    @Published var user: UserProfile?
    @Published var isEditing = false

    private let db = Firestore.firestore()

    func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        db.collection("users").document(uid).getDocument { snapshot, error in
            if let data = snapshot?.data() {
                self.user = UserProfile(
                    displayName: data["displayName"] as? String,
                    email: data["email"] as? String,
                    bio: data["bio"] as? String
                )
            }
        }
    }

    func signOut() {
        do {
            try Auth.auth().signOut()
            print("[ProfileVM] user signed out")
        } catch {
            print("Sign out error: \(error)")
        }
    }
}
