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
    let diningHalls = [DiningHall(name: "Hill"), DiningHall(name: "Commons"), DiningHall(name: "Kcheh")]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    Spacer(minLength: 25)
                    Divider()
                    ForEach(diningHalls) { diningHall in
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
            
//            Section {
//                List(diningHalls) { diningHall in
//                    RowView(diningHall: diningHall)
//                }
//            }
        }
    }
}

struct RowView: View {
    let diningHall: DiningHall
    
    var body: some View {
        HStack{
            VStack(alignment: .leading) {
                Text("open")
                    .font(.caption)
                Text(diningHall.name)
                    .font(.title)
                Text("hours: ____")
            }
            
            .padding()
            Spacer()
            Image(systemName: "chevron.right")
            }
        .foregroundColor(.primary)
        .padding(.trailing, 20)
        .padding()
        
        }
    }
}

#Preview {
    @Previewable @State var diningHallViewModel = DiningHallViewModel()

    ContentView()
}
