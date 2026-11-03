import Combine
import SwiftUI

class SupportRepository {
    static let instance = SupportRepository()
    let token = "3|F9wgEM0MZdkEn9VIHrBQMx7tOwACYv8AHHzvFb5L1088cfa7"

    func getTickets() async throws -> TicketsModel {
        let baseURL = APIConfig.currentEnvironment.baseURL
        let url = baseURL.appendingPathComponent(Endpoints.tickets)
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let response = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        let jsonBody = String(data: data, encoding: .utf8)
        print("Tickets API: \(jsonBody)")
        return try JSONDecoder().decode(TicketsModel.self, from: data)
    }

    func createTicket(with details: TicketsRequest) async throws
        -> TicketsModel
    {
        let baseURL = APIConfig.currentEnvironment.baseURL
        let url = baseURL.appendingPathComponent(Endpoints.tickets)
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue(
            ContentType.json.rawValue,
            forHTTPHeaderField: HTTPHeaderField.contentType.rawValue
        )
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        do {
            request.httpBody = try JSONEncoder().encode(details)
            print("Ticket Submitted: \(details)")
        } catch {
            print("Encoding error: \(error)")
            throw error
        }

        let (data, response) = try await URLSession.shared.data(for: request)
        guard let response = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        return try JSONDecoder().decode(TicketsModel.self, from: data)
    }
}
