//
//  penn_diningApp.swift
//  penn-dining
//
//  Created by Ren Tao on 9/17/25.
//

import SwiftUI
import SwiftData

@main
struct penn_diningApp: App {
    @State var diningHallViewModel = DiningHallViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(diningHallViewModel)
                
        }
    }
}
