import SwiftUI

struct FavoritesView: View {

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
                Text("noFavs").font(
                    .custom("Urbanist-Regular", size: 20)
                )
                Text("addfavs")
                    .font(.custom("Urbanist-Regular", size: 16))
                    .multilineTextAlignment(.center)
                NavigationLink {
                    VendorsView()
                } label: {
                    RoundedRectangle(cornerRadius: 10).fill(.accent).frame(
                        width: 190,
                        height: 60,
                        alignment: .center
                    ).overlay(
                        Text("exploreVendors").foregroundColor(.white)
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
    NavigationStack {
        FavoritesView()
    }
}
