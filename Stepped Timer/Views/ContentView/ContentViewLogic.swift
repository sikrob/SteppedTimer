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

func resetTimerStepsFromTimerTimes(sortedTimerTimes: FetchedResults<TimerTime>) -> [TimerStep] {
  return sortedTimerTimes.map({ (timerTime: TimerTime) -> TimerStep in
    return TimerStep(id: timerTime.id!, maxTime: timerTime.maxTime, currentTime: timerTime.maxTime)
  })
}

func timerStepsFromTimerTimes(sortedTimerTimes: FetchedResults<TimerTime>, currentTimes: [TimeInterval]) -> [TimerStep] {
  return sortedTimerTimes.enumerated().map({ (index: Int, timerTime: TimerTime) -> TimerStep in
    let currentTime = index < currentTimes.count ? currentTimes[index] : timerTime.maxTime
    return TimerStep(id: timerTime.id!, maxTime: timerTime.maxTime, currentTime: currentTime)
  })
}

func stateTimerStepsFromTimerTimes(sortedTimerTimes: FetchedResults<TimerTime>) -> [TimerStep] {
  return sortedTimerTimes.map({ (timerTime: TimerTime) -> TimerStep in
    return TimerStep(id: timerTime.id!, maxTime: timerTime.maxTime, currentTime: timerTime.currentTime)
  })
}

func toolbarPlayImageNameForTimerRunning(_ timerRunning: Bool) -> String {
  return timerRunning ? "pause" : "play.fill"
}

func toolbarStopImageNameForTimerRunning(_ timerRunning: Bool) -> String {
  return timerRunning ? "stop.fill" : "arrow.clockwise.circle.fill"
}

//func updateStateOnStopButtonAction(timerRunning: Bool, timerSteps: [TimerStep]) -> ContentViewState {
//  if (timerRunning) {
//    return ContentViewState(timerSteps: timerSteps,
//                            timerRunning: false,
//                            toolbarPlayImageName: "play.fill",
//                            toolbarStopImageName: "arrow.clockwise.circle.fill")
//  } else {
//    let resetTimerSteps = timerSteps.map({ (timerStep: TimerStep) -> TimerStep in
//      return TimerStep(id: timerStep.id, maxTime: timerStep.maxTime, currentTime: timerStep.maxTime)
//    })
//
//    return ContentViewState(timerSteps: resetTimerSteps,
//                            timerRunning: false,
//                            toolbarPlayImageName: "play.fill",
//                            toolbarStopImageName: "arrow.clockwise.circle.fill")
//  }
//}
