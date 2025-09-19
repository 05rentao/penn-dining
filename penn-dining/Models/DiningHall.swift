//
//  DiningHall.swift
//  penn-dining
//
//  Created by Ren Tao on 9/17/25.
//

import Foundation

struct DiningHall: Hashable, Identifiable {
    let name: String
    var id: String { name }
    // TODO: move all uses of this class over to JSON version
}

struct DiningHallJSON: Identifiable, Decodable, Hashable {
    
    let name: String
    let address: String
    let days: [Days]
    let image: String
    let id: Int
}

struct Days: Decodable, Hashable {
    let date: String
    let status: String
    let dayparts: [DayParts]
}

struct DayParts: Decodable, Hashable {
    let starttime: String
    let endtime: String
    let message: String
    let label: String // breakfast/lunch/dinner
}
