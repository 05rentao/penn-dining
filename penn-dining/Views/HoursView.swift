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
        VStack(alignment: .leading) {
            Text("Hours:")
                .font(.headline)
            ForEach( diningHall.days) { day in
                HStack {
                    Text("\(diningHallViewModel.dayOfWeek(dateString: day.date)): ")
                    ForEach(day.dayparts) { dayPart in
                        ForEach(diningHallViewModel.getInterval(dayPart: dayPart)) { time in
                            Text(time)
                        }
                        
                    }
                }
            }
        }
        
    }
}



#Preview {
    @Previewable @State var diningHallViewModel = DiningHallViewModel()
    
    HoursView(diningHall: DiningHall.mock[0])
        .environment(diningHallViewModel)
}
