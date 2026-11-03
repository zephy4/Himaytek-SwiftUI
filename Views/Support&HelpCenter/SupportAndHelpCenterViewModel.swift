//
//  SupportAndHelpCenterViewModel.swift
//  Himaytek
//
//  Created by Ismaeel on 21/09/2026.
//

import Combine
import SwiftUI

class SupportAndHelpCenterViewModel: ObservableObject {
    @Published var selectedIssue: String? = nil
    @Published var description: String = ""

    let issueTypes = [
        "Billing & Payment",
        "Technical Support",
        "Account Issues",
        "General Inquiry",
    ]

    let repo = SupportRepository.instance
    var isLoading = false
    var errorMessage = ""

    func placeTicket() async {
        let body = {
            TicketsRequest(
                description: self.description,
                category: self.selectedIssue,
                attachments: nil
            )
        }
        isLoading = true
        defer {
            isLoading = false
        }

        do {
            try await repo.createTicket(with: body())
        } catch {
            print("Error: \(error)")
        }
    }
}
