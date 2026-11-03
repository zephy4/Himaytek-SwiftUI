import Foundation

// MARK: - VendorsResponse
struct VendorsResponse: Codable {
    let success: Bool?
    let data: VendorsPayload?
    let pagination: Pagination?
    let filtersApplied: FiltersApplied?
    let message: String?

    enum CodingKeys: String, CodingKey {
        case success
        case data
        case pagination
        case filtersApplied = "filters_applied"
        case message
    }

    var vendors: [Datum] {
        data?.items ?? []
    }
}

// The API sends `data` as an object, not an array.
// Common shapes:
// { "data": [vendors], "current_page": 1, ... }
// { "vendors": [vendors] }
struct VendorsPayload: Codable {
    let items: [Datum]
    let pagination: Pagination?

    enum CodingKeys: String, CodingKey {
        case data
        case vendors
        case items
        case pagination
        case currentPage = "current_page"
        case lastPage = "last_page"
        case perPage = "per_page"
        case total
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        items = Self.decodeVendorArray(from: container)

        if let nested = try? container.decode(Pagination.self, forKey: .pagination) {
            pagination = nested
        } else {
            pagination = Pagination(
                currentPage: try container.decodeIfPresent(Int.self, forKey: .currentPage),
                lastPage: try container.decodeIfPresent(Int.self, forKey: .lastPage),
                perPage: try container.decodeIfPresent(Int.self, forKey: .perPage),
                total: try container.decodeIfPresent(Int.self, forKey: .total)
            )
        }
    }

    private static func decodeVendorArray(
        from container: KeyedDecodingContainer<CodingKeys>
    ) -> [Datum] {
        for key in [CodingKeys.data, .vendors, .items] {
            do {
                return try container.decode([Datum].self, forKey: key)
            } catch {
                print("Vendors list key '\(key.stringValue)' is not [Datum]: \(error)")
            }

            if let nested = try? container.nestedContainer(
                keyedBy: CodingKeys.self,
                forKey: key
            ) {
                let nestedItems = decodeVendorArray(from: nested)
                if !nestedItems.isEmpty {
                    return nestedItems
                }
            }
        }
        return []
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(items, forKey: .data)
        try container.encodeIfPresent(pagination, forKey: .pagination)
    }
}

// MARK: - Datum
struct Datum: Codable, Hashable {
    let id: Int?
    let name: String?
    let companyName: String?
    let address: String?
    let latitude: Double?
    let longitude: Double?
    let contactPhone: String?
    let aboutUs: String?
    let logo: String?
    let coverImage: String?
    let vendorStatus: String?
    let distance: Double?
    let servicesCount: Int?
    let averageRating: Double?
    let totalReviews: Int?
    let createdAt: String?
    let updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case companyName = "company_name"
        case address
        case latitude
        case longitude
        case contactPhone = "contact_phone"
        case aboutUs = "about_us"
        case logo
        case coverImage = "cover_image"
        case vendorStatus = "vendor_status"
        case distance
        case servicesCount = "services_count"
        case averageRating = "average_rating"
        case totalReviews = "total_reviews"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = container.decodeFlexibleInt(.id)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        companyName = try container.decodeIfPresent(String.self, forKey: .companyName)
        address = try container.decodeIfPresent(String.self, forKey: .address)
        latitude = container.decodeFlexibleDouble(.latitude)
        longitude = container.decodeFlexibleDouble(.longitude)
        contactPhone = container.decodeFlexibleString(.contactPhone)
        aboutUs = try container.decodeIfPresent(String.self, forKey: .aboutUs)
        logo = try container.decodeIfPresent(String.self, forKey: .logo)
        coverImage = try container.decodeIfPresent(String.self, forKey: .coverImage)
        vendorStatus = try container.decodeIfPresent(String.self, forKey: .vendorStatus)
        distance = container.decodeFlexibleDouble(.distance)
        servicesCount = container.decodeFlexibleInt(.servicesCount)
        averageRating = container.decodeFlexibleDouble(.averageRating)
        totalReviews = container.decodeFlexibleInt(.totalReviews)
        createdAt = try container.decodeIfPresent(String.self, forKey: .createdAt)
        updatedAt = try container.decodeIfPresent(String.self, forKey: .updatedAt)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(companyName, forKey: .companyName)
        try container.encodeIfPresent(address, forKey: .address)
        try container.encodeIfPresent(latitude, forKey: .latitude)
        try container.encodeIfPresent(longitude, forKey: .longitude)
        try container.encodeIfPresent(contactPhone, forKey: .contactPhone)
        try container.encodeIfPresent(aboutUs, forKey: .aboutUs)
        try container.encodeIfPresent(logo, forKey: .logo)
        try container.encodeIfPresent(coverImage, forKey: .coverImage)
        try container.encodeIfPresent(vendorStatus, forKey: .vendorStatus)
        try container.encodeIfPresent(distance, forKey: .distance)
        try container.encodeIfPresent(servicesCount, forKey: .servicesCount)
        try container.encodeIfPresent(averageRating, forKey: .averageRating)
        try container.encodeIfPresent(totalReviews, forKey: .totalReviews)
        try container.encodeIfPresent(createdAt, forKey: .createdAt)
        try container.encodeIfPresent(updatedAt, forKey: .updatedAt)
    }
}

private extension KeyedDecodingContainer where K == Datum.CodingKeys {
    func decodeFlexibleInt(_ key: K) -> Int? {
        if let value = try? decode(Int.self, forKey: key) { return value }
        if let value = try? decode(Double.self, forKey: key) { return Int(value) }
        if let value = try? decode(String.self, forKey: key) { return Int(value) }
        return nil
    }

    func decodeFlexibleDouble(_ key: K) -> Double? {
        if let value = try? decode(Double.self, forKey: key) { return value }
        if let value = try? decode(Int.self, forKey: key) { return Double(value) }
        if let value = try? decode(String.self, forKey: key) { return Double(value) }
        return nil
    }

    func decodeFlexibleString(_ key: K) -> String? {
        if let value = try? decode(String.self, forKey: key) { return value }
        if let value = try? decode(Int.self, forKey: key) { return String(value) }
        return nil
    }
}

// MARK: - FiltersApplied
struct FiltersApplied: Codable {
    let search: String?
    let sortBy: String?
    let serviceTypes: [Int]?
    let radius: Int?
    let minRating: Int?

    enum CodingKeys: String, CodingKey {
        case search
        case sortBy = "sort_by"
        case serviceTypes = "service_types"
        case radius
        case minRating = "min_rating"
    }
}

// MARK: - Pagination
struct Pagination: Codable {
    let currentPage: Int?
    let lastPage: Int?
    let perPage: Int?
    let total: Int?

    enum CodingKeys: String, CodingKey {
        case currentPage = "current_page"
        case lastPage = "last_page"
        case perPage = "per_page"
        case total
    }
}
