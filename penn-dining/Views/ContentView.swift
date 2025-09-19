//
//  ContentView.swift
//  penn-dining
//
//  Created by Ren Tao on 9/17/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(DiningHallViewModel.self) var diningHallViewModel
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading){
                    Text("Favorites")
                        .font(.title)
                    VStack(alignment: .leading) {
                        Divider()
                        ForEach(diningHallViewModel.diningHalls.filter { diningHall in
                            diningHallViewModel.favorites.contains(diningHall.id)
                        }) { diningHall in
                            NavigationLink(value: diningHall) {
                                RowView(diningHall: diningHall)
                            }
                            Divider()
                        }
                    }
                    .navigationTitle("Penn Dining")
                    .navigationDestination(for: DiningHall.self) { diningHall in
                        DiningHallView(diningHall: diningHall)
                    }
                    Text("Penn Dining")
                        .font(.title)
                        .padding(.top)
                    VStack(alignment: .leading) {
                        Divider()
                        ForEach(diningHallViewModel.diningHalls.filter { diningHall in
                            !diningHallViewModel.favorites.contains(diningHall.id)
                        }) { diningHall in
                            NavigationLink(value: diningHall) {
                                RowView(diningHall: diningHall)
                            }
                            Divider()
                        }
                    }
                    
                }
                .padding()
            }
        }
    }
}
    
struct RowView: View {
    @Environment(DiningHallViewModel.self) var diningHallViewModel
    let diningHall: DiningHall
    
    var body: some View {
        HStack(alignment: .center){
            if let image = diningHallViewModel.images[diningHall.id] {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            } else {
                ProgressView()
            }
            
            
            HStack(alignment: .center) {
                VStack(alignment: .leading) {
                    let status = diningHallViewModel.status[diningHall.id]
                    Text(status ?? "N/A").font(.caption)
                            .padding(.horizontal, 4)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(2)
                    Text(diningHall.name)
                        .multilineTextAlignment(.leading)
                        .font(.headline)
                        .padding(.vertical, 2)
                    let day = diningHall.days[0]
                    HStack{
                        ForEach(day.dayparts) { dayPart in
                            let times = diningHallViewModel.getIntervalString(dayPart: dayPart) // [String, String]
                            
                            Text("\(times[0]) - \(times[1])")
                                .font(.caption)
                                .padding(.horizontal, 2)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(2)
                        }
                    }
                }
                
                Spacer()
                Image(systemName: "chevron.right")
            }
            .foregroundColor(.primary)
            .padding(.leading, 5)
            .padding(.top, 5)
        }
        
    }
}

#Preview {
    @Previewable @State var diningHallViewModel = DiningHallViewModel()

    ContentView()
        .environment(diningHallViewModel)
}
