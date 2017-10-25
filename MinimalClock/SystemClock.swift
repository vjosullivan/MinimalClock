//
//  SystemClock.swift
//  MinimalClock
//
//  Created by Vincent O'Sullivan on 23/10/2017.
//  Copyright © 2017 Vincent O'Sullivan. All rights reserved.
//

import Foundation

class SystemClock: ClockViewModel {

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
        hh12mmFormatter.dateFormat = "h:mm"
        hh24mmFormatter.dateFormat = "HH:mm"
        ssFormatter.dateFormat = " ss"
        ampmFormatter.dateFormat = " a"
        dayFormatter.dateFormat = "EEEE"
        dateFormatter.dateStyle = .long
        timeZoneFormatter.dateFormat = "zzzz"
    }

    var hoursAndMinutes: String {
        if showTwelveHour {
            return hh12mmFormatter.string(from: Date())
        } else {
            return hh24mmFormatter.string(from: Date())
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
    }

    func toggleSecondsDisplay() {
        secondsVisible = !secondsVisible
    }

    func toggleDayDisplay() {
        dayVisible = !dayVisible
    }

    func toggleDateDisplay() {
        dateVisible = !dateVisible
    }

    func toggleTimeZoneDisplay() {
        timeZoneVisible = !timeZoneVisible
    }
}
