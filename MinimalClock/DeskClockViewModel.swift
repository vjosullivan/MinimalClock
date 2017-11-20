//
//  Clock.swift
//  MinimalClock
//
//  Created by Vincent O'Sullivan on 23/10/2017.
//  Copyright © 2017 Vincent O'Sullivan. All rights reserved.
//

import Foundation

protocol DeskClockViewModel {
    var hoursAndMinutes: String { get }
    var seconds: String { get }
    var ampm: String { get }
    var day: String { get }
    var date: String { get }
    var timeZone: String { get }

    var hourButtonText: String { get }
    var secondButtonText: String { get }
    var dayButtonText: String { get }
    var timeZoneButtonText: String { get }

    var showTwelveHour: Bool { get }
    var secondsVisible: Bool { get }
    var ampmVisible: Bool { get }
    var dayVisible: Bool { get }
    var timeZoneVisible: Bool { get }

    func toggleHoursDisplay()
    func toggleSecondsDisplay()
    func toggleDayDisplay()
    func toggleTimeZoneDisplay()
}
