//
//  SystemClock.swift
//  MinimalClock
//
//  Created by Vincent O'Sullivan on 23/10/2017.
//  Copyright © 2017 Vincent O'Sullivan. All rights reserved.
//

import Foundation

class SystemClock: ClockViewModel {

    var clockState: ClockState

    func updateClockState() {
        switch clockState {
        case .twelveHour:
            clockState = .twelveHourWithSeconds
        case .twelveHourWithSeconds:
            clockState = .twentyFourHourWithSeconds
        case .twentyFourHourWithSeconds:
            clockState = .twentyFourHour
        case .twentyFourHour:
            clockState = .twelveHour
        }
    }

    var hoursAndMinutes: String {
        if clockState == .twelveHour ||
            clockState == .twelveHourWithSeconds {
            return hh12mmFormatter.string(from: Date())
        } else {
            return hh24mmFormatter.string(from: Date())
        }
    }

    var seconds: String {
        if clockState == .twelveHourWithSeconds ||
            clockState == .twentyFourHourWithSeconds {
            return ssFormatter.string(from: Date())
        } else {
            return " "
        }
    }
    var ampm: String {
        if clockState == .twelveHour ||
            clockState == .twelveHourWithSeconds {
            return ampmFormatter.string(from: Date()).lowercased()
        } else {
            return " "
        }
    }

    let hh12mmFormatter = DateFormatter()
    let hh24mmFormatter = DateFormatter()
    let ssFormatter = DateFormatter()
    let ampmFormatter = DateFormatter()

    init() {
        clockState = .twentyFourHourWithSeconds
        hh12mmFormatter.dateFormat = "h:mm"
        hh24mmFormatter.dateFormat = "HH:mm"
        ssFormatter.dateFormat = " ss"
        ampmFormatter.dateFormat = " a"
    }
}
