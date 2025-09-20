//
//  DiningHallView.swift
//  penn-dining
//
//  Created by ____ on 9/17/25.
//

import SwiftUI
import SafariServices

enum ActiveSheet: Identifiable {
    case message, website, menu
    
    var id: Int {
        hashValue
    }
}

struct DiningHallView: View {
    @Environment(DiningHallViewModel.self) var diningHallViewModel
    
    let diningHall: DiningHall
    @State private var activeSheet: ActiveSheet?



    
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
                        let status = diningHallViewModel.status[diningHall.id]
                        Text(status ?? "N/A").font(.caption)
                                .padding(.horizontal, 4)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(2)
                        
                        HStack {
                            Text(diningHall.name)
                                .font(.title)
                                .bold()
                            
                            if (diningHallViewModel.favorites.contains(diningHall.id)) {
                                Button {
                                    diningHallViewModel.removeFavorite(diningHall.id)
                                } label: {
                                    Image(systemName: "heart.fill")
                                        .padding(.top, 3)
                                        .font(.system(size:25))
                                        .foregroundStyle(.red)

                                }
                                
                            } else {
                                Button {
                                    diningHallViewModel.addFavorite(diningHall.id)
                                } label: {
                                    Image(systemName: "heart")
                                        .padding(.top, 3)
                                        .font(.system(size:25))
                                        .foregroundStyle(.primary)


                                }
                            }
                            
                        }
                        Text(diningHall.address)
                        
                        
                        HStack {
                            let rating = diningHallViewModel.ratings[diningHall.id]
                            
                            ForEach(1...5, id: \.self) { number in
                                Image(systemName: number <= (rating ?? 0) ? "star.fill" : "star")
                                    .foregroundStyle(.yellow)
                                    .font(.system(size:20))
                                    .onTapGesture {
                                        for diningHall in diningHallViewModel.diningHalls {
                                            print(diningHall.name, diningHall.id)
                                        }
                                        diningHallViewModel.setRating(diningHall, rating: number)
                                    }
                            }
                            Text("(\(rating ?? 0))")
                            
                        }
                        .padding(.top, 5)
                        
                        HStack(alignment: .center) {
                            Button("Menu") {
                                activeSheet = .menu
                            }
                            
                            Divider()
                            
                            Button("Directions") {
                                if let url = URL(string: "http://maps.apple.com/?q=\(diningHall.address)") {
                                            UIApplication.shared.open(url)
                                        }
                            }
                            
                            Divider()

                            Button("Website") {
                                activeSheet = .website
                            }

                        }
                        .padding(.vertical, 5)
                    }
                    
                    Spacer()
                    
                    HStack{
                        
                        Button {
                            activeSheet = .message
                        } label: {
                            Image(systemName: "square.and.arrow.up")
                        }
                    }
                    .padding(10)
                    
                }
                .padding()
                
                VStack(alignment: .center) {
                    HStack {
                        
                        
                    }
                    Divider()
                }
                .padding(.horizontal)

                HoursView(diningHall: diningHall)
                    .frame(maxWidth: .infinity)
                
                Spacer()
            }
        }
        .sheet(item: $activeSheet) { sheet in
                switch sheet {
                case .message:
                    MessageComposeView(message: "u tryna fine dine at \(diningHall.name) rn bro")
                case .menu:
                    SafariView(url: URL(string: "https://university-of-pennsylvania.cafebonappetit.com")!)
                    // SafariView(url: URL(string: diningHallViewModel.menus[diningHall.id])!)
                case .website:
                    SafariView(url: URL(string: diningHallViewModel.websites[diningHall.id] ?? "https://dining.business-services.upenn.edu/locations-hours-menus/locations")!)
                    // SafariView(url: URL(string: diningHallViewModel.menus[diningHall.id])!)
                }
            }
        
    }
        
}


#Preview {
    @Previewable @State var diningHallViewModel = DiningHallViewModel()
    
    DiningHallView(diningHall: DiningHall.mock[0])
        .environment(diningHallViewModel)
}
