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

        playStepSound(stepNumber: currentStep!, gAudioPlayer: self.gAudioPlayer!, cAudioPlayer: self.cAudioPlayer!)
      }
    } else {
      stopTimer(timer: $timer, timerRunning: $timerRunning)
      self.timer = nil
      self.timerDispatchTime = nil

      updateToolbarImageNames(toolbarPlayImageName: $toolbarPlayImageName, toolbarStopImageName: $toolbarStopImageName, timerRunning: self.timerRunning)
    }
  }

  private func toolbarPlayButtonAction() {
    let currentTimes = timerSteps.map({ (timerStep: TimerStep) -> TimeInterval in
      return timerStep.currentTime
    })
    timerSteps = timerStepsFromTimerTimes(sortedTimerTimes: allTimerTimes, currentTimes: currentTimes)

    if !timerRunning {
      startTimer()
    } else {
      stopTimer(timer: $timer, timerRunning: $timerRunning)
    }

    updateToolbarImageNames(toolbarPlayImageName: $toolbarPlayImageName, toolbarStopImageName: $toolbarStopImageName, timerRunning: timerRunning)
  }

  private func toolbarStopButtonAction() {
    if !timerRunning {
      timerSteps = maxTimeTimerSteps(sortedTimerTimes: allTimerTimes)
    } else {
      stopTimer(timer: $timer, timerRunning: $timerRunning)
    }

    updateToolbarImageNames(toolbarPlayImageName: $toolbarPlayImageName, toolbarStopImageName: $toolbarStopImageName, timerRunning: timerRunning)
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

  private func deleteStep(timerStep: TimerStep) {
    guard let timerTime: TimerTime = allTimerTimes.first(where: { (searchedTime: TimerTime) -> Bool in
      let stepNumber = searchedTime.stepNumber
      return searchedTime.stepNumber == timerStep.stepNumber
    }) else {
      print("deleteStep timerStep did not match a timerTime")
      return
    }

    context.delete(timerTime)

    do {
      try context.save()

      var index: Int16 = 0
      allTimerTimes.forEach({
        $0.stepNumber = index
        index += 1
      })

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

    let editModeInactive: Bool = self.editMode == .inactive

    return VStack {
      StepsToolbar(addStepCallback: addStep,
                   resetListCallback: resetSteps,
                   editMode: $editMode)

      CountdownTimerText(timeInterval: currentTotalTime, font: .largeTitle)
      List(wrappedTimes) { timerStep in
        HStack {
          Spacer()
          CountdownTimerText(timeInterval: timerStep.currentTime, font: .title)
          Spacer()
          Button(action: { self.deleteStep(timerStep: timerStep) }) { Image(systemName: "xmark.circle") }
            .disabled(editModeInactive)
            .opacity(editModeInactive ? 0.0 : 1.0)
            .animation(.easeInOut)
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
