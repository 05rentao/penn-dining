//
//  APIManager.swift
//  penn-dining
//
//  Created by Ren Tao on 9/18/25.
//

import Foundation

enum NetworkError: String, Error {
    case networkError
    // TODO: more cases?
}

class APIManager {
    static let instance = APIManager()
    
    func getDiningHalls() async throws -> [DiningHallJSON] {
        let url = URL(string: "https://pennmobile.org/api/dining/venues/?format=api")!
        // TODO: handle optional unpacking
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode >= 200, httpResponse.statusCode <= 299 else {
            throw NetworkError.networkError
        }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601

        return try decoder.decode([DiningHallJSON].self, from: data)
    }
    
}
