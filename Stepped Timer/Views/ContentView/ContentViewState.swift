//
//  ContentViewState.swift
//  Stepped Timer
//
//  Created by Robert Sikorski on 4/6/20.
//  Copyright © 2020 Robert Sikorski. All rights reserved.
//

import Foundation

struct ContentViewState {
  var timer: Timer?
  var timerSteps: [TimerStep]
  var timerRunning: Bool
  var toolbarPlayImageName: String
  var toolbarStopImageName: String
}
