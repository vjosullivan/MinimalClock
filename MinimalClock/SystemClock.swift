//
//  SystemClock.swift
//  MinimalClock
//
//  Created by Vincent O'Sullivan on 23/10/2017.
//  Copyright © 2017 Vincent O'Sullivan. All rights reserved.
//

import Foundation

class SystemClock: ClockViewModel {

    private let defaults = UserDefaults.standard
    private static let hours12Key = "DChours12"
    private static let secondsKey = "DCseconds"
    private static let dayKey = "DCday"
    private static let dateKey = "DCdate"
    private static let timeZoneKey = "DCtimeZone"

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

    init() {
        showTwelveHour  = SystemClock.isLocaleSetting12Hour()
        secondsVisible  = defaults.bool(forKey: SystemClock.secondsKey)
        ampmVisible     = showTwelveHour
        dayVisible      = defaults.bool(forKey: SystemClock.dayKey)
        dateVisible     = defaults.bool(forKey: SystemClock.dateKey)
        timeZoneVisible = defaults.bool(forKey: SystemClock.timeZoneKey)

        hh12mmFormatter.dateFormat = "h:mm"
        hh24mmFormatter.dateFormat = "HH:mm"
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
            return true //!formatter.contains("HH")
        } else {
            return (hour12Setting == "yes")
        }
    }

    var hoursAndMinutes: String {
        if showTwelveHour {
            let txt = hh12mmFormatter.string(from: Date())
            print(showTwelveHour, 12, txt)
            return txt
        } else {
            let txt = hh24mmFormatter.string(from: Date())
            print(showTwelveHour, 24, txt)
            return txt
        }
    }

    var seconds: String {
        return (secondsVisible) ? ssFormatter.string(from: Date()) : " "
    }

    var ampm: String {
        return (showTwelveHour) ? ampmFormatter.string(from: Date()).lowercased() : " "
    }
    var day: String {
        return (dayVisible) ? dayFormatter.string(from: Date()) : ""
    }
    var date: String {
        return (dateVisible) ? dateFormatter.string(from: Date()) : ""
    }
    var timeZone: String {
        return (timeZoneVisible) ? timeZoneFormatter.string(from: Date()) : " "
    }

    func toggleHoursDisplay() {
        showTwelveHour = !showTwelveHour
        defaults.set(showTwelveHour, forKey: SystemClock.hours12Key)
    }

    func toggleSecondsDisplay() {
        secondsVisible = !secondsVisible
        defaults.set(secondsVisible, forKey: SystemClock.secondsKey)
    }

    func toggleDayDisplay() {
        dayVisible = !dayVisible
        defaults.set(dayVisible, forKey: SystemClock.dayKey)
    }

    func toggleDateDisplay() {
        dateVisible = !dateVisible
        defaults.set(dateVisible, forKey: SystemClock.dateKey)
    }

    func toggleTimeZoneDisplay() {
        timeZoneVisible = !timeZoneVisible
        defaults.set(timeZoneVisible, forKey: SystemClock.timeZoneKey)
    }
}
