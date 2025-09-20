//
//  DiningHallViewModel.swift
//  penn-dining
//
//  Created by ____ on 9/18/25.
//
import Foundation
import SwiftUI
import Observation
import MessageUI
import SafariServices


@Observable class DiningHallViewModel: Observable  {
    
    var diningHalls: [DiningHall] = []
    var favorites: [Int] = []
    var images: [Int: UIImage] = [:]
    var status: [Int: String] = [:]
    var ratings: [Int: Int] = [:]
    var websites: [Int: String] = [
        593: "https://dining.business-services.upenn.edu/locations-hours-menus/locations/1920-commons",
        636: "https://dining.business-services.upenn.edu/locations-hours-menus/locations/hill-house",
        1442: "https://dining.business-services.upenn.edu/locations-hours-menus/locations/lauder-college-house",
        638: "https://dining.business-services.upenn.edu/locations-hours-menus/locations/falk-penn-hillel",
        637: "https://dining.business-services.upenn.edu/locations-hours-menus/locations/english-house",
        1464004: "https://dining.business-services.upenn.edu/locations-hours-menus/locations/quaker-kitchen",
        641: "https://dining.business-services.upenn.edu/locations-hours-menus/locations/accenture-cafe",
        1464009 : "https://dining.business-services.upenn.edu/locations-hours-menus/locations/cafe-west",
        1057 : "https://dining.business-services.upenn.edu/locations-hours-menus/locations/gourmet-grocer",
        639 : "https://dining.business-services.upenn.edu/locations-hours-menus/locations/houston-market",
        642 : "https://dining.business-services.upenn.edu/locations-hours-menus/locations/joes-cafe",
        747: "https://dining.business-services.upenn.edu/locations-hours-menus/locations/mcclelland-cafe",
        1732 : "https://dining.business-services.upenn.edu/locations-hours-menus/locations/pret-manger",
        1733 : "https://dining.business-services.upenn.edu/locations-hours-menus/locations/pret-manger",
        1163 : "https://dining.business-services.upenn.edu/locations-hours-menus/locations/starbucks"
    ]

    
    init() {
        Task {
            await getDiningHalls()
            await loadImage()
            for diningHall in diningHalls {
                await saveDiningHallStatus(diningHall: diningHall)
            }
        }
    }
    
    func refresh() async {
        await getDiningHalls()
        for diningHall in diningHalls {
            await saveDiningHallStatus(diningHall: diningHall)

        }
    }
    

    func setRating(_ diningHall: DiningHall, rating: Int) {
        ratings[diningHall.id] = rating
    }
    
    // ----- hours logic ---------
    
    func dayOfWeek(dateString: String) -> String {
        // return the string for the day of the week
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = TimeZone.current
        
        if let date = formatter.date(from: dateString) {
            let calendar = Calendar(identifier: .gregorian)
            let day = calendar.component(.weekday, from: date)
            let weekdays: [String] = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
            return weekdays[day - 1]
        }
        return "Unknown"
        
    }
    
    func getInterval(_ dayPart : DayParts) -> (Date, Date) {
        // given a meal period, return a
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        formatter.timeZone = TimeZone(identifier: "America/New_York")
        
        let start = formatter.date(from: dayPart.starttime)!
        let end = formatter.date(from: dayPart.endtime)!
        return (start, end)
    }
    
    func saveDiningHallStatus(diningHall: DiningHall) async {
        var result = ""
        if let dayPart = await getCurrPeriod(diningHall: diningHall) {
            let interval = getIntervalString(dayPart: dayPart)
            result = "\(interval[0]) - \(interval[1])"
        } else {
            result = "Currently closed"
        }
        self.status[diningHall.id] = result
    }
    
    func getCurrPeriod(diningHall: DiningHall) async -> DayParts? {
        // get the current meal time
        
        for dayPart in diningHall.days[0].dayparts {  // only look at first day because thats only place where our interval is.
            let interval = getInterval(dayPart)
            let start = interval.0
            let end = interval.1
            if withinInterval(start, end) {
                return dayPart
            }
        }
        return nil
    }
    
    func getIntervalString(dayPart: DayParts) -> [String] {
        // returns the string [00:00, 00:00]
        let interval = getInterval(dayPart)
        let start = interval.0
        let end = interval.1
        
        let hourFormatter1 = DateFormatter()
        hourFormatter1.dateFormat = "h"
        
        let hourFormatter2 = DateFormatter()
        hourFormatter2.dateFormat = "ha"
        
        return [hourFormatter1.string(from: start), hourFormatter2.string(from: end)]
    }
    
    
    
    func withinInterval(_ start: Date, _ end: Date) -> Bool {
        let time: NSDate = NSDate()
        if time.compare(start) == .orderedDescending && time.compare(end) == .orderedAscending {
            return true
        }
        return false
    }
    
    
    //------Networking-----------------
    
    func getDiningHalls() async {
        do {
            self.diningHalls = try await APIManager.instance.getDiningHalls()
        } catch let error {
            print("error fetching dining hall APIs: " + error.localizedDescription)
        }
    }
    
    func loadImage() async {
        // save loaded images all at once so tha we don't have to continously make calls to get the same image
        for diningHall in diningHalls {
            let imageData = try! Data(contentsOf: URL(string: diningHall.image)!)
            self.images[diningHall.id] = UIImage(data: imageData)
        }
    }
    
    // ---- favorites functionality -----
    
    func addFavorite(_ id: Int) {
        favorites.append(id)
    }
    
    func removeFavorite(_ id: Int) {
        favorites.removeAll { $0 == id }
    }
}
