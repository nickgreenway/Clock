//
//  ViewController.swift
//  Clock
//
//  Created by Nick Greenway on 11/15/16.
//  Copyright © 2016 Nick Greenway. All rights reserved.
//

import Cocoa
import Foundation

class ViewController: NSViewController {

    @IBOutlet weak var dateLabel: NSTextField!
    @IBOutlet weak var time: NSTextField!
    @IBOutlet weak var countdown: NSTextField!

    let clock = Clock()
    var timer: Timer?
    let datecountdowntimer = DateCountDownTimer()

    override func viewWillAppear() {
        super.viewWillAppear()

        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimeLabel), userInfo: nil, repeats: true)
        datecountdowntimer.initializeTimer(pYear: 2018, pMonth: "June", pDay: 4, pHour: 13, pMin: 0, pSec: 0)
    }

    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }

    @objc func updateTimeLabel() {
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        time.stringValue = formatter.string(from: clock.currentTime)
    }

    @objc func updateDateLabel() {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        dateLabel.stringValue = formatter.string(from: clock.currentTime)
    }
}
