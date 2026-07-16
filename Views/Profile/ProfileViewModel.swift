import Combine
import SwiftUI

class ProfileViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var email: String = ""

    init() {
        loadCredentials()
    }

    func loadCredentials() {
        username =
            UserDefaults.standard.string(forKey: StorageKeys.username)
            ?? "Guest"
        email =
            UserDefaults.standard.string(forKey: StorageKeys.email)
            ?? "Guest"
    }

    func logout() {
        UserDefaults.standard.removeObject(forKey: StorageKeys.username)
        UserDefaults.standard.removeObject(forKey: StorageKeys.email)
    }
}
