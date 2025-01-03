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
    
    
    @IBOutlet weak var dateLabel: NSTextFieldCell!
    @IBOutlet weak var time: NSTextField!
    @IBOutlet weak var countdown: NSTextField!
    
    let clock = Clock()
    var timer: Timer?
    let timeNumberformatter = DateFormatter()
    let timeFormatter = DateFormatter()
    let timeFormatter2 = DateFormatter()
    let timeNumberformatter2 = DateFormatter()
    let datecountdowntimer = DateCountDownTimer()
    

    override func viewWillAppear() {
        
        super.viewDidLoad()

        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.updateTimeLabel), userInfo: nil, repeats: true)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.updatetodayLabel), userInfo: nil, repeats: true)
        
        datecountdowntimer.initializeTimer(pYear: 2018, pMonth: "June", pDay: 04, pHour: 13, pMin: 00, pSec: 00)
        
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    func updateTimeLabel() {
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        time.stringValue = formatter.string(from: clock.currentTime as Date)
    }

    func updatetodayLabel() {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        dateLabel.stringValue = formatter.string(from: clock.currentTime as Date)
    }

     
        

}

