//
//  ContentView.swift
//  Stepped Timer
//
//  Created by Robert Sikorski on 3/21/20.
//  Copyright © 2020 Robert Sikorski. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  @State var state = ContentViewState(maxTimes: [0.0],
                                      currentTimes: [0.0],
                                      timerRunning: false,
                                      toolbarPlayImageName: "play.fill",
                                      toolbarStopImageName: "arrow.clockwise.circle.fill")

  private func toolbarPlayButtonAction() {
    state = updateStateOnPlayButtonAction(timerRunning: state.timerRunning,
                                          maxTimes: state.maxTimes,
                                          currentTimes: state.currentTimes)
  }

  private func toolbarStopButtonAction() {
    state = updateStateOnStopButtonAction(timerRunning: state.timerRunning,
                                          maxTimes: state.maxTimes,
                                          currentTimes: state.currentTimes)
  }

  var body: some View {
    let timerToolbarParams = TimerToolbarParams(
      playCallback: toolbarPlayButtonAction,
      stopCallback: toolbarStopButtonAction,
      playImageSystemName: state.toolbarPlayImageName,
      stopImageSystemName: state.toolbarStopImageName)

    return VStack {
      CountdownTimerText(params: CountdownTimerTextParams(timeInterval: 240.0, font: .largeTitle))
      List {
        CountdownTimerText(params: CountdownTimerTextParams(timeInterval: 210.0, font: .title))
        CountdownTimerText(params: CountdownTimerTextParams(timeInterval: 30.0, font: .title))
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
