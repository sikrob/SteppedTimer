//
//  ContentViewLogic.swift
//  Stepped Timer
//
//  Created by Robert Sikorski on 3/22/20.
//  Copyright © 2020 Robert Sikorski. All rights reserved.
//

import Foundation

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
