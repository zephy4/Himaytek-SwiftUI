import Combine
import SwiftUI

class SettingsViewModel: ObservableObject {

    @Published var settingsItems = [
        SettingsModel(
            image: "newspaper",
            title: "Terms of Services",
            destination: .terms
        ),
        SettingsModel(
            image: "newspaper",
            title: "Privacy Policy",
            destination: .privacy
        ),
        SettingsModel(
            image: "person",
            title: "Support & Help Center",
            destination: .support
        ),
        SettingsModel(
            image: "ticket",
            title: "Submit a ticket",
            destination: .ticket
        ),
    ]

    @Published var deleteConfirmation: Bool = false
}
