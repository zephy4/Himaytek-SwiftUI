import Combine
import SwiftUI

class SignupViewModel: ObservableObject {
    @Published var nameField: String = ""
    @Published var emailField: String = ""
    @Published var mobileNumberField: String = ""
    @Published var passwordField: String = ""
    @Published var confirmPasswordField: String = ""

    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = ""
    @Published var registrationSuccess: Bool = false

    /// Perform registration using Swift Concurrency (async/await)
    @MainActor
    func register() async {
        self.isLoading = true
        self.errorMessage = nil

        defer {
            self.isLoading = false
        }

        let request = RegisterRequest(
            email: emailField,
            mobileNumber: mobileNumberField,
            password: passwordField,
            confirmPassword: confirmPasswordField,
            name: nameField,
            countryCode: "US",
            deviceType: "ios",
            devicesToken: "device_token_here"
        )

        do {
            let response = try await AuthService.instance.registerApi(
                with: request
            )
            if response.success == true {
                self.registrationSuccess = true
                print("Registration successful: \(response.message ?? "")")
                self.errorMessage = response.message ?? "no response message"
            } else {
                self.errorMessage = response.message ?? "Registration failed"
            }

        } catch {
            self.errorMessage = error.localizedDescription
            print("Registration error: \(error)")
        }

        DispatchQueue.main.asyncAfter(
            deadline: .now() + 4,
            execute: {
                self.errorMessage = nil
            }
        )
    }

}
