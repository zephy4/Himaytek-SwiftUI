import SwiftUI

struct SupportAndHelpCenter: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            NewCommonAppbar(title: "Support & Help Center")
            ScrollView {
                tickets
            }
        }
        .navigationBarBackButtonHidden()
        .padding(.horizontal, 20)
    }

    private var tickets: some View {
        VStack(alignment: .leading) {
            Text("Tickets")
                .font(.custom("Urbanist-Regular", size: 16))
            SupportItem(
                title: "View My Tickets",
                navigate: AnyView(TicketsView())
            )

        }
    }
}

struct SupportItem: View {
    @State var title: String
    @State var navigate: AnyView

    var body: some View {
        HStack {
            Text(title)
                .font(.custom("Urbanist-Regular", size: 14))
                .foregroundStyle(.black)
            Spacer()
            NavigationLink {
                navigate
            } label: {
                Circle()
                    .frame(width: 40, height: 40)
                    .foregroundStyle(.white)
                    .overlay {
                        Image(systemName: "chevron.right")
                            .foregroundStyle(.black)
                    }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 350, height: 56)
                .foregroundStyle(.gray.opacity(0.1))
                .cornerRadius(10)
        )

    }
}

#Preview {
    SupportAndHelpCenter()
}
