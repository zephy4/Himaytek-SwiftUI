import Combine
import SwiftUI

class LoginViewModel: ObservableObject {

    init() {

    }

    @Published var isChecked: Bool = false
    @Published var isPasswordVisible: Bool = false
    let placeholder: String = ""
    @Published var text: String = ""
    @Published var phoneField: String = ""
    @Published var passwordField: String = ""
    @Published var isLoading: Bool = false
    @Published var isGuest: Bool = false

    //MARK: LOGIN API

    func onLoginTap() async {

        self.isLoading = true
        defer {
            self.isLoading = false
        }

        let credentials = LoginRequest(
            email: phoneField,
            //            mobileNumber: nil,
            password: passwordField,
            countryCode: "+965",
            deviceType: "ios",
            devicesToken: "deviceToken"
        )
        await AuthService.instance.loginApi(with: credentials)
    }

}
