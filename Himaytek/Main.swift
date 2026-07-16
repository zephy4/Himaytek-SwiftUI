import SwiftUI

@main
struct HimaytekApp: App {
    @AppStorage(StorageKeys.isLoggedIn) var isLoggedin: Bool = false
    var body: some Scene {
        WindowGroup {
            Group {
                if isLoggedin {
                    HomeView()
                } else {
                    LoginView()
                }
            }
            .navigationTransition(.automatic)
        }
        .environmentObject(AuthService())
    }
}
