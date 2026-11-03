import Combine
import SwiftUI

class VendorsViewModel: ObservableObject {
    @Published var showReviews: Bool = false
    @Published var isLiked: Bool = false

    let repo = VendorsRepository.instance

    var isLoading = true
    var errorMessage = ""

    @Published var vendors: [Datum] = []
    @Published var vendorDetails: VendorsDetailsData? = nil

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

    @MainActor
    func loadVendors() async {
        isLoading = true
        errorMessage = ""
        defer { isLoading = false }

        do {
            let response = try await repo.getVendors()
            vendors = response.vendors
            print("Assigned vendors count: \(vendors.count)")
        } catch {
            errorMessage = error.localizedDescription
            print("Failed to load vendors: \(error)")
        }
    }

    @MainActor
    func loadDetails(id: Int) async {
        print("loadDetails called for id: \(id)")
        isLoading = true
        errorMessage = ""
        defer { isLoading = false }
        do {
            let response = try await repo.getVendorsDetails(id: id)
            vendorDetails = response.data
            print("Assigned vendor details: \(vendorDetails?.name ?? "nil")")
        } catch {
            errorMessage = error.localizedDescription
            print("Failed to Load vendor details: \(error)")
        }
    }
}
