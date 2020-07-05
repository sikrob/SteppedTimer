//
//  ContentView.swift
//  Stepped Timer
//
//  Created by Robert Sikorski on 3/21/20.
//  Copyright © 2020 Robert Sikorski. All rights reserved.
//

import SwiftUI
import CoreData
import AVFoundation

struct ContentView: View {
  @Environment(\.managedObjectContext) var context

  @FetchRequest(
    entity: TimerTime.entity(),
    sortDescriptors: [NSSortDescriptor(key: "stepNumber", ascending: true)]
  ) var allTimerTimes: FetchedResults<TimerTime>

  @State var timerSteps: [TimerStep] = []

  @State var timer: Timer? = nil
  @State var timerDispatchTime: DispatchTime? = nil
  @State var timerRunning: Bool = false

  @State var toolbarPlayImageName: String = toolbarPlayImageNameForTimerRunning(false)
  @State var toolbarStopImageName: String = toolbarStopImageNameForTimerRunning(false)

  @State var editMode: EditMode = EditMode.inactive

  let gPath: String? = Bundle.main.path(forResource: "G", ofType: "aiff", inDirectory: "Sounds")
  let cPath: String? = Bundle.main.path(forResource: "C", ofType: "aiff", inDirectory: "Sounds")
  var cAudioPlayer: AVAudioPlayer?
  var gAudioPlayer: AVAudioPlayer?

  init() {
    self.gAudioPlayer = prepareAudioPlayer(audioPlayer: self.gAudioPlayer, audioFilePath: self.gPath!)
    self.cAudioPlayer = prepareAudioPlayer(audioPlayer: self.cAudioPlayer, audioFilePath: self.cPath!)
  }

  private func startTimer() {
    let runLoop = CFRunLoopGetCurrent()
    timerDispatchTime = DispatchTime.now()

    if timer == nil {
      timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: updateTimer)
    }

    if !timerRunning {
      CFRunLoopAddTimer(runLoop, timer, CFRunLoopMode.commonModes)
    }

    timerRunning = true
  }

  private func updateTimer(_ scheduledTimer: Timer) {
    let currentStep: Int? = self.timerSteps.lastIndex(where: { (timerStep: TimerStep) -> Bool in
      return timerStep.currentTime > 0
    })

    if currentStep != nil {
      let deltaTime = DispatchTime.now()
      let delta = Double(deltaTime.uptimeNanoseconds - self.timerDispatchTime!.uptimeNanoseconds) / 1_000_000_000
      self.timerDispatchTime = deltaTime

      self.timerSteps[currentStep!].currentTime -= delta
      if self.timerSteps[currentStep!].currentTime <= 0 {
        self.timerSteps[currentStep!].currentTime = 0

        playStepSoud(stepNumber: currentStep!, gAudioPlayer: self.gAudioPlayer!, cAudioPlayer: self.cAudioPlayer!)
      }
    } else {
      self.stopTimer()
      self.timer = nil
      self.timerDispatchTime = nil

      updateToolbarImageNames()
    }
  }

  private func stopTimer() {
    if self.timer != nil {
      let runLoop = CFRunLoopGetCurrent()
      CFRunLoopRemoveTimer(runLoop, self.timer, CFRunLoopMode.commonModes)
    }
    self.timerRunning = false
  }

  private func updateToolbarImageNames() {
    self.toolbarPlayImageName = toolbarPlayImageNameForTimerRunning(self.timerRunning)
    self.toolbarStopImageName = toolbarStopImageNameForTimerRunning(self.timerRunning)
  }

  private func toolbarPlayButtonAction() {
    let currentTimes = timerSteps.map({ (timerStep: TimerStep) -> TimeInterval in
      return timerStep.currentTime
    })
    timerSteps = timerStepsFromTimerTimes(sortedTimerTimes: allTimerTimes, currentTimes: currentTimes)

    if !timerRunning {
      startTimer()
    } else {
      stopTimer()
    }

    updateToolbarImageNames()
  }

  private func toolbarStopButtonAction() {
    if !timerRunning {
      timerSteps = maxTimeTimerSteps(sortedTimerTimes: allTimerTimes)
    } else {
      stopTimer()
    }

    updateToolbarImageNames()
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
    newTimerTime.maxTime = 5.0
    newTimerTime.currentTime = 5.0
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
      StepsToolbar(addStepCallback: addStep,
                   resetListCallback: resetSteps,
                   editMode: $editMode)

      CountdownTimerText(timeInterval: currentTotalTime, font: .largeTitle)
      List(wrappedTimes) { timerTime in
        if self.editMode == .inactive {
          HStack {
            Spacer()
            CountdownTimerText(timeInterval: timerTime.currentTime, font: .title)
            Spacer()
          }
        } else {
          HStack {
            Spacer()
            CountdownTimerText(timeInterval: timerTime.currentTime, font: .title)
            Spacer()
            Button(action: self.addStep) { Image(systemName: "xmark.circle") }
          }
        }
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
