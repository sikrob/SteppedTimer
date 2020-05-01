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

  // NOTE: Right now we are just using scheduled timer under the assumption that 0.01 is generous enough on resources for accuracy.
  // However, this is likely less accurate than polling time on each loop. We *shouldn't* trust the Timer because it is only fired
  // on that interval, not run on that interval, to say nothing of execution.

  // Notable problems so far: Pauses between step execution... why? Is this due to Swift UI? Anyway, DEFINITELY means we need to
  // retool timing again, but for now we need to finish this and make the code clean, THEN (hopefully) we can just gut the logic
  // and reset it.
  private func updateTimer() {
    let runLoop = CFRunLoopGetCurrent()

    if timer == nil {
      timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { (Timer) in
        let currentStep: Int? = self.timerSteps.lastIndex(where: { (timerStep: TimerStep) -> Bool in
          return timerStep.currentTime > 0
        })

        if currentStep != nil {
          self.timerSteps[currentStep!].currentTime -= 0.1
          if self.timerSteps[currentStep!].currentTime <= 0 { // in case of weird math
            self.timerSteps[currentStep!].currentTime = 0
          }
        } else {
          CFRunLoopRemoveTimer(runLoop, self.timer, CFRunLoopMode.commonModes)
          self.timer = nil
          // ensure button graphics are updated
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
    if timer != nil {
      let runLoop = CFRunLoopGetCurrent()
      CFRunLoopRemoveTimer(runLoop, timer, CFRunLoopMode.commonModes)
    }
    timerRunning = false
  }

  private func toolbarPlayButtonAction() {
    let currentTimes = timerSteps.map({ (timerStep: TimerStep) -> TimeInterval in
      return timerStep.currentTime
    })
    timerSteps = timerStepsFromTimerTimes(sortedTimerTimes: allTimerTimes, currentTimes: currentTimes)

    timerRunning = !timerRunning
    toolbarPlayImageName = toolbarPlayImageNameForTimerRunning(timerRunning)
    toolbarStopImageName = toolbarStopImageNameForTimerRunning(timerRunning)
    updateTimer()
  }

  private func toolbarStopButtonAction() {
    if timerRunning == false {
      timerSteps = maxTimeTimerSteps(sortedTimerTimes: allTimerTimes)
    } else {
      timerRunning = false
      stopTimer()
    }

    toolbarPlayImageName = toolbarPlayImageNameForTimerRunning(timerRunning)
    toolbarStopImageName = toolbarStopImageNameForTimerRunning(timerRunning)
  }

  private func resetSteps() {
    allTimerTimes.forEach({ (timerTime) in
      context.delete(timerTime)
    })

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

    let currentTimes = timerSteps.map({ (timerStep: TimerStep) -> TimeInterval in
      return timerStep.currentTime
    })
    let wrappedTimes = timerStepsFromTimerTimes(sortedTimerTimes: allTimerTimes, currentTimes: currentTimes)

    let currentTotalTime = wrappedTimes.map({ (timerTime) -> TimeInterval in
      return timerTime.currentTime
    }).reduce(0.0, { (cumulativeTime: TimeInterval, nextTime: TimeInterval) -> TimeInterval in
      return cumulativeTime + nextTime
    })

    return VStack {
      CountdownTimerText(params: CountdownTimerTextParams(timerRunning: false, timeInterval: currentTotalTime, font: .largeTitle))
      List(wrappedTimes) { timerTime in
        CountdownTimerText(params: CountdownTimerTextParams(timerRunning: false, timeInterval: timerTime.currentTime, font: .title))
      }
      Button(action: self.resetSteps) {
        Text("Reset")
      }
      Button(action: self.addStep) {
        Text("New")
      }
      TimerToolbar(params: timerToolbarParams)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    return ContentView()
  }
}
