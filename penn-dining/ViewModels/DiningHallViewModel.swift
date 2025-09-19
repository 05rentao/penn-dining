//
//  DiningHallViewModel.swift
//  penn-dining
//
//  Created by Ren Tao on 9/18/25.
//
import Foundation
import SwiftUI
import Observation

@Observable class DiningHallViewModel: Observable {
    
    var diningHalls: [DiningHall] = []
    var favorites: [Int] = []
    var images: [Int: UIImage] = [:]

    
    init() {
        Task {
            await getDiningHalls()
            await loadImage()
        }
    }
    
    func refresh() async {
        await getDiningHalls()
    }
    
    func dayOfWeek(dateString: String) -> String {
        
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
    
    func currPeriod(diningHall: DiningHall) async -> DayParts? {
        await refresh()
        
        let formatter = ISO8601DateFormatter()
        formatter.timeZone = TimeZone(identifier: "America/New_York")
        
        for dayPart in diningHall.days[0].dayparts {  // only look at first day because thats only plae where our interval is.
            let start = formatter.date(from: dayPart.starttime)!
            let end = formatter.date(from: dayPart.endtime)!
            if withinInterval(start, end) {
                return dayPart
            }
        }
        return nil
    }
    
    func getInterval(dayPart: DayParts) -> [String] {
        // returns the string [00:00, 00:00]
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        formatter.timeZone = TimeZone(identifier: "America/New_York")
        
        let start = formatter.date(from: dayPart.starttime)!
        let end = formatter.date(from: dayPart.endtime)!
        
        let hourFormatter = DateFormatter()
        hourFormatter.dateFormat = "h a"
        
        return [hourFormatter.string(from: start), hourFormatter.string(from: end)]
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
