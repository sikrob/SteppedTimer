//
//  ContentViewLogic.swift
//  Stepped Timer
//
//  Created by Robert Sikorski on 3/22/20.
//  Copyright © 2020 Robert Sikorski. All rights reserved.
//

import Foundation
import SwiftUI
import CoreData

func timerStepsFromTimerTimes(sortedTimerTimes: FetchedResults<TimerTime>, currentTimes: [TimeInterval]) -> [TimerStep] {
  return sortedTimerTimes.enumerated().map({ (index: Int, timerTime: TimerTime) -> TimerStep in
    let currentTime = index < currentTimes.count ? currentTimes[index] : timerTime.maxTime
    return TimerStep(id: timerTime.id!, maxTime: timerTime.maxTime, currentTime: currentTime)
  })
}

func toolbarPlayImageNameForTimerRunning(_ timerRunning: Bool) -> String {
  return timerRunning ? "pause" : "play.fill"
}

func toolbarStopImageNameForTimerRunning(_ timerRunning: Bool) -> String {
  return timerRunning ? "stop.fill" : "arrow.clockwise.circle.fill"
}
