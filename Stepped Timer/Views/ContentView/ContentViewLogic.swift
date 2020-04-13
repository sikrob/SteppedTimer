//
//  ContentViewLogic.swift
//  Stepped Timer
//
//  Created by Robert Sikorski on 3/22/20.
//  Copyright © 2020 Robert Sikorski. All rights reserved.
//

import Foundation

func updateStateOnPlayButtonAction(timerRunning: Bool, timerTimes: [TimerTime]) -> ContentViewState {
  if (timerRunning) {
    return ContentViewState(timerTimes: timerTimes,
                            timerRunning: false,
                            toolbarPlayImageName: "play.fill",
                            toolbarStopImageName: "arrow.clockwise.circle.fill")
  } else {
    return ContentViewState(timerTimes: timerTimes,
                            timerRunning: true,
                            toolbarPlayImageName: "pause",
                            toolbarStopImageName: "stop.fill")
  }
}

func updateStateOnStopButtonAction(timerRunning: Bool, timerTimes: [TimerTime]) -> ContentViewState {
  if (timerRunning) {
    return ContentViewState(timerTimes: timerTimes,
                            timerRunning: false,
                            toolbarPlayImageName: "play.fill",
                            toolbarStopImageName: "arrow.clockwise.circle.fill")
  } else {
    let resetTimerTimes = timerTimes.map({ (timerTime: TimerTime) -> TimerTime in
      return TimerTime(maxTime: timerTime.maxTime, currentTime: timerTime.maxTime)
    })

    return ContentViewState(timerTimes: resetTimerTimes,
                            timerRunning: false,
                            toolbarPlayImageName: "play.fill",
                            toolbarStopImageName: "arrow.clockwise.circle.fill")
  }
}
