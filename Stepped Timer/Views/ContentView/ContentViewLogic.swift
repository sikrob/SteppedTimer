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

func resetTimerTimeStepsFromTimerTimes(sortedTimerTimes: FetchedResults<TimerTime>) -> [TimerTimeStep] {
  return sortedTimerTimes.map({ (timerTime: TimerTime) -> TimerTimeStep in
    return TimerTimeStep(id: timerTime.id!, maxTime: timerTime.maxTime, currentTime: timerTime.maxTime)
  })
}

func timerTimeStepsFromTimerTimes(sortedTimerTimes: FetchedResults<TimerTime>, currentTimes: [TimeInterval]) -> [TimerTimeStep] {
  return sortedTimerTimes.enumerated().map({ (index: Int, timerTime: TimerTime) -> TimerTimeStep in
    let currentTime = index < currentTimes.count ? currentTimes[index] : timerTime.maxTime
    return TimerTimeStep(id: timerTime.id!, maxTime: timerTime.maxTime, currentTime: currentTime)
  })
}

func stateTimerTimeStepsFromTimerTimes(sortedTimerTimes: FetchedResults<TimerTime>) -> [TimerTimeStep] {
  return sortedTimerTimes.map({ (timerTime: TimerTime) -> TimerTimeStep in
    return TimerTimeStep(id: timerTime.id!, maxTime: timerTime.maxTime, currentTime: timerTime.currentTime)
  })
}

func updateStateOnPlayButtonAction(timerRunning: Bool, timerTimeSteps: [TimerTimeStep]) -> ContentViewState {
  if (timerRunning) {
    return ContentViewState(timerTimeSteps: timerTimeSteps,
                            timerRunning: false,
                            toolbarPlayImageName: "play.fill",
                            toolbarStopImageName: "arrow.clockwise.circle.fill")
  } else {
    return ContentViewState(timerTimeSteps: timerTimeSteps,
                            timerRunning: true,
                            toolbarPlayImageName: "pause",
                            toolbarStopImageName: "stop.fill")
  }
}

func updateStateOnStopButtonAction(timerRunning: Bool, timerTimeSteps: [TimerTimeStep]) -> ContentViewState {
  if (timerRunning) {
    return ContentViewState(timerTimeSteps: timerTimeSteps,
                            timerRunning: false,
                            toolbarPlayImageName: "play.fill",
                            toolbarStopImageName: "arrow.clockwise.circle.fill")
  } else {
    let resetTimerTimeSteps = timerTimeSteps.map({ (timerTimeStep: TimerTimeStep) -> TimerTimeStep in
      return TimerTimeStep(id: timerTimeStep.id, maxTime: timerTimeStep.maxTime, currentTime: timerTimeStep.maxTime)
    })

    return ContentViewState(timerTimeSteps: resetTimerTimeSteps,
                            timerRunning: false,
                            toolbarPlayImageName: "play.fill",
                            toolbarStopImageName: "arrow.clockwise.circle.fill")
  }
}
