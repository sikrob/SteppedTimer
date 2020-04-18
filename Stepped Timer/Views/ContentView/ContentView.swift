//
//  ContentView.swift
//  Stepped Timer
//
//  Created by Robert Sikorski on 3/21/20.
//  Copyright © 2020 Robert Sikorski. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  @Environment(\.managedObjectContext) var context

  @State var state = ContentViewState(
    timerTimeSteps: [TimerTimeStep(id: UUID(), maxTime: 10.0, currentTime: 10.0),
                     TimerTimeStep(id: UUID(), maxTime: 20.0, currentTime: 20.0)],
    timerRunning: false,
    toolbarPlayImageName: "play.fill",
    toolbarStopImageName: "arrow.clockwise.circle.fill")

  private func toolbarPlayButtonAction() {
    state = updateStateOnPlayButtonAction(timerRunning: state.timerRunning,
                                          timerTimeSteps: state.timerTimeSteps)
  }

  private func toolbarStopButtonAction() {
    state = updateStateOnStopButtonAction(timerRunning: state.timerRunning,
                                          timerTimeSteps: state.timerTimeSteps)
  }

  var body: some View {
    let timerToolbarParams = TimerToolbarParams(
      playCallback: toolbarPlayButtonAction,
      stopCallback: toolbarStopButtonAction,
      playImageSystemName: state.toolbarPlayImageName,
      stopImageSystemName: state.toolbarStopImageName)

    let currentTotalTime = state.timerTimeSteps.map({ (timerTimeStep: TimerTimeStep) -> TimeInterval in
      return timerTimeStep.currentTime
    }).reduce(0.0, { (cumulativeTime: TimeInterval, nextTime: TimeInterval) -> TimeInterval in
      return cumulativeTime + nextTime
    })

    return VStack {
      CountdownTimerText(params: CountdownTimerTextParams(timeInterval: currentTotalTime, font: .largeTitle))
      List(state.timerTimeSteps) { timerTimeStep in
        CountdownTimerText(params: CountdownTimerTextParams(timeInterval: timerTimeStep.currentTime, font: .title))
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
