import Combine
import SwiftUI

enum APIEnvironment {
    case development
    case staging
    case production

    var baseURL: URL {
        switch self {
        case .development:
            return URL(string: "http://127.0.0.1:8000")!
        case .staging:
            return URL(string: "https://staging-api.yoursite.com/v1")!
        case .production:
            return URL(string: "https://api.yoursite.com/v1")!
        }
    }
}

// Set your current environment here (or drive this via Xcode Build Configurations/xcconfig)
struct APIConfig {
    static let currentEnvironment: APIEnvironment = .development
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
    case json = "application/json"
    case multipart = "multipart/form-data"
}


struct Endpoints {
    static let login = "/api/auth/login"
    static let register = "/api/auth/register"
    static let vendors = "api/vendors/nearby"
    static let vendorsDetails = "api/vendors"
    static let tickets = "/api/support/tickets"

    static func postDetails(id: Int) -> String {
        return "/posts/\(id)"
    }

}
