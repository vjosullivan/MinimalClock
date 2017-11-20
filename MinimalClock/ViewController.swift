//
//  ViewController.swift
//  MinimalClock
//
//  Created by Vincent O'Sullivan on 26/07/2017.
//  Copyright © 2017 Vincent O'Sullivan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Local constants and variables.

    private let displayGreen = UIColor(red: 102.0/255.0, green: 1.0, blue: 102.0/255.0, alpha: 1.0)
    private let displayAmber = UIColor(red: 1.0, green: 0.5, blue: 0.25, alpha: 1.0)

    let clockViewModel: DeskClockViewModel = StandardDeskClockViewModel(dateTime: SystemDateTime())
    var timer: Timer?

    // MARK: - Outlets.

    @IBOutlet weak var hoursMinutes: UILabel! { didSet { initialise(label: hoursMinutes, color: displayGreen) }}
    @IBOutlet weak var seconds: UILabel!      { didSet { initialise(label: seconds, color: displayAmber) }}
    @IBOutlet weak var ampm: UILabel!         { didSet { initialise(label: ampm, color: displayGreen) }}
    @IBOutlet weak var day: UILabel!          { didSet { initialise(label: day, color: displayGreen) }}
    @IBOutlet weak var date: UILabel!         { didSet { initialise(label: date, color: displayGreen) }}
    @IBOutlet weak var timeZone: UILabel!     { didSet { initialise(label: timeZone, color: displayGreen) }}

    @IBOutlet weak var buttonStack: UIStackView!
    @IBOutlet weak var hourButton: UIButton!     { didSet { initialise(button: hourButton, text: clockViewModel.hourButtonText) }}
    @IBOutlet weak var secondsButton: UIButton!  { didSet { initialise(button: secondsButton, text: clockViewModel.secondButtonText) }}
    @IBOutlet weak var dayButton: UIButton!      { didSet { initialise(button: dayButton, text: clockViewModel.dayButtonText) }}
    @IBOutlet weak var dateButton: UIButton!     { didSet { initialise(button: dateButton, text: clockViewModel.dateButtonText) }}
    @IBOutlet weak var timeZoneButton: UIButton! { didSet { initialise(button: timeZoneButton, text: clockViewModel.timeZoneButtonText) }}

    // MARK: - UIViewController functions.

    override func viewDidLoad() {
        super.viewDidLoad()

        UIApplication.shared.isIdleTimerDisabled = true
        buttonStack.isHidden = false
        toggleButtons()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        timer = Timer.scheduledTimer(timeInterval: 1.0,
                                     target: self,
                                     selector: #selector(tick),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        timer = nil
    }

    override func prefersHomeIndicatorAutoHidden() -> Bool
    {
        return true
    }

    // MARK: - Actions.

    @IBAction func toggleButtons() {
        tick()
        buttonStack.isHidden = !buttonStack.isHidden
    }

    @IBAction func toggleHours() {
        clockViewModel.toggleHoursDisplay()
        hourButton.setTitle(clockViewModel.hourButtonText, for: .normal)
        toggleButtons()
    }

    @IBAction func toggleSeconds() {
        clockViewModel.toggleSecondsDisplay()
        secondsButton.setTitle(clockViewModel.secondButtonText, for: .normal)
        toggleButtons()
    }

    @IBAction func toggleDay() {
        clockViewModel.toggleDayDisplay()
        dayButton.setTitle(clockViewModel.dayButtonText, for: .normal)
         toggleButtons()
    }

    @IBAction func toggleDate() {
        clockViewModel.toggleDateDisplay()
        dateButton.setTitle(clockViewModel.dateButtonText, for: .normal)
         toggleButtons()
    }

    @IBAction func toggleTimeZone() {
        clockViewModel.toggleTimeZoneDisplay()
        timeZoneButton.setTitle(clockViewModel.timeZoneButtonText, for: .normal)
        toggleButtons()
    }

    // MARK: - Local functions.

    @objc func tick() {
        hoursMinutes.text = clockViewModel.hoursAndMinutes
        if clockViewModel.hoursAndMinutes.contains(":00") {
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

    fileprivate func initialise(label: UILabel, color: UIColor) {
        label.text = ""
        label.textColor = color
    }

    fileprivate func initialise(button: UIButton, text: String) {
        button.tintColor = displayGreen
        button.titleLabel?.lineBreakMode = .byWordWrapping
        button.titleLabel?.textAlignment = .center
        button.setTitle(text, for: .normal)
    }
}
