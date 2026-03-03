//
//  BookingViewModel.swift
//  Food
//
//  Created by Janzen Houchen-Wilder on 1/6/26.
//

import Foundation

@MainActor
final class BookingViewModel: ObservableObject {
    @Published var booking: Booking?
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let apiClient = APIClient()

    func load() async {
        isLoading = true
        errorMessage = nil

        do {
            let result = try await apiClient.fetchGet()
            booking = result
        } catch {
            errorMessage = (error as? LocalizedError)?.errorDescription
                ?? error.localizedDescription
        }

        isLoading = false
    }
}
