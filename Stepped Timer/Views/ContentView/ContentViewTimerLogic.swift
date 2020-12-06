//
//  ContentViewTimerLogic.swift
//  Stepped Timer
//
//  Created by Robert Sikorski on 7/5/20.
//  Copyright © 2020 Robert Sikorski. All rights reserved.
//

import Foundation
import SwiftUI

func stopTimer(timer: Binding<Timer?>, timerRunning: Binding<Bool>) {
  UIApplication.shared.isIdleTimerDisabled = false

  if timer.wrappedValue != nil {
    let runLoop = CFRunLoopGetCurrent()
    CFRunLoopRemoveTimer(runLoop, timer.wrappedValue!, .commonModes)
  }

  timerRunning.wrappedValue = false
}
