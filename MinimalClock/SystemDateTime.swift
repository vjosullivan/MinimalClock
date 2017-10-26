//
//  SystemDateTime.swift
//  MinimalClock
//
//  Created by Vincent O'Sullivan on 26/10/2017.
//  Copyright © 2017 Vincent O'Sullivan. All rights reserved.
//

import Foundation

struct SystemDateTime: DateTime {
    var current: Date {
        return Date()
    }
}
