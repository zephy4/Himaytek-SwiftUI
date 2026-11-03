import Combine
import SwiftUI

@MainActor
class TicketsViewModel: ObservableObject {

    let repo = SupportRepository.instance

    @Published var tickets: [Ticket] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String = ""

    func loadTickets() async {
        isLoading = true
        defer { isLoading = false }

        do {
            let response = try await repo.getTickets()

            tickets = response.data?.tickets ?? []
        } catch {
            errorMessage = error.localizedDescription
            print("Failed to load vendors: \(error)")
        }
    }

}
