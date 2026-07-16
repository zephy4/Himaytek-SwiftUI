import Combine
import SwiftUI

class SignupViewModel: ObservableObject {
    @Published var nameField: String = ""
    @Published var emailField: String = ""
}
