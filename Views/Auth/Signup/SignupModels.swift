//   let registerRequest = try? JSONDecoder().decode(RegisterRequest.self, from: jsonData)

import Foundation

// MARK: - RegisterRequest
struct RegisterRequest: Codable {
    let email: String?
    let mobileNumber: String?
    let password: String?
    let confirmPassword: String?
    let name: String?
    let countryCode: String?
    let deviceType: String?
    let devicesToken: String?

    enum CodingKeys: String, CodingKey {
        case email = "email"
        case mobileNumber = "mobile_number"
        case password = "password"
        case confirmPassword = "confirmPassword"
        case name = "name"
        case countryCode = "country_code"
        case deviceType = "device_type"
        case devicesToken = "devices_token"
    }
}

// MARK: - RegisterResponse
struct RegisterResponse: Codable {
    let success: Bool?
    let message: String?
    let code: Int?

    enum CodingKeys: String, CodingKey {
        case success = "success"
        case message = "message"
        case code = "code"
//MVVM
    }
}
