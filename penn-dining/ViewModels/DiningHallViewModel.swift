//
//  DiningHallViewModel.swift
//  penn-dining
//
//  Created by Ren Tao on 9/18/25.
//
import Foundation
import SwiftUI
import Observation

@Observable class DiningHallViewModel: Observable {
    
    var diningHalls: [DiningHall] = []
    var favorites: [Int] = []
    
    init() {
        Task {
            await getDiningHalls()
        }
    }
    
    func getDiningHalls() async {
        do {
            self.diningHalls = try await APIManager.instance.getDiningHalls()
        } catch let error {
            print("error fetching dining hall APIs: " + error.localizedDescription)
        }
    }
    
    // ---- favorites functionality -----
    
    func addFavorite(_ id: Int) {
        favorites.append(id)
    }
    
    func removeFavorite(_ id: Int) {
        favorites.removeAll { $0 == id }
    }
}
