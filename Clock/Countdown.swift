//
//  DateCountDownTimer.swift
//  CountDownTimerLearning
//
//  Created by ThomasVEK on 04/03/18.
//  Copyright © 2018 TVEK Solutions. All rights reserved.
//

import Foundation

func defaultUpdateActionHandler(string: String) {}

func defaultCompletionActionHandler() {}

public class DateCountDownTimer {

    var countdownTimer: Timer!
    var totalTime = 60
    var dateString = "June 4, 2018 13:00:00"
    var updateActionHandler: (String) -> () = defaultUpdateActionHandler
    var completionActionHandler: () -> () = defaultCompletionActionHandler

    public init() {
        countdownTimer = Timer()
    }

    public func initializeTimer(pYear: Int, pMonth: String, pDay: Int, pHour: Int, pMin: Int, pSec: Int) {
        self.dateString = "\(pMonth) \(pDay), \(pYear) \(pHour):\(pMin):\(pSec)"

        let currentDate = Date()

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy HH:mm:ss"
        dateFormatter.timeZone = .current
        guard let targetDate = dateFormatter.date(from: dateString) else { return }

        let components = Calendar.current.dateComponents([.day, .hour, .minute, .second], from: currentDate, to: targetDate)
        let days = components.day ?? 0
        let hours = components.hour ?? 0
        let minutes = components.minute ?? 0
        let seconds = components.second ?? 0

        totalTime = days * 24 * 60 * 60 + hours * 60 * 60 + minutes * 60 + seconds
    }

    func numberOfDaysInMonth(month: Int) -> Int {
        let dateComponents = DateComponents(year: 2015, month: month)
        let calendar = Calendar.current
        guard let date = calendar.date(from: dateComponents) else { return 0 }

        let range = calendar.range(of: .day, in: .month, for: date)
        return range?.count ?? 0
    }

    public func startTimer(updateActionHandler: @escaping (String) -> (), completionActionHandler: @escaping () -> ()) {
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        self.updateActionHandler = updateActionHandler
        self.completionActionHandler = completionActionHandler
    }

    @objc func updateTime() {
        updateActionHandler(timeFormatted(totalTime))

        if totalTime > 0 {
            totalTime -= 1
        } else {
            endTimer()
        }
    }

    func endTimer() {
        completionActionHandler()
        countdownTimer.invalidate()
    }

    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds = totalSeconds % 60
        let minutes = (totalSeconds / 60) % 60
        let hours = (totalSeconds / 3600) % 24
        let days = totalSeconds / (3600 * 24)
        return String(format: "%dD %02dH %02dM %02dS", days, hours, minutes, seconds)
    }
}
