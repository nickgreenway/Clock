//
//  DateCountDownTimer.swift
//  CountDownTimerLearning
//
//  Created by ThomasVEK on 04/03/18.
//  Copyright © 2018 TVEK Solutions. All rights reserved.
//

import Foundation



func defaultUpdateActionHandler(string:String)->(){
    
}

func defaultCompletionActionHandler()->(){
    
}

public class DateCountDownTimer {
    
    var countdownTimer: Timer!
    var totalTime = 60
    var dateString = "June 4, 2018 13:00:00" as String
    var UpdateActionHandler:(String)->() = defaultUpdateActionHandler
    var CompletionActionHandler:()->() = defaultCompletionActionHandler
    
    public init(){
        countdownTimer = Timer()
        totalTime = 60
        dateString = "June 4, 2018 13:00:00" as String
        UpdateActionHandler = defaultUpdateActionHandler
        CompletionActionHandler = defaultCompletionActionHandler
    }
    
    public func initializeTimer(pYear:Int, pMonth:String, pDay:Int, pHour:Int, pMin:Int, pSec:Int){
        
        self.dateString = "\(pMonth) \(pDay), \(pYear) \(pHour):\(pMin):\(pSec)" as String
        
        // Setting Today's Date
        let currentDate = Date()
        
        // Setting TargetDate
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy HH:mm:ss"
        dateFormatter.timeZone = NSTimeZone.local
        let targedDate = dateFormatter.date(from: dateString) as! Date
        
        // Calculating the difference of dates for timer
        let calendar = Calendar.current.dateComponents([.day, .hour, .minute, .second], from: currentDate, to: targedDate)
        let days = calendar.day!
        let hours = calendar.hour!
        let minutes = calendar.minute!
        let seconds = calendar.second!
        totalTime = hours * 60 * 60 + minutes * 60 + seconds
        totalTime = days * 60 * 60 * 24 + totalTime
    }
    
    func numberOfDaysInMonth(month:Int) -> Int{
        let dateComponents = DateComponents(year: 2015, month: 7)
        let calendar = Calendar.current
        let date = calendar.date(from: dateComponents)!
        
        let range = calendar.range(of: .day, in: .month, for: date)!
        let numDays = range.count
        print(numDays)
        return numDays
    }
    
    public func startTimer(pUpdateActionHandler:@escaping (String)->(),pCompletionActionHandler:@escaping ()->()) {
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        self.CompletionActionHandler = pCompletionActionHandler
        self.UpdateActionHandler = pUpdateActionHandler
    }
    
    @objc func updateTime() {
        self.UpdateActionHandler(timeFormatted(totalTime))
        
        if totalTime > 0 {
            totalTime -= 1
        } else {
            endTimer()
        }
    }
    
    func endTimer() {
        self.CompletionActionHandler()
        countdownTimer.invalidate()
    }
    
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        let hours: Int = (totalSeconds / 60 / 60) % 24
        let days: Int = (totalSeconds / 60 / 60 / 24)
        return String(format: "%dD %02dH %02dM %02dS", days, hours, minutes, seconds)
    }
    
}
