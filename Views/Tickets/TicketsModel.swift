// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let ticketsModel = try? JSONDecoder().decode(TicketsModel.self, from: jsonData)

import Foundation

// MARK: - TicketsModel
struct TicketsModel: Codable {
    let success: Bool?
    let message: String?
    let code: Int?
    let data: DataClass?
}

// MARK: - DataClass
struct DataClass: Codable {
    let tickets: [Ticket]?
    let pagination: Pagination?
}
// MARK: - Ticket
struct Ticket: Codable, Identifiable, Hashable {
    let id: Int?
    let ticketNumber, description, category, categoryLabel: String?
    let status, statusLabel: String?
    let submittedAt: Date?
    let resolvedAt: String?
    let attachments: [String]?
    let createdAt, updatedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case ticketNumber
        case description, category
        case categoryLabel
        case status
        case statusLabel
        case submittedAt
        case resolvedAt
        case attachments
        case createdAt
        case updatedAt
    }
}

// MARK: - TicketsRequest
struct TicketsRequest: Codable {
    let description, category: String?
    let attachments: [String]?
}
