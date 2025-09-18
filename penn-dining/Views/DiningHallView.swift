//
//  DiningHallView.swift
//  penn-dining
//
//  Created by Ren Tao on 9/17/25.
//

import SwiftUI


struct DiningHallView: View {
    let diningHall: DiningHall
    @State private var currentTab: Int = 0
    
    var body: some View {
        VStack {
            Text(diningHall.name)
                .font(.title)
            Text("Welcome to \(diningHall.name)!")
            Divider()
            HStack{
                
            }
            
            
        }
        .navigationTitle(diningHall.name)

    }
}

#Preview {
    DiningHallView(diningHall: DiningHall(name: "Commons"))
}
