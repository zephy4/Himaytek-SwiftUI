import SwiftUI

struct CommonButton<Destination: View>: View {
    // 1. Changed to 'let' because button text is usually static
    let text: String
    let destination: Destination
    var action: (() -> Void)? = nil
    var isNavigation: Bool
    
    var body: some View {
        if isNavigation {
            // 2. Navigation Link Destination
            NavigationLink {
                destination
            } label: {
                buttonLabel
            }
        } else {
            // 3. Regular Button Action
            Button {
                action?()
            } label: {
                buttonLabel
            }
        }
    }
    
    // 4. Shared styling so you don't duplicate code
    private var buttonLabel: some View {
        Text(text)
            .font(.custom("Urbanist-SemiBold", size: 14))
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(Color.accentColor) // Matches your system/custom accent color
            .cornerRadius(8)
            .padding(.horizontal, 20)
    }
}

#Preview {
    // For previewing a non-navigation button, we can pass EmptyView() as a placeholder
    CommonButton(
        text: "Get Started",
        destination: EmptyView(),
        action: { print("Tapped!") },
        isNavigation: false
    )
}
