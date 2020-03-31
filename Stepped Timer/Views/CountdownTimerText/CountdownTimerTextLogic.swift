//
//  CountdownTimerTextLogic.swift
//  Stepped Timer
//
//  Created by Robert Sikorski on 3/22/20.
//  Copyright © 2020 Robert Sikorski. All rights reserved.
//

import Foundation

func convertTimeIntervalToTimerString(timeInterval: TimeInterval) -> String {
  let minutes = Int(floor(timeInterval / 60))
  let seconds = floor(timeInterval.truncatingRemainder(dividingBy: 60) * 10) / 10
  let leadingMinutesZero = minutes < 10 ? "0" : ""
  let leadingSecondsZero = seconds < 10 ? "0" : ""

  let timerString = "\(leadingMinutesZero)\(minutes):\(leadingSecondsZero)\(seconds)"

  return timerString
}
