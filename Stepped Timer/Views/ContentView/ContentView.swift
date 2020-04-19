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
//    timerTimeSteps: [TimerTimeStep(id: UUID(), maxTime: 10.0, currentTime: 10.0),
//                     TimerTimeStep(id: UUID(), maxTime: 20.0, currentTime: 20.0)],
    timerTimeSteps: [],
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

  private func addStep() {
    let newTimerTime = TimerTime(context: context)
    newTimerTime.id = UUID()
    newTimerTime.maxTime = 10.0
    newTimerTime.currentTime = 10.0
    newTimerTime.stepNumber = Int16(state.timerTimeSteps.count)

    do {
      try context.save()
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

    let currentTotalTime = state.timerTimeSteps.map({ (timerTimeStep: TimerTimeStep) -> TimeInterval in
      return timerTimeStep.currentTime
    }).reduce(0.0, { (cumulativeTime: TimeInterval, nextTime: TimeInterval) -> TimeInterval in
      return cumulativeTime + nextTime
    })

    return VStack {
      CountdownTimerText(params: CountdownTimerTextParams(timeInterval: currentTotalTime, font: .largeTitle))
      List(allTimerTimes) { timerTime in
        CountdownTimerText(params: CountdownTimerTextParams(timeInterval: timerTime.currentTime, font: .title))
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
