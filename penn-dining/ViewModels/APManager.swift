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
    
    // TODO: Add backup API
    
    func getDiningHalls() async throws -> [DiningHallJSON] {
        let url = URL(string: "https://pennmobile.org/api/dining/venues/?format=json")!
        // TODO: handle optional unpacking
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        // print(String(data: data, encoding: .utf8) ?? "defauly val")
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode >= 200, httpResponse.statusCode <= 299 else {
            throw NetworkError.networkError
        }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        do {
            return try decoder.decode([DiningHallJSON].self, from: data)
        } catch let decodingError as DecodingError {
            print(decodingError)
            throw decodingError
        }
        
        
    }
    
}
