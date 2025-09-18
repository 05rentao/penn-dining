//
//  DiningHallView.swift
//  penn-dining
//
//  Created by Ren Tao on 9/17/25.
//

import SwiftUI

enum Tab {
    case menu
    case hours
    case location
}

struct DiningHallView: View {
    let diningHall: DiningHall
    @State private var currentTab: Tab = .menu
    
    var body: some View {
        VStack {
            HStack(alignment: .bottom){
                VStack(alignment: .leading){
                    Text(diningHall.name)
                        .font(.title)
                    Text("Welcome to \(diningHall.name)!")
                }
                Spacer()
                Button {
                    // TODO: add star mechanism
                    
                } label: {
                    Image(systemName: "star")
                }
                Button {
                    // TODO: add share mechanism
                    
                } label: {
                    Image(systemName: "square.and.arrow.up")
                }
                
            }
            .padding()
            
            Divider()
            HStack{
                Button("Menu") {
                    currentTab = .menu
                }
                Button("Hours") {
                    currentTab = .hours
                }
                Button("Location") {
                    currentTab = .location
                }
            }
            Divider()

            if currentTab == .menu {
                MenuView()
            } else if currentTab == .hours {
                HoursView()
            } else {
                LocationView()
            }
            Spacer()
        }
    }
}

#Preview {
    DiningHallView(diningHall: DiningHall(name: "Commons"))
}
