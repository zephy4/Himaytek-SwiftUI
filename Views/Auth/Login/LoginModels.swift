import Foundation

// MARK: - LoginResponse
struct LoginResponse: Codable {
    let accessToken, refreshToken: String?
    let id: Int?
    let username, email, firstName, lastName: String?
    let gender: String?
    let image: String?
}

struct LoginRequest: Codable {
    let username, password: String?
    let expiresInMins: Int?
}
