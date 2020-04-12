//
//  ContentViewLogic.swift
//  Stepped Timer
//
//  Created by Robert Sikorski on 3/22/20.
//  Copyright © 2020 Robert Sikorski. All rights reserved.
//

import Foundation

func updateStateOnPlayButtonAction(timerRunning: Bool, maxTimes: [TimeInterval], currentTimes: [TimeInterval]) -> ContentViewState {
  if (timerRunning) {
    return ContentViewState(maxTimes: maxTimes,
                            currentTimes: currentTimes,
                            timerRunning: false,
                            toolbarPlayImageName: "play.fill",
                            toolbarStopImageName: "arrow.clockwise.circle.fill")
  } else {
    return ContentViewState(maxTimes: maxTimes,
                            currentTimes: currentTimes,
                            timerRunning: true,
                            toolbarPlayImageName: "pause",
                            toolbarStopImageName: "stop.fill")
  }
}

func updateStateOnStopButtonAction(timerRunning: Bool, maxTimes: [TimeInterval], currentTimes: [TimeInterval]) -> ContentViewState {
  if (timerRunning) {
    return ContentViewState(maxTimes: maxTimes,
                            currentTimes: currentTimes,
                            timerRunning: false,
                            toolbarPlayImageName: "play.fill",
                            toolbarStopImageName: "arrow.clockwise.circle.fill")
  } else {
    return ContentViewState(maxTimes: maxTimes,
                            currentTimes: maxTimes,
                            timerRunning: false,
                            toolbarPlayImageName: "play.fill",
                            toolbarStopImageName: "arrow.clockwise.circle.fill")
  }
}
