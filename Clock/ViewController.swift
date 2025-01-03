//
//  ViewController.swift
//  Clock
//
//  Created by Nick Greenway on 11/15/16.
//  Copyright © 2016 Nick Greenway. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var date: NSTextField!
    @IBOutlet weak var time: NSTextField!

    let clock = Clock()
    var timer: Timer?

    override func viewWillAppear() {
        super.viewWillAppear()

        // Initialize the timers to update time and date labels
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimeLabel), userInfo: nil, repeats: true)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateDateLabel), userInfo: nil, repeats: true)
    }

    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded
        }
    }

    @objc func updateTimeLabel() {
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        time.stringValue = formatter.string(from: clock.currentTime)
        time.font = NSFont.monospacedDigitSystemFont(ofSize: 175, weight: .regular)
    }

    @objc func updateDateLabel() {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        date.stringValue = formatter.string(from: clock.currentTime)
    }
}
