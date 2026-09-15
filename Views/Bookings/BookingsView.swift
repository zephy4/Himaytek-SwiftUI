import SwiftUI

struct BookingsView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 10) {
                Spacer(minLength: 150)
                Circle()
                    .fill(.thickMaterial)
                    .frame(width: 120, height: 120)
                    .overlay(
                        Image(systemName: "calendar")
                            .foregroundColor(.gray)
                            .font(.title)
                            .fontWeight(.bold)
                    )
                Text("No bookings yet")
                    .font(.custom("Urbanist-Regular", size: 20))
                Text("Your upcoming services will show up here.")
                    .font(.custom("Urbanist-Regular", size: 16))
                    .multilineTextAlignment(.center)
            }
        }
    }
}

#Preview {
    NavigationStack {
        BookingsView()
    }
}
