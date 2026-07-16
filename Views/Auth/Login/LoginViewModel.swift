import Combine
import SwiftUI

class LoginViewModel: ObservableObject {

    init() {

    }

    @Published var phoneField: String = ""
    @Published var passwordField: String = ""
    @Published var isLoading: Bool = false
    @Published var isGuest: Bool = false

    //MARK: LOGIN API

    func onLoginTap() {
        isLoading = true
        let credentials = LoginRequest(
            username: phoneField,
            password: passwordField,
            expiresInMins: 60
        )

        AuthService.instance.loginApi(with: credentials)
        isLoading = false
    }

}
