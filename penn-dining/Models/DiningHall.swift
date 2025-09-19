//
//  DiningHall.swift
//  penn-dining
//
//  Created by Ren Tao on 9/17/25.
//

import Foundation


struct DiningHall: Identifiable, Decodable, Hashable {
    
    let name: String
    let address: String
    let days: [Days]
    let image: String
    let id: Int
}

struct Days: Decodable, Hashable, Identifiable{
    let date: String
    let status: String
    let dayparts: [DayParts]
    
    var id: String {date}
}

struct DayParts: Decodable, Hashable, Identifiable {
    let starttime: String
    let endtime: String
    let message: String
    let label: String // breakfast/lunch/dinner
    
    var id: String {starttime}
}

extension DiningHall {
    static let mock: [DiningHall] = [
        DiningHall(
            name: "1920 Commons",
            address: "3800 Locust Walk",
            days: [
                Days(
                    date: "2025-09-18",
                    status: "open",
                    dayparts: [
                        DayParts(starttime: "2025-09-18T07:00:00", endtime: "2025-09-18T10:30:00", message: "", label: "Breakfast"),
                        DayParts(starttime: "2025-09-18T11:00:00", endtime: "2025-09-18T14:00:00", message: "", label: "Lunch"),
                        DayParts(starttime: "2025-09-18T17:00:00", endtime: "2025-09-18T21:30:00", message: "", label: "Dinner")
                    ]
                ),
                Days(
                    date: "2025-09-19",
                    status: "open",
                    dayparts: [
                        DayParts(starttime: "2025-09-19T07:00:00", endtime: "2025-09-19T10:30:00", message: "", label: "Breakfast"),
                        DayParts(starttime: "2025-09-19T11:00:00", endtime: "2025-09-19T14:00:00", message: "", label: "Lunch"),
                        DayParts(starttime: "2025-09-19T17:00:00", endtime: "2025-09-19T20:00:00", message: "", label: "Dinner")
                    ]
                ),
                Days(
                    date: "2025-09-20",
                    status: "open",
                    dayparts: [
                        DayParts(starttime: "2025-09-20T10:00:00", endtime: "2025-09-20T15:00:00", message: "", label: "Brunch"),
                        DayParts(starttime: "2025-09-20T17:00:00", endtime: "2025-09-20T20:00:00", message: "", label: "Dinner")
                    ]
                ),
                Days(
                    date: "2025-09-21",
                    status: "open",
                    dayparts: [
                        DayParts(starttime: "2025-09-21T10:00:00", endtime: "2025-09-21T15:00:00", message: "", label: "Brunch"),
                        DayParts(starttime: "2025-09-21T17:00:00", endtime: "2025-09-21T21:30:00", message: "", label: "Dinner")
                    ]
                ),
                Days(
                    date: "2025-09-22",
                    status: "open",
                    dayparts: [
                        DayParts(starttime: "2025-09-22T07:00:00", endtime: "2025-09-22T10:30:00", message: "", label: "Breakfast"),
                        DayParts(starttime: "2025-09-22T11:00:00", endtime: "2025-09-22T14:00:00", message: "", label: "Lunch"),
                        DayParts(starttime: "2025-09-22T17:00:00", endtime: "2025-09-22T21:30:00", message: "", label: "Dinner")
                    ]
                ),
                Days(
                    date: "2025-09-23",
                    status: "open",
                    dayparts: [
                        DayParts(starttime: "2025-09-23T07:00:00", endtime: "2025-09-23T10:30:00", message: "", label: "Breakfast"),
                        DayParts(starttime: "2025-09-23T11:00:00", endtime: "2025-09-23T14:00:00", message: "", label: "Lunch"),
                        DayParts(starttime: "2025-09-23T17:00:00", endtime: "2025-09-23T21:30:00", message: "", label: "Dinner")
                    ]
                ),
                Days(
                    date: "2025-09-24",
                    status: "open",
                    dayparts: [
                        DayParts(starttime: "2025-09-24T07:00:00", endtime: "2025-09-24T10:30:00", message: "", label: "Breakfast"),
                        DayParts(starttime: "2025-09-24T11:00:00", endtime: "2025-09-24T14:00:00", message: "", label: "Lunch"),
                        DayParts(starttime: "2025-09-24T17:00:00", endtime: "2025-09-24T21:30:00", message: "", label: "Dinner")
                    ]
                )
            ],
            image: "https://s3.us-east-2.amazonaws.com/labs.api/dining/1920-commons.jpg",
            id: 593
        ),
        DiningHall(
            name: "Hill House",
            address: "3333 Walnut St.",
            days: [
                Days(
                    date: "2025-09-18",
                    status: "open",
                    dayparts: [
                        DayParts(starttime: "2025-09-18T07:00:00", endtime: "2025-09-18T10:30:00", message: "", label: "Breakfast"),
                        DayParts(starttime: "2025-09-18T11:00:00", endtime: "2025-09-18T14:00:00", message: "", label: "Lunch"),
                        DayParts(starttime: "2025-09-18T17:00:00", endtime: "2025-09-18T21:30:00", message: "", label: "Dinner")
                    ]
                ),
                Days(
                    date: "2025-09-19",
                    status: "open",
                    dayparts: [
                        DayParts(starttime: "2025-09-19T07:00:00", endtime: "2025-09-19T10:30:00", message: "", label: "Breakfast"),
                        DayParts(starttime: "2025-09-19T11:00:00", endtime: "2025-09-19T14:00:00", message: "", label: "Lunch"),
                        DayParts(starttime: "2025-09-19T17:00:00", endtime: "2025-09-19T20:00:00", message: "", label: "Dinner")
                    ]
                ),
                Days(
                    date: "2025-09-20",
                    status: "open",
                    dayparts: [
                        DayParts(starttime: "2025-09-20T10:00:00", endtime: "2025-09-20T15:00:00", message: "", label: "Brunch"),
                        DayParts(starttime: "2025-09-20T17:00:00", endtime: "2025-09-20T20:00:00", message: "", label: "Dinner")
                    ]
                ),
                Days(
                    date: "2025-09-21",
                    status: "open",
                    dayparts: [
                        DayParts(starttime: "2025-09-21T10:00:00", endtime: "2025-09-21T15:00:00", message: "", label: "Brunch"),
                        DayParts(starttime: "2025-09-21T17:00:00", endtime: "2025-09-21T21:30:00", message: "", label: "Dinner")
                    ]
                ),
                Days(
                    date: "2025-09-22",
                    status: "open",
                    dayparts: [
                        DayParts(starttime: "2025-09-22T07:00:00", endtime: "2025-09-22T10:30:00", message: "", label: "Breakfast"),
                        DayParts(starttime: "2025-09-22T11:00:00", endtime: "2025-09-22T14:00:00", message: "", label: "Lunch"),
                        DayParts(starttime: "2025-09-22T17:00:00", endtime: "2025-09-22T21:30:00", message: "", label: "Dinner")
                    ]
                ),
                Days(
                    date: "2025-09-23",
                    status: "open",
                    dayparts: [
                        DayParts(starttime: "2025-09-23T07:00:00", endtime: "2025-09-23T10:30:00", message: "", label: "Breakfast"),
                        DayParts(starttime: "2025-09-23T11:00:00", endtime: "2025-09-23T14:00:00", message: "", label: "Lunch"),
                        DayParts(starttime: "2025-09-23T17:00:00", endtime: "2025-09-23T21:30:00", message: "", label: "Dinner")
                    ]
                ),
                Days(
                    date: "2025-09-24",
                    status: "open",
                    dayparts: [
                        DayParts(starttime: "2025-09-24T07:00:00", endtime: "2025-09-24T10:30:00", message: "", label: "Breakfast"),
                        DayParts(starttime: "2025-09-24T11:00:00", endtime: "2025-09-24T14:00:00", message: "", label: "Lunch"),
                        DayParts(starttime: "2025-09-24T17:00:00", endtime: "2025-09-24T21:30:00", message: "", label: "Dinner")
                    ]
                )
            ],
            image: "https://s3.us-east-2.amazonaws.com/labs.api/dining/Hill+House.jpg",
            id: 636
        )

    ]
}

