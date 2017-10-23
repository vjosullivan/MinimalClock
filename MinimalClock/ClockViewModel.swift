//
//  Clock.swift
//  MinimalClock
//
//  Created by Vincent O'Sullivan on 23/10/2017.
//  Copyright © 2017 Vincent O'Sullivan. All rights reserved.
//

import Foundation

protocol ClockViewModel {
    var hoursAndMinutes: String { get }
    var seconds: String { get }
    var ampm: String { get }
    
    var clockState: ClockState { get }

    func updateClockState()
}
