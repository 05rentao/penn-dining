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

struct DiningHallJSON: Identifiable, Decodable {
    let name: String
    let address: String
    let days: [Days]
    let image: String
    let id: UUID
}

struct Days: Decodable {
    let date: String
    let status: String
    let dayparts: [DayParts]
}

struct DayParts: Decodable {
    let starttime: String
    let endtime: String
    // skipped message, not sure what is
    let label: String // breakfast/lunch/dinner
}
