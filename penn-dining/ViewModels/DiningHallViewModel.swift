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
    var images: [Int: UIImage] = [:]
    
    init() {
        Task {
            await getDiningHalls()
            await loadImage()
        }
    }
    
    func getDiningHalls() async {
        do {
            self.diningHalls = try await APIManager.instance.getDiningHalls()
        } catch let error {
            print("error fetching dining hall APIs: " + error.localizedDescription)
        }
    }
    
    func loadImage() async {
        for diningHall in diningHalls {
            let imageData = try! Data(contentsOf: URL(string: diningHall.image)!)
            self.images[diningHall.id] = UIImage(data: imageData)
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
