//
//  DiningHall.swift
//  penn-dining
//
//  Created by Ren Tao on 9/17/25.
//

struct DiningHall: Hashable, Identifiable {
    let name: String
    var id: String { name }
    
}
