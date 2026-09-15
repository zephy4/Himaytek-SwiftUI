import Combine
import SwiftUI

class VendorsViewModel: ObservableObject {
    @Published var showReviews: Bool = false
    @Published var isLiked: Bool = false

    let token = UserDefaults.standard.string(forKey: StorageKeys.accessToken)

    var isLoading = true
    var errorMessage = ""

    //    init() async {
    //        await loadVendors()
    //    }

    @Published var categories: [CategoriesModel] = [
        CategoriesModel(
            id: "1",
            title: "Paint Protection",
            avatar: "protection"
        ),
        CategoriesModel(
            id: "2",
            title: "Car wash",
            avatar: "wash"
        ),
        CategoriesModel(
            id: "3",
            title: "Maintenance",
            avatar: "maintenance"
        ),
        CategoriesModel(
            id: "4",
            title: "Paint Protection",
            avatar: "protection"
        ),
    ]

    @Published var vendors: [Datum] = []

    func fetchVendors() async throws -> VendorsResponse {
        let baseURL = APIConfig.currentEnvironment.baseURL
        let url = baseURL.appendingPathComponent(Endpoints.vendors)
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        request.setValue(
            "Bearer \(token ?? "3|F9wgEM0MZdkEn9VIHrBQMx7tOwACYv8AHHzvFb5L1088cfa7")",
            forHTTPHeaderField: "Authorization"
        )

        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse,
            (200...299).contains(httpResponse.statusCode)
        else {
            throw URLError(.badServerResponse)
        }
        return try JSONDecoder().decode(VendorsResponse.self, from: data)
    }

    func loadVendors() async {
        do {
            let response = try await fetchVendors()
            self.vendors = response.data ?? []
        } catch {
            self.errorMessage = error.localizedDescription
            print("Failed to load vendors: \(error)")
        }

        isLoading = false
    }
}
