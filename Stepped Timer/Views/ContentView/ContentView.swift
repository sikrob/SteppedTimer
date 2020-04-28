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

  @State var state = ContentViewState(
    timerTimeSteps: [],
    timerRunning: false,
    toolbarPlayImageName: "play.fill",
    toolbarStopImageName: "arrow.clockwise.circle.fill")

  @State var timerAction: Timer? = nil
  @State var testTime: TimeInterval = 1.0

  private func updateTimer() {
    if timerAction == nil {
      let runLoop = CFRunLoopGetCurrent()
      timerAction = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { (Timer) -> Void in
        print("running self.testTime \(self.testTime)")
        if (self.testTime > 0) {
          self.testTime -= 0.1
        } else {
          CFRunLoopRemoveTimer(runLoop, self.timerAction, CFRunLoopMode.commonModes)
        }
      })
      CFRunLoopAddTimer(runLoop, timerAction, CFRunLoopMode.commonModes)
    }
  }

  private func toolbarPlayButtonAction() {
    state = updateStateOnPlayButtonAction(timerRunning: state.timerRunning,
                                          timerTimeSteps: state.timerTimeSteps)
    updateTimer()
  }

  private func toolbarStopButtonAction() {
    state = updateStateOnStopButtonAction(timerRunning: state.timerRunning,
                                          timerTimeSteps: state.timerTimeSteps)
    testTime = 1.0
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
      let currentTimes = state.timerTimeSteps.map({ (timerTimeStep: TimerTimeStep) -> TimeInterval in
        return timerTimeStep.currentTime
      })
      state.timerTimeSteps = timerTimeStepsFromTimerTimes(sortedTimerTimes: allTimerTimes, currentTimes: currentTimes)
    } catch {
      print(error)
    }
  }

  var body: some View {
    let timerToolbarParams = TimerToolbarParams(
      playCallback: toolbarPlayButtonAction,
      stopCallback: toolbarStopButtonAction,
      playImageSystemName: state.toolbarPlayImageName,
      stopImageSystemName: state.toolbarStopImageName)

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
