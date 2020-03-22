//
//  ContentView.swift
//  Stepped Timer
//
//  Created by Robert Sikorski on 3/21/20.
//  Copyright © 2020 Robert Sikorski. All rights reserved.
//

import SwiftUI

struct ContentView: View {  
  @State private var toolbarPlayImageName = "play.fill"
  @State private var toolbarStopImageName = "stop.fill"

  private func toolbarPlayButtonAction() {
    // determine timer state
    // set update
    // set new image name
    toolbarPlayImageName = "pause"
  }
  private func toolbarStopButtonAction() {
    toolbarStopImageName = "stop"
  }

  var body: some View {
    let timerToolbarParams = TimerToolbarParams(
      playCallback: toolbarPlayButtonAction,
      stopCallback: toolbarStopButtonAction,
      playImageSystemName: toolbarPlayImageName,
      stopImageSystemName: toolbarStopImageName)

    return VStack {
      TimerToolbar(params: timerToolbarParams)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    return ContentView()
  }
}
