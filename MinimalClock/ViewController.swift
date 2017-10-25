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
    @IBOutlet weak var timeZoneLabelTrailingConstraint: NSLayoutConstraint!

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
        seconds.text = ""
        ampm.text = ""
        day.text = ""
        date.text = ""
        timeZone.text = ""
        hourButton.tintColor = displayGreen
        hourButton.titleLabel?.lineBreakMode = .byWordWrapping
        hourButton.titleLabel?.textAlignment = .center
        hourButton.setTitle(clockViewModel.hourButtonText, for: .normal)
        secondsButton.tintColor = displayGreen
        secondsButton.titleLabel?.lineBreakMode = .byWordWrapping
        secondsButton.titleLabel?.textAlignment = .center
        secondsButton.setTitle(clockViewModel.secondButtonText, for: .normal)
        dayButton.tintColor = displayGreen
        dayButton.titleLabel?.lineBreakMode = .byWordWrapping
        dayButton.titleLabel?.textAlignment = .center
        dayButton.setTitle(clockViewModel.dayButtonText, for: .normal)
        dateButton.tintColor = displayGreen
        dateButton.titleLabel?.lineBreakMode = .byWordWrapping
        dateButton.titleLabel?.textAlignment = .center
        dateButton.setTitle(clockViewModel.dateButtonText, for: .normal)
        timeZoneButton.tintColor = displayGreen
        timeZoneButton.titleLabel?.lineBreakMode = .byWordWrapping
        timeZoneButton.titleLabel?.textAlignment = .center
        timeZoneButton.setTitle(clockViewModel.timeZoneButtonText, for: .normal)
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
        //self.view.layoutIfNeeded()
        UIView.animate(withDuration: 1) {
            self.timeZoneLabelTrailingConstraint.constant = (self.buttonStack.isHidden) ? 0 : 200
            self.view.layoutIfNeeded()
        }
    }

    @IBAction func toggleHours() {
        clockViewModel.toggleHoursDisplay()
        hourButton.setTitle(clockViewModel.hourButtonText, for: .normal)
        buttonStack.isHidden = true
    }

    @IBAction func toggleSeconds() {
        clockViewModel.toggleSecondsDisplay()
        secondsButton.setTitle(clockViewModel.secondButtonText, for: .normal)
        buttonStack.isHidden = true
    }

    @IBAction func toggleDay() {
        clockViewModel.toggleDayDisplay()
        dayButton.setTitle(clockViewModel.dayButtonText, for: .normal)
        buttonStack.isHidden = true
    }

    @IBAction func toggleDate() {
        clockViewModel.toggleDateDisplay()
        dateButton.setTitle(clockViewModel.dateButtonText, for: .normal)
        buttonStack.isHidden = true
    }

    @IBAction func toggleTimeZone() {
        clockViewModel.toggleTimeZoneDisplay()
        timeZoneButton.setTitle(clockViewModel.timeZoneButtonText, for: .normal)
        buttonStack.isHidden = true
        UIView.animate(withDuration: 1) {
            self.timeZoneLabelTrailingConstraint.constant = (self.buttonStack.isHidden) ? 0 : 200
            self.view.layoutIfNeeded()
        }
    }
}
