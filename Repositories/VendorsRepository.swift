import Combine
import SwiftUI

class VendorsRepository: ObservableObject {

    static let instance = VendorsRepository()

    //    let token = UserDefaults.standard.string(forKey: StorageKeys.accessToken)
    let token = "3|F9wgEM0MZdkEn9VIHrBQMx7tOwACYv8AHHzvFb5L1088cfa7"

    func getVendors() async throws -> VendorsResponse {

        let baseURL = APIConfig.currentEnvironment.baseURL
        let url = baseURL.appendingPathComponent(Endpoints.vendors)
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        request.setValue(
            "Bearer \(token)",
            forHTTPHeaderField: "Authorization"
        )
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        print("Vendors Status: \(httpResponse.statusCode)")
        let body = String(data: data, encoding: .utf8)
        print("Vendors API COMPLETE: \(body)")
        return try JSONDecoder().decode(VendorsResponse.self, from: data)
    }

    func getVendorsDetails(id: Int) async throws -> VendorsDetails {

        let baseURL = APIConfig.currentEnvironment.baseURL
        let url = baseURL.appendingPathComponent("\(Endpoints.vendorsDetails)/\(id)")
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        print("Vendor details GET \(url.absoluteString)")

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }

        let body = String(data: data, encoding: .utf8) ?? "<no body>"
        print("Vendor details status \(httpResponse.statusCode)")
        print("Vendor details body: \(body)")

        guard (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }

        return try JSONDecoder().decode(VendorsDetails.self, from: data)
    }

}
