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
    @Environment(DiningHallViewModel.self) var diningHallViewModel
    
    let diningHall: DiningHall
    @State private var currentTab: Tab = .menu
    
    var body: some View {
        VStack {
            if let image = diningHallViewModel.images[diningHall.id] {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else {
                ProgressView() 
            }
            
            HStack(alignment: .bottom){
                
                VStack(alignment: .leading){
                    Text(diningHall.days[0].status)
                    Text(diningHall.name)
                        .font(.title)
                    Text("Welcome to \(diningHall.name)!")
                }
                
                Spacer()
                
                if (diningHallViewModel.favorites.contains(diningHall.id)) {
                    Button {
                        diningHallViewModel.removeFavorite(diningHall.id)
                    } label: {
                        Image(systemName: "star.fill")
                    }
                } else {
                    Button {
                        diningHallViewModel.addFavorite(diningHall.id)
                    } label: {
                        Image(systemName: "star")
                    }
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
                MenuView(diningHall: diningHall)
            } else if currentTab == .hours {
                HoursView(diningHall: diningHall)
            } else {
                LocationView(diningHall: diningHall)
            }
            Spacer()
        }
    }
}

#Preview {
    @Previewable @State var diningHallViewModel = DiningHallViewModel()
    
    DiningHallView(diningHall: DiningHall.mock[0])
        .environment(diningHallViewModel)
}
