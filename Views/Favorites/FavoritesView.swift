import SwiftUI

struct BookingsView: View {

    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 10) {
              
                Spacer(minLength: 150)
                Circle().fill(.thickMaterial).frame(
                    width: 120,
                    height: 120,
                    alignment: .center
                ).overlay(
                    Image(systemName: "heart").foregroundColor(.gray).font(
                        .title
                    ).fontWeight(.bold)
                ).frame(width: 120, height: 160, alignment: .center)
                Text("No Favorites Yet!").font(
                    .custom("Urbanist-Regular", size: 20)
                )
                Text("Start Adding Your Favorite Vendors\nto see them here")
                    .font(.custom("Urbanist-Regular", size: 16))
                    .multilineTextAlignment(.center)
                Button(action: ({})) {
                    RoundedRectangle(cornerRadius: 10).fill(.accent).frame(
                        width: 190,
                        height: 60,
                        alignment: .center
                    ).overlay(
                        Text("Explore Vendors").foregroundColor(.white)
                            .fontWeight(
                                .medium
                            )
                    )
                }
            }

        }
    }
}

#Preview {
    BookingsView()
}
