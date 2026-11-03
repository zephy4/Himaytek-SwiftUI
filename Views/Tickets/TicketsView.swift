import SwiftUI

struct TicketsView: View {
    @StateObject var vm = TicketsViewModel()
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            NewCommonAppbar(title: "Tickets")
            ScrollView {
                TicketsSection(vm: vm)
            }
        }
        .navigationBarBackButtonHidden()
        .padding(.horizontal, 20)
        .task {
            await vm.loadTickets()
        }
    }

}

struct TicketsSection: View {
    @ObservedObject var vm: TicketsViewModel
    var body: some View {
        ForEach(vm.tickets) { item in
            VStack(alignment: .leading) {
                HStack {
                    if item.status == "open" {
                        Text("Open")
                            .font(.custom("Urbanist-Regular", size: 12))
                            .foregroundStyle(.white)
                            .padding(10)
                            .background(.green.opacity(0.5))
                            .cornerRadius(8)

                    }
                    Text("\(item.ticketNumber ?? "")")
                }
                Text(item.description ?? "").font(
                    .custom("Urbanist-Regular", size: 14)
                )
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .frame(width: 355)
                    .foregroundStyle(
                        .gray.opacity(0.1)
                    )
                    .cornerRadius(8)
            )
        }
    }
}

#Preview {
    TicketsView()
}
