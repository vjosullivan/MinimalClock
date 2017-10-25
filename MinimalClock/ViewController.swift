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
    private let displayAmber = UIColor(red: 1.0, green: 0.5, blue: 0.25, alpha: 1.0)

    @IBOutlet weak var hoursMinutes: UILabel!
    @IBOutlet weak var seconds: UILabel!
    @IBOutlet weak var ampm: UILabel!
    @IBOutlet weak var day: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var timeZone: UILabel!

    @IBOutlet weak var buttonStack: UIStackView!
    @IBOutlet weak var hourButton: UIButton!
    @IBOutlet weak var secondsButton: UIButton!
    @IBOutlet weak var dayButton: UIButton!
    @IBOutlet weak var dateButton: UIButton!
    @IBOutlet weak var timeZoneButton: UIButton!

    let clockViewModel: ClockViewModel = SystemClock()

    var timer = Timer()

    override func viewWillAppear(_ animated: Bool) {
        hoursMinutes.text = ""
        hoursMinutes.textColor = displayGreen
        seconds.text = ""
        seconds.textColor = displayAmber
        ampm.text = ""
        ampm.textColor = displayGreen
        day.text = ""
        day.textColor = displayGreen
        date.text = ""
        date.textColor = displayGreen
        timeZone.text = ""
        timeZone.textColor = displayGreen
        initialiseButton(hourButton, with: clockViewModel.hourButtonText)
        initialiseButton(secondsButton, with: clockViewModel.secondButtonText)
        initialiseButton(dayButton, with: clockViewModel.dayButtonText)
        initialiseButton(dateButton, with: clockViewModel.dateButtonText)
        initialiseButton(timeZoneButton, with: clockViewModel.timeZoneButtonText)
        buttonStack.isHidden = true
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
        buttonStack.isHidden = !buttonStack.isHidden
    }

    @IBAction func toggleHours() {
        clockViewModel.toggleHoursDisplay()
        hourButton.setTitle(clockViewModel.hourButtonText, for: .normal)
        tick()
        toggleButtons()
    }

    @IBAction func toggleSeconds() {
        clockViewModel.toggleSecondsDisplay()
        secondsButton.setTitle(clockViewModel.secondButtonText, for: .normal)
        tick()
        toggleButtons()
    }

    @IBAction func toggleDay() {
        clockViewModel.toggleDayDisplay()
        dayButton.setTitle(clockViewModel.dayButtonText, for: .normal)
        tick()
        toggleButtons()
    }

    @IBAction func toggleDate() {
        clockViewModel.toggleDateDisplay()
        dateButton.setTitle(clockViewModel.dateButtonText, for: .normal)
        tick()
        toggleButtons()
    }

    @IBAction func toggleTimeZone() {
        clockViewModel.toggleTimeZoneDisplay()
        timeZoneButton.setTitle(clockViewModel.timeZoneButtonText, for: .normal)
        tick()
        toggleButtons()
    }

    fileprivate func initialiseButton(_ button: UIButton, with text: String) {
        button.tintColor = displayGreen
        button.titleLabel?.lineBreakMode = .byWordWrapping
        button.titleLabel?.textAlignment = .center
        button.setTitle(text, for: .normal)
    }
}
