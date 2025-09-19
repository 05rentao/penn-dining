//
//  HoursView.swift
//  penn-dining
//
//  Created by Ren Tao on 9/18/25.
//

import SwiftUI

struct HoursView: View {
    @Environment(DiningHallViewModel.self) var diningHallViewModel
    @State var diningHall: DiningHall
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ForEach( diningHall.days) { day in
                    VStack(alignment: .leading) {
                        let dayLabel = diningHallViewModel.dayOfWeek(dateString: day.date)
                        Text(dayLabel + ":")
                            .font(.subheadline)
                            .bold()
                        
                        HStack{
                            if day.dayparts.isEmpty {
                                Text("Closed")
                                    .font(.caption)
                                    .padding(4)
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(4)
                            } else {
                                ForEach(day.dayparts) { dayPart in
                                    let times = diningHallViewModel.getIntervalString(dayPart: dayPart) // [String, String]
                                    
                                    Text("\(times[0]) - \(times[1])")
                                        .font(.caption)
                                        .padding(4)
                                        .background(Color.gray.opacity(0.2))
                                        .cornerRadius(4)
                                }
                            }
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        }
        
    }
}



#Preview {
    @Previewable @State var diningHallViewModel = DiningHallViewModel()
    
    HoursView(diningHall: DiningHall.mock[0])
        .environment(diningHallViewModel)
}
