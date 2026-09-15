import Foundation

// MARK: - LoginResponse
struct LoginResponse: Codable {
    let success: Bool?
    let message: String?
    let code: Int?
    let data: DataClass?
    
    enum CodingKeys: String, CodingKey {
        case success, message, code, data
    }
}

// MARK: - DataClass
struct DataClass: Codable {
    let user: User?
    let token: String?
    
    enum CodingKeys: String, CodingKey {
        case user, token
    }
}

// MARK: - User
struct User: Codable {
    let id: Int?
    let name: String?
    let email: String?
    let countryCode: String?
    let mobileNumber: String?
    let type: String?
    
    // ✅ Replaced JSONNull? with standard optional String?
    let profileImage: String?
    let phoneVerifiedAt: String?
    let languagePreference: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, email, type
        case countryCode = "country_code"
        case mobileNumber = "mobile_number"
        case profileImage = "profile_image"
        case phoneVerifiedAt = "phone_verified_at"
        case languagePreference = "language_preference"
    }
}

// MARK: - LoginRequest
struct LoginRequest: Codable {
    let email: String?
    let password: String?
    let countryCode: String?
    let deviceType: String?
    let devicesToken: String?
    
    enum CodingKeys: String, CodingKey {
        case email, password
        case countryCode = "country_code"
        case deviceType = "device_type"
        case devicesToken = "devices_token"
    }
}
