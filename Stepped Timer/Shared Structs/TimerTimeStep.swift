//
//  TimerTimeStep.swift
//  Stepped Timer
//
//  Created by Robert Sikorski on 4/12/20.
//  Copyright © 2020 Robert Sikorski. All rights reserved.
//

import Foundation

struct TimerTimeStep: Identifiable, Equatable {
  var id = UUID()
  var maxTime: TimeInterval
  var currentTime: TimeInterval

  static func == (lhs: TimerTimeStep, rhs: TimerTimeStep) -> Bool {
    return lhs.maxTime == rhs.maxTime && lhs.currentTime == rhs.currentTime
  }
}
