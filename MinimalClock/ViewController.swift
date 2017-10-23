//
//  ViewController.swift
//  MinimalClock
//
//  Created by Vincent O'Sullivan on 26/07/2017.
//  Copyright © 2017 Vincent O'Sullivan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var hoursMinutes: UILabel!
    @IBOutlet weak var seconds: UILabel!
    @IBOutlet weak var ampm: UILabel!
    
    let clockViewModel: ClockViewModel = SystemClock()

    var timer = Timer()

    override func viewDidLoad() {
        super.viewDidLoad()

        timer = Timer.scheduledTimer(timeInterval: 1.0,
            target: self,
            selector: #selector(tick),
            userInfo: nil,
            repeats: true)
    }

    @IBAction func changeClockState() {
        clockViewModel.updateClockState()
    }
    
    @objc func tick() {
        hoursMinutes.text = clockViewModel.hoursAndMinutes
        if clockViewModel.hoursAndMinutes.contains("00") {
            ampm.textColor = .yellow
            hoursMinutes.textColor = .yellow
            hoursMinutes.font = UIFont(name: "HelveticaNeue-Thin", size: 84)
        } else {
            ampm.textColor = .green
            hoursMinutes.textColor = .green
            hoursMinutes.font = UIFont(name: "HelveticaNeue-Ultralight", size: 84)
        }
        seconds.text = clockViewModel.seconds
        ampm.text    = clockViewModel.ampm
    }
}

