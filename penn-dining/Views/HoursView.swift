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
        Text("Hours")
        // Text(diningHall.days)
    }
}

#Preview {
    @Previewable @State var diningHallViewModel = DiningHallViewModel()
    
    HoursView(diningHall: DiningHall.mock[0])
        .environment(diningHallViewModel)
}
