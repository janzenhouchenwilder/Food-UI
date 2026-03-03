//
//  APIClient.swift
//  Food
//
//  Created by Janzen Houchen-Wilder on 1/6/26.
//

import Foundation

enum APIError: Error, LocalizedError {
    case invalidURL
    case badStatus(Int)
    case decoding(Error)

    var errorDescription: String? {
        switch self {
        case .invalidURL: return "Invalid URL"
        case .badStatus(let code): return "Bad HTTP status: \(code)"
        case .decoding(let err): return "Decoding error: \(err.localizedDescription)"
        }
    }
}

final class APIClient {
    func fetchGet() async throws -> Booking {
        guard let url = URL(string: "http://127.0.0.1:8080/bookings/Ryan") else {
            throw APIError.invalidURL
        }
        
        var request = URLRequest(url: url)
                request.httpMethod = "GET"
                request.timeoutInterval = 20
        
        let (data, response) = try await URLSession.shared.data(for: request)

        if let http = response as? HTTPURLResponse, !(200...299).contains(http.statusCode) {
            throw APIError.badStatus(http.statusCode)
        }

        do {
            return try JSONDecoder().decode(Booking.self, from: data)
        } catch {
            throw APIError.decoding(error)
        }
    }
}

extension APIClient {
    func authenticate() async throws -> AuthResponse {
        guard let url = URL(string: "https://restful-booker.herokuapp.com/auth") else {
            throw APIError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        // Body JSON
        let body: [String: String] = [
            "username": "admin",
            "password": "password123"
        ]
        request.httpBody = try JSONEncoder().encode(body)

        let (data, response) = try await URLSession.shared.data(for: request)

        if let http = response as? HTTPURLResponse, !(200...299).contains(http.statusCode) {
            throw APIError.badStatus(http.statusCode)
        }

        do {
            return try JSONDecoder().decode(AuthResponse.self, from: data)
        } catch {
            throw APIError.decoding(error)
        }
    }
}

extension APIClient {
    func getFoods(food: String) async throws -> [Food] {
        let encoded = food.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? food
        guard let url = URL(string: "http://127.0.0.1:5000/food/\(encoded)") else {
            throw APIError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        if let http = response as? HTTPURLResponse {
            print("HTTP status:", http.statusCode)
        }

        print("Raw JSON:", String(data: data, encoding: .utf8) ?? "<not utf8>")
        
        do {
            //let responseData = try JSONDecoder().decode(Foods.self, from: data)
            let decoded = try JSONDecoder().decode(FoodSearchResponse.self, from: data)
            return decoded.foods.food
        } catch {
            do {
                return try JSONDecoder().decode([Food].self, from: data)
            } catch {
                throw APIError.invalidURL
            }
        }
    }
}
