//
//  ClockState.swift
//  MinimalClock
//
//  Created by Vincent O'Sullivan on 23/10/2017.
//  Copyright © 2017 Vincent O'Sullivan. All rights reserved.
//

import Foundation

enum ClockState {
    case twelveHour
    case twelveHourWithSeconds
    case twentyFourHour
    case twentyFourHourWithSeconds

    static let allValues = [
        twelveHour,
        twelveHourWithSeconds,
        twentyFourHour,
        twentyFourHourWithSeconds]

    var next: ClockState {
        switch self {
        case .twelveHour:
            return .twelveHourWithSeconds
        case .twelveHourWithSeconds:
            return .twentyFourHourWithSeconds
        case .twentyFourHourWithSeconds:
            return .twentyFourHour
        case .twentyFourHour:
            return .twelveHour
        }
    }

    var isTwelveHour: Bool {
        return self == .twelveHour ||
            self == .twelveHourWithSeconds
    }

    var isSecondsVisible: Bool {
        return self == .twentyFourHourWithSeconds ||
            self == .twelveHourWithSeconds
    }
}
