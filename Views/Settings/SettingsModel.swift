import Foundation

enum SettingsDestination: Hashable {
    case terms
    case privacy
    case support
    case ticket
}

struct SettingsModel: Identifiable, Hashable {
    var id = UUID().uuidString
    let image: String?
    let title: String?
    let destination: SettingsDestination
}
