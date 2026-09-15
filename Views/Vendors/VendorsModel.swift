// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let vendorsResponse = try? JSONDecoder().decode(VendorsResponse.self, from: jsonData)

import Foundation

// MARK: - VendorsResponse
struct VendorsResponse: Codable {
    let success: Bool?
    let data: [Datum]?
    let pagination: Pagination?
    let filtersApplied: FiltersApplied?
    let message: String?
    
    enum CodingKeys: String, CodingKey {
        case success = "success"
        case data = "data"
        case pagination = "pagination"
        case filtersApplied = "filters_applied"
        case message = "message"
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
        case id = "id"
        case name = "name"
        case companyName = "company_name"
        case address = "address"
        case latitude = "latitude"
        case longitude = "longitude"
        case contactPhone = "contact_phone"
        case aboutUs = "about_us"
        case logo = "logo"
        case coverImage = "cover_image"
        case vendorStatus = "vendor_status"
        case distance = "distance"
        case servicesCount = "services_count"
        case averageRating = "average_rating"
        case totalReviews = "total_reviews"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
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
        case search = "search"
        case sortBy = "sort_by"
        case serviceTypes = "service_types"
        case radius = "radius"
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
        case total = "total"
    }
}



