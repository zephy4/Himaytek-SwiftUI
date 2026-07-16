import SwiftUI

struct CommonAppbar: View {
    @State var text: String
    var body: some View {
        HStack(alignment: .center) {
            Text(text).font(
                .custom("Urbanist-Regular", fixedSize: 16)
            )
            Spacer()
            Button(action: {}) {
                Image(systemName: "magnifyingglass").foregroundColor(
                    .primary
                )
                .font(.title3)
            }
            Button(action: {
                //                        settingsButton = 2
            }) {
                Image(systemName: "gear").foregroundColor(.primary)
                    .font(.title3)
            }
        }.padding(.horizontal)
    }
}

#Preview {
    CommonAppbar(text: "Favorites")
}
