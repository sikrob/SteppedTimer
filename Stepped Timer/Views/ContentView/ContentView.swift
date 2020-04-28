//
//  ContentView.swift
//  Stepped Timer
//
//  Created by Robert Sikorski on 3/21/20.
//  Copyright © 2020 Robert Sikorski. All rights reserved.
//

import SwiftUI
import CoreData

struct ContentView: View {
  @Environment(\.managedObjectContext) var context

  @FetchRequest(
    entity: TimerTime.entity(),
    sortDescriptors: [NSSortDescriptor(key: "stepNumber", ascending: true)]
  ) var allTimerTimes: FetchedResults<TimerTime>

  @State var timer: Timer? = nil
  @State var timerSteps: [TimerStep] = []
  @State var timerRunning: Bool = false
  @State var toolbarPlayImageName: String = "play.fill"
  @State var toolbarStopImageName: String = "arrow.clockwise.circle.fill"

  @State var timerAction: Timer? = nil

  @State var testTime: TimeInterval = 10.0

  private func updateTimer() {
    let runLoop = CFRunLoopGetCurrent()

    if timer == nil {
      timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { (Timer) -> Void in
        print("running self.testTime \(self.testTime)")
        if (self.testTime > 0) {
          self.testTime -= 0.1
        } else {
          CFRunLoopRemoveTimer(runLoop, self.timer, CFRunLoopMode.commonModes)
          self.timer = nil
        }
      })
      CFRunLoopAddTimer(runLoop, timer, CFRunLoopMode.commonModes)
    } else if (!timerRunning) {
      CFRunLoopRemoveTimer(runLoop, timer, CFRunLoopMode.commonModes)
    } else {
      CFRunLoopAddTimer(runLoop, timer, CFRunLoopMode.commonModes)
    }
  }

  private func stopTimer() {
    let runLoop = CFRunLoopGetCurrent()
    CFRunLoopRemoveTimer(runLoop, timer, CFRunLoopMode.commonModes)
    timerRunning = false
  }

  private func toolbarPlayButtonAction() {
    timerRunning = !timerRunning
    toolbarPlayImageName = toolbarPlayImageNameForTimerRunning(timerRunning)
    toolbarStopImageName = toolbarStopImageNameForTimerRunning(timerRunning)
    updateTimer()
  }

  private func toolbarStopButtonAction() {
    timerRunning = false
    toolbarPlayImageName = toolbarPlayImageNameForTimerRunning(timerRunning)
    toolbarStopImageName = toolbarStopImageNameForTimerRunning(timerRunning)
    stopTimer()
    // reset timer times

    testTime = 10.0
  }

  private func addStep() {
    let stepNumber = Int16(allTimerTimes.count)
    let newTimerTime = TimerTime(context: context)
    newTimerTime.id = UUID()
    newTimerTime.maxTime = 10.0
    newTimerTime.currentTime = 10.0
    newTimerTime.stepNumber = stepNumber

    do {
      try context.save()
      let currentTimes = timerSteps.map({ (timerStep: TimerStep) -> TimeInterval in
        return timerStep.currentTime
      })
      timerSteps = timerStepsFromTimerTimes(sortedTimerTimes: allTimerTimes, currentTimes: currentTimes)
    } catch {
      print(error)
    }
  }

  var body: some View {
    let timerToolbarParams = TimerToolbarParams(
      playCallback: toolbarPlayButtonAction,
      stopCallback: toolbarStopButtonAction,
      playImageSystemName: toolbarPlayImageName,
      stopImageSystemName: toolbarStopImageName)

    let currentTotalTime = allTimerTimes.map({ (timerTime) -> TimeInterval in
      return timerTime.currentTime
    }).reduce(0.0, { (cumulativeTime: TimeInterval, nextTime: TimeInterval) -> TimeInterval in
      return cumulativeTime + nextTime
    })

    return VStack {
      CountdownTimerText(params: CountdownTimerTextParams(timerRunning: false, timeInterval: currentTotalTime, font: .largeTitle))
      List(allTimerTimes) { timerTime in
        CountdownTimerText(params: CountdownTimerTextParams(timerRunning: false, timeInterval: timerTime.currentTime, font: .title))
      }
      Text("\(testTime)")
      Button(action: self.addStep) {
        Text("New")
      }
      TimerToolbar(params: timerToolbarParams)
    }

    /* New Plan

     VStack {
      CoundownUi(allSteps) -> produce a state based on steps param; state incl currentTimes
        CTText big currentTimes
        List -> CTText lessBig currentTime of step
             -> Delete Buttons
             -> plus Add New -> Button(addStepCallback?)...
      TimerToolbar(...)
     }

     */
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    return ContentView()
  }
}
