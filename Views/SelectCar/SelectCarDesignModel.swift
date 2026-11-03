import SwiftUI

struct SelectCarDesignModel: Codable, Identifiable, Hashable {

    var id = UUID().uuidString
    let title: String?
    let icon: String?
}
