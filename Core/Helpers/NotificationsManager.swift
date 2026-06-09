import Combine
import SwiftUI

class NotificationsManager {
    static var instance = NotificationsManager()
    
    

    func requestPermissions() {
        let options: UNAuthorizationOptions = [.alert, .badge, .sound]

        UNUserNotificationCenter.current().requestAuthorization(
            options: options
        ) { (success, error) in
            if let error = error {
                print(
                    "Error while getting permissions of  notifications: \(error.localizedDescription)"
                )
            } else {
                print("Notification Permissions granted")
            }
        }

    }
}
