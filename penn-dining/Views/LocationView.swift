//
//  LocationView.swift
//  penn-dining
//
//  Created by Ren Tao on 9/18/25.
//

import SwiftUI

struct LocationView: View {
    @Environment(DiningHallViewModel.self) var diningHallViewModel
    @State var diningHall: DiningHall
    
    var body: some View {
        Text("Location of ___! ")
    }
}

#Preview {
    @Previewable @State var diningHallViewModel = DiningHallViewModel()
    
    LocationView(diningHall: DiningHall.mock[0])
        .environment(diningHallViewModel)
}
