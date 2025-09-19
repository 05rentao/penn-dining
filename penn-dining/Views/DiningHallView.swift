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
    @State private var showMessageSheet = false

    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading) {
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
                            .font(.caption)
                            .padding(2)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(4)
                        Text(diningHall.name)
                            .font(.title)
                            .bold()
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
                        showMessageSheet = true
                    } label: {
                        Image(systemName: "square.and.arrow.up")
                    }
                    
                }
                .padding()
                
                VStack(alignment: .leading) {
                    Divider()
                    HStack {

                        Button("Hours") {
                            currentTab = .hours
                        }
                        Button("Menu") {
                            currentTab = .menu
                        }
                        Button("Location") {
                            currentTab = .location
                        }

                    }
                    Divider()
                }
                .padding()

                if currentTab == .menu {
                    MenuView(diningHall: diningHall)
                } else if currentTab == .hours {
                    HoursView(diningHall: diningHall)
                        .frame(maxWidth: .infinity)
                } else {
                    LocationView(diningHall: diningHall)
                }
                Spacer()
            }
        }
        .sheet(isPresented: $showMessageSheet) {
            MessageComposeView(message: "u tryna fine dine at \(diningHall.name) rn bro")
                }
        
    }
        
}

#Preview {
    @Previewable @State var diningHallViewModel = DiningHallViewModel()
    
    DiningHallView(diningHall: DiningHall.mock[0])
        .environment(diningHallViewModel)
}
