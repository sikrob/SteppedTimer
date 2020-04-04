//
//  ContentView.swift
//  Stepped Timer
//
//  Created by Robert Sikorski on 3/21/20.
//  Copyright © 2020 Robert Sikorski. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  @State private var timerRunning = false
  @State private var toolbarPlayImageName = "play.fill"
  @State private var toolbarStopImageName = "arrow.clockwise.circle.fill"

  // TBD: How to outsource stateupdate... can you? Can we do it if we make it public?

  private func toolbarPlayButtonAction() {
    if timerRunning {
      timerRunning = false
      toolbarPlayImageName = "play.fill"
      toolbarStopImageName = "arrow.clockwise.circle.fill"
    } else {
      timerRunning = true
      toolbarPlayImageName = "pause"
      toolbarStopImageName = "stop.fill"
    }
  }

  private func toolbarStopButtonAction() {
    if timerRunning {
      timerRunning = false
      toolbarPlayImageName = "play.fill"
      toolbarStopImageName = "arrow.clockwise.circle.fill"
    } else { // reset

    }
  }

  var body: some View {
    let timerToolbarParams = TimerToolbarParams(
      playCallback: toolbarPlayButtonAction,
      stopCallback: toolbarStopButtonAction,
      playImageSystemName: toolbarPlayImageName,
      stopImageSystemName: toolbarStopImageName)

    return VStack {
      Text("Big Timer")
      List {
        Text("Yo")
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
