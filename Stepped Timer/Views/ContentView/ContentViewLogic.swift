//
//  ContentViewLogic.swift
//  Stepped Timer
//
//  Created by Robert Sikorski on 3/22/20.
//  Copyright © 2020 Robert Sikorski. All rights reserved.
//

import Foundation
import SwiftUI
import CoreData
import AVFoundation

// TimerTime Functions

func indexTimerTimes(sortedTimerTimes: FetchedResults<TimerTime>) {
  var index: Int16 = 0
  sortedTimerTimes.forEach({
    $0.stepNumber = index
    index += 1
  })
}

// AV Functions

func playStepSound(stepNumber: Int, gAudioPlayer: AVAudioPlayer, cAudioPlayer: AVAudioPlayer) {
  if stepNumber > 0 {
    gAudioPlayer.play()
  } else {
    cAudioPlayer.play()
  }
}

func prepareAudioPlayer(audioPlayer: AVAudioPlayer?, audioFilePath: String) -> AVAudioPlayer? {
  if audioPlayer != nil {
    return audioPlayer
  } else {
    do {
      let newAudioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioFilePath))
      newAudioPlayer.prepareToPlay()

      return newAudioPlayer
    } catch let error {
      print(error)
    }
  }

  return nil
}

// TimerStep Functions

func timerStepsFromTimerTimes(sortedTimerTimes: FetchedResults<TimerTime>, currentTimes: [TimeInterval]) -> [TimerStep] {
  return sortedTimerTimes.enumerated().map({ (index: Int, timerTime: TimerTime) -> TimerStep in
    let currentTime = index < currentTimes.count ? currentTimes[index] : timerTime.maxTime
    return TimerStep(id: timerTime.id!, maxTime: timerTime.maxTime, currentTime: currentTime, stepNumber: index)
  })
}

func maxTimeTimerSteps(sortedTimerTimes: FetchedResults<TimerTime>) -> [TimerStep] {
  return sortedTimerTimes.enumerated().map({ (index: Int, timerTime: TimerTime) -> TimerStep in
    return TimerStep(id: timerTime.id!, maxTime: timerTime.maxTime, currentTime: timerTime.maxTime, stepNumber: index)
  })
}

// Image Functions
func toolbarPlayImageNameForTimerRunning(_ timerRunning: Bool) -> String {
  return timerRunning ? "pause" : "play.fill"
}

func toolbarStopImageNameForTimerRunning(_ timerRunning: Bool) -> String {
  return timerRunning ? "stop.fill" : "arrow.clockwise.circle.fill"
}

func updateToolbarImageNames(toolbarPlayImageName: Binding<String>, toolbarStopImageName: Binding<String>, timerRunning: Bool) {
  toolbarPlayImageName.wrappedValue = toolbarPlayImageNameForTimerRunning(timerRunning)
  toolbarStopImageName.wrappedValue = toolbarStopImageNameForTimerRunning(timerRunning)
}
