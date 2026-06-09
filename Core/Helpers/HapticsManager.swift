import Combine
import SwiftUI

class HapticsManager {

    static var instance = HapticsManager()

    func notification(type: UINotificationFeedbackGenerator.FeedbackType) {

        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
    
    func haptic(type: UIImpactFeedbackGenerator.FeedbackStyle){
        let generator = UIImpactFeedbackGenerator(style: type)
        generator.impactOccurred()
    }

    
}
