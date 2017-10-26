//
//  SystemClock.swift
//  MinimalClock
//
//  Created by Vincent O'Sullivan on 23/10/2017.
//  Copyright © 2017 Vincent O'Sullivan. All rights reserved.
//

import Foundation

class StandardDeskClockViewModel: DeskClockViewModel {

    private let defaults = UserDefaults.standard
    private static let hours12Key = "DChours12"
    private static let secondsKey = "DCseconds"
    private static let dayKey = "DCday"
    private static let dateKey = "DCdate"
    private static let timeZoneKey = "DCtimeZone"
    
    private let dateTime: DateTime

    let hh12mmFormatter   = DateFormatter()
    let hh24mmFormatter   = DateFormatter()
    let ssFormatter       = DateFormatter()
    let ampmFormatter     = DateFormatter()
    let dayFormatter      = DateFormatter()
    let dateFormatter     = DateFormatter()
    let timeZoneFormatter = DateFormatter()

    var hourButtonText: String {
        return (showTwelveHour) ? "24\nHour" : "12\nHour"
    }
    var secondButtonText: String {
        return (secondsVisible) ? "Hide\nSeconds" : "Show\nSeconds"
    }
    var dayButtonText: String {
        return (dayVisible) ? "Hide\nDay" : "Show\nDay"
    }
    var dateButtonText: String {
        return (dateVisible) ? "Hide\nDate" : "Show\nDate"
    }
    var timeZoneButtonText: String {
        return (timeZoneVisible) ? "Hide\nTimezone" : "Show\nTimezone"
    }

    var showTwelveHour  = false
    var secondsVisible  = true
    var ampmVisible     = false
    var dayVisible      = false
    var dateVisible     = false
    var timeZoneVisible = false

    init(dateTime: DateTime) {
        self.dateTime = dateTime
        
        UserDefaults.standard.removeObject(forKey: StandardDeskClockViewModel.hours12Key)
        showTwelveHour  = StandardDeskClockViewModel.isLocaleSetting12Hour()
        secondsVisible  = defaults.bool(forKey: StandardDeskClockViewModel.secondsKey)
        ampmVisible     = showTwelveHour
        dayVisible      = defaults.bool(forKey: StandardDeskClockViewModel.dayKey)
        dateVisible     = defaults.bool(forKey: StandardDeskClockViewModel.dateKey)
        timeZoneVisible = defaults.bool(forKey: StandardDeskClockViewModel.timeZoneKey)

        hh12mmFormatter.dateFormat = "h:mm"
        hh12mmFormatter.locale = Locale(identifier: "")
        hh24mmFormatter.dateFormat = "HH:mm"
        hh24mmFormatter.locale = Locale(identifier: "")
        ssFormatter.dateFormat = " ss"
        ampmFormatter.dateFormat = " a"
        dayFormatter.dateFormat = "EEEE"
        dateFormatter.dateStyle = .long
        timeZoneFormatter.dateFormat = "zzzz"
    }


    /// Returns `true` if the current locale uses a 12 hour clock
    /// (as opposed to 24 hour), otherwise `false`.
    ///
    /// - Returns: `true` if the current locale uses a 12 hour clock
    ///            (as opposed to 24 hour), otherwise `false`.
    ///
    private static func isLocaleSetting12Hour() -> Bool {
        let hour12Setting = UserDefaults.standard.string(forKey: hours12Key)
        if hour12Setting == nil {
            let dateformat = DateFormatter.dateFormat(fromTemplate: "j", options: 0, locale: Locale.current) ?? ""
            return dateformat.contains("a")
        } else {
            return (hour12Setting == "yes")
        }
    }

    var hoursAndMinutes: String {
        if showTwelveHour {
            return hh12mmFormatter.string(from: dateTime.current)
        } else {
            return hh24mmFormatter.string(from: dateTime.current)
        }
    }

    var seconds: String {
        return (secondsVisible) ? ssFormatter.string(from: dateTime.current) : " "
    }

    var ampm: String {
        return (showTwelveHour) ? ampmFormatter.string(from: dateTime.current).lowercased() : " "
    }
    var day: String {
        return (dayVisible) ? dayFormatter.string(from: dateTime.current) : ""
    }
    var date: String {
        return (dateVisible) ? dateFormatter.string(from: dateTime.current) : ""
    }
    var timeZone: String {
        return (timeZoneVisible) ? timeZoneFormatter.string(from: dateTime.current) : " "
    }

    func toggleHoursDisplay() {
        showTwelveHour = !showTwelveHour
        defaults.set(showTwelveHour, forKey: StandardDeskClockViewModel.hours12Key)
    }

    func toggleSecondsDisplay() {
        secondsVisible = !secondsVisible
        defaults.set(secondsVisible, forKey: StandardDeskClockViewModel.secondsKey)
    }

    func toggleDayDisplay() {
        dayVisible = !dayVisible
        defaults.set(dayVisible, forKey: StandardDeskClockViewModel.dayKey)
    }

    func toggleDateDisplay() {
        dateVisible = !dateVisible
        defaults.set(dateVisible, forKey: StandardDeskClockViewModel.dateKey)
    }

    func toggleTimeZoneDisplay() {
        timeZoneVisible = !timeZoneVisible
        defaults.set(timeZoneVisible, forKey: StandardDeskClockViewModel.timeZoneKey)
    }
}
