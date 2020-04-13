//
//  ContentView.swift
//  Stepped Timer
//
//  Created by Robert Sikorski on 3/21/20.
//  Copyright © 2020 Robert Sikorski. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  @State var state = ContentViewState(timerTimes: [TimerTime(maxTime: 10.0, currentTime: 10.0),
                                                   TimerTime(maxTime: 20.0, currentTime: 20.0)],
                                      timerRunning: false,
                                      toolbarPlayImageName: "play.fill",
                                      toolbarStopImageName: "arrow.clockwise.circle.fill")

  private func toolbarPlayButtonAction() {
    state = updateStateOnPlayButtonAction(timerRunning: state.timerRunning,
                                          timerTimes: state.timerTimes)
  }

  private func toolbarStopButtonAction() {
    state = updateStateOnStopButtonAction(timerRunning: state.timerRunning,
                                          timerTimes: state.timerTimes)
  }

  var body: some View {
    let timerToolbarParams = TimerToolbarParams(
      playCallback: toolbarPlayButtonAction,
      stopCallback: toolbarStopButtonAction,
      playImageSystemName: state.toolbarPlayImageName,
      stopImageSystemName: state.toolbarStopImageName)

    let currentTotalTime = state.timerTimes.map({ (timerTime: TimerTime) -> TimeInterval in
      return timerTime.currentTime
    }).reduce(0.0, { (cumulativeTime: TimeInterval, nextTime: TimeInterval) -> TimeInterval in
      return cumulativeTime + nextTime
    })

    return VStack {
      CountdownTimerText(params: CountdownTimerTextParams(timeInterval: currentTotalTime, font: .largeTitle))
      List(state.timerTimes) { timerTime in
        CountdownTimerText(params: CountdownTimerTextParams(timeInterval: timerTime.currentTime, font: .title))
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
