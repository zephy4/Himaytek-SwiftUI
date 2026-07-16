import Combine
import SwiftUI

struct Headers {
    static let contentKeyType = "Content-Type"
    static let authorizationKey = "Authorization"

    static let jsonValue = "application/json"

}

struct Endpoints {
    static let login = "/auth/login"

    static func postDetails(id: Int) -> String {
        return "/posts/\(id)"
    }

}
