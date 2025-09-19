//
//  MenuView.swift
//  penn-dining
//
//  Created by Ren Tao on 9/18/25.
//

import SwiftUI

struct MenuView: View {
    @Environment(DiningHallViewModel.self) var diningHallViewModel
    @State var diningHall: DiningHall
    
    var body: some View {
        VStack (alignment: .leading) {
            Text("MENU! ")
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()

    }
}

#Preview {
    @Previewable @State var diningHallViewModel = DiningHallViewModel()
    
    MenuView(diningHall: DiningHall.mock[0])
        .environment(diningHallViewModel)

}
