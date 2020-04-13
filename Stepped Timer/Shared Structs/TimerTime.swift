//
//  TimerTime.swift
//  Stepped Timer
//
//  Created by Robert Sikorski on 4/12/20.
//  Copyright © 2020 Robert Sikorski. All rights reserved.
//

import Foundation

struct TimerTime: Identifiable, Equatable {
  var id = UUID()
  var maxTime: TimeInterval
  var currentTime: TimeInterval

  static func == (lhs: TimerTime, rhs: TimerTime) -> Bool {
    return lhs.maxTime == rhs.maxTime && lhs.currentTime == rhs.currentTime
  }
}
