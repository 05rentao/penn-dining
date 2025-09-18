//
//  DiningHallViewModel.swift
//  penn-dining
//
//  Created by Ren Tao on 9/18/25.
//
import Foundation
import SwiftUI
import Observation

@Observable class DiningHallViewModel {
    var diningHalls: [DiningHallJSON] = []
    
    init() {
        Task {
            await getDiningHalls()
        }
    }
    
    func getDiningHalls() async {
        do {
            self.diningHalls = try await APIManager.instance.getDiningHalls()
        } catch let error {
            print("error fetching dining hall api: " + error.localizedDescription)
        }
    }
}
