//
//  SystemClock.swift
//  MinimalClock
//
//  Created by Vincent O'Sullivan on 23/10/2017.
//  Copyright © 2017 Vincent O'Sullivan. All rights reserved.
//

import Foundation

class SystemClock: ClockViewModel {

    let hh12mmFormatter = DateFormatter()
    let hh24mmFormatter = DateFormatter()
    let ssFormatter = DateFormatter()
    let ampmFormatter = DateFormatter()
    let dayFormatter = DateFormatter()
    let dateFormatter = DateFormatter()
    let timeZoneFormatter = DateFormatter()

    private var showTwelveHour = false

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
        return ssFormatter.string(from: Date())
    }
    var ampm: String {
        return ampmFormatter.string(from: Date()).lowercased()
    }
    var day: String {
        return dayFormatter.string(from: Date())
    }
    var date: String {
        return dateFormatter.string(from: Date())
    }
    var timeZone: String {
        return timeZoneFormatter.string(from: Date())
    }

    func toggleHoursDisplay() {
        showTwelveHour = !showTwelveHour
    }
}
