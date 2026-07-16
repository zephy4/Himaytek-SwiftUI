import Combine
import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var username: String = ""

    init() {
        loadCredentials()
    }

    func loadCredentials() {
        username =
            UserDefaults.standard.string(forKey: StorageKeys.username)
            ?? "Guest"
    }
}
