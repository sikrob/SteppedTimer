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

func playStepSoud(stepNumber: Int, gAudioPlayer: AVAudioPlayer, cAudioPlayer: AVAudioPlayer) {
  if stepNumber > 0 {
    gAudioPlayer.play()
  } else {
    cAudioPlayer.play()
  }
}

// Still results in a delay on first prepare, not sure how to bypass that with swift UI... ideally we'd have that all sorted in constructor
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

func timerStepsFromTimerTimes(sortedTimerTimes: FetchedResults<TimerTime>, currentTimes: [TimeInterval]) -> [TimerStep] {
  return sortedTimerTimes.enumerated().map({ (index: Int, timerTime: TimerTime) -> TimerStep in
    let currentTime = index < currentTimes.count ? currentTimes[index] : timerTime.maxTime
    return TimerStep(id: timerTime.id!, maxTime: timerTime.maxTime, currentTime: currentTime)
  })
}

func maxTimeTimerSteps(sortedTimerTimes: FetchedResults<TimerTime>) -> [TimerStep] {
  return sortedTimerTimes.map({ (timerTime: TimerTime) -> TimerStep in
    return TimerStep(id: timerTime.id!, maxTime: timerTime.maxTime, currentTime: timerTime.maxTime)
  })
}

func toolbarPlayImageNameForTimerRunning(_ timerRunning: Bool) -> String {
  return timerRunning ? "pause" : "play.fill"
}

func toolbarStopImageNameForTimerRunning(_ timerRunning: Bool) -> String {
  return timerRunning ? "stop.fill" : "arrow.clockwise.circle.fill"
}
