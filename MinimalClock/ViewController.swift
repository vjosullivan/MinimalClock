//
//  ViewController.swift
//  MinimalClock
//
//  Created by Vincent O'Sullivan on 26/07/2017.
//  Copyright © 2017 Vincent O'Sullivan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private let displayGreen = UIColor(red: 102.0/255.0, green: 1.0, blue: 102.0/255.0, alpha: 1.0)

    @IBOutlet weak var hoursMinutes: UILabel!
    @IBOutlet weak var seconds: UILabel!
    @IBOutlet weak var ampm: UILabel!
    @IBOutlet weak var day: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var timeZone: UILabel!

    @IBOutlet weak var buttons: UIStackView!

    let clockViewModel: ClockViewModel = SystemClock()

    var timer = Timer()

    override func viewWillAppear(_ animated: Bool) {
        buttons.isHidden = true
        day.isHidden = true
        date.isHidden = true
        timeZone.isHidden = true
        ampm.isHidden = true
        hoursMinutes.text = ""
        seconds.text = ""
        ampm.text = ""
        day.text = ""
        date.text = ""
        timeZone.text = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        timer = Timer.scheduledTimer(timeInterval: 1.0,
            target: self,
            selector: #selector(tick),
            userInfo: nil,
            repeats: true)
    }

    @objc func tick() {
        hoursMinutes.text = clockViewModel.hoursAndMinutes
        if clockViewModel.hoursAndMinutes.contains("00") {
            ampm.textColor = .yellow
            hoursMinutes.textColor = .yellow
            hoursMinutes.font = UIFont(name: "HelveticaNeue-Thin", size: 84)
        } else {
            ampm.textColor = displayGreen
            hoursMinutes.textColor = displayGreen
            hoursMinutes.font = UIFont(name: "HelveticaNeue-Ultralight", size: 84)
        }
        seconds.text  = clockViewModel.seconds
        ampm.text     = clockViewModel.ampm
        day.text      = clockViewModel.day
        date.text     = clockViewModel.date
        timeZone.text = clockViewModel.timeZone
    }

    @IBAction func toggleButtons() {
        buttons.isHidden = !buttons.isHidden
    }

    @IBAction func toggleHours() {
        clockViewModel.toggleHoursDisplay()
    }

    @IBAction func toggleSeconds() {
        seconds.isHidden = !seconds.isHidden
    }

    @IBAction func toggleDay() {
        day.isHidden = !day.isHidden
    }

    @IBAction func toggleDate() {
        date.isHidden = !date.isHidden
    }

    @IBAction func toggleTimeZone() {
        timeZone.isHidden = !timeZone.isHidden
    }
}
