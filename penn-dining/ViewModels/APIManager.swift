//
//  APIManager.swift
//  penn-dining
//
//  Created by ____ on 9/18/25.
//

import Foundation

enum NetworkError: String, Error {
    case networkError
}

class APIManager {
    static let instance = APIManager()
    
    func getDiningHalls() async throws -> [DiningHall] {
        let mainAPI = "https://pennmobile.org/api/dining/venues/?format=json"
        let backupAPI = "https://pennlabs.github.io/backup-data/venues.json"

        do {
            let diningHall: [DiningHall] = try await apiCall(mainAPI)
            return diningHall
        } catch {
            print("error fetching from main API: \(mainAPI): \(error.localizedDescription)")
                  let diningHall: [DiningHall] = try await apiCall(backupAPI)
                  return diningHall
        }
    }
        
    func getDiningHalls(useBackup: Bool = false) async -> [DiningHall] {
        let primaryURL = "https://pennmobile.org/api/dining/venues/?format=json"
        let backupURL  = "https://your-backup-endpoint.com/api/dining"

        do {
            let url = useBackup ? backupURL : primaryURL
            return try await apiCall(url)
        } catch {
            print("Error fetching dining halls from \(useBackup ? "backup" : "primary"): \(error)")
            
            // fallback: try the other URL automatically
            if !useBackup {
                do {
                    print("Trying backup URL…")
                    return try await apiCall(backupURL)
                } catch {
                    print("Backup also failed: \(error)")
                }
            }
            return []
        }
    }
    
    
    func apiCall<T: Decodable>(_ urlString: String) async throws -> [T] {
        let url = URL(string: urlString)!  // ik this url works
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
            return try decoder.decode([T].self, from: data)
        } catch let decodingError as DecodingError {
            print(decodingError)
            throw decodingError
        }
    }
    
}
