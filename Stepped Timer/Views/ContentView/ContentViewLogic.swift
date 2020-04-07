//
//  ContentViewLogic.swift
//  Stepped Timer
//
//  Created by Robert Sikorski on 3/22/20.
//  Copyright © 2020 Robert Sikorski. All rights reserved.
//

import Foundation

func updateStateOnPlayButtonAction(timerRunning: Bool, maxTime: TimeInterval, currentTime: TimeInterval) -> ContentViewState {
  if (timerRunning) {
    return ContentViewState(maxTime: maxTime,
                            currentTime: currentTime,
                            timerRunning: false,
                            toolbarPlayImageName: "play.fill",
                            toolbarStopImageName: "arrow.clockwise.circle.fill")
  } else {
    return ContentViewState(maxTime: maxTime,
                            currentTime: currentTime,
                            timerRunning: true,
                            toolbarPlayImageName: "pause",
                            toolbarStopImageName: "stop.fill")
  }
}

func updateStateOnStopButtonAction(timerRunning: Bool, maxTime: TimeInterval, currentTime: TimeInterval) -> ContentViewState {
  if (timerRunning) {
    return ContentViewState(maxTime: maxTime,
                            currentTime: currentTime,
                            timerRunning: false,
                            toolbarPlayImageName: "play.fill",
                            toolbarStopImageName: "arrow.clockwise.circle.fill")
  } else {
    return ContentViewState(maxTime: maxTime,
                            currentTime: maxTime,
                            timerRunning: false,
                            toolbarPlayImageName: "play.fill",
                            toolbarStopImageName: "arrow.clockwise.circle.fill")
  }
}
