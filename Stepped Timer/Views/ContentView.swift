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

  private func toolbarPlayButtonCallback() {
    toolbarPlayImageName = "pause"
  }

  var body: some View {
    let timerToolbarParams = TimerToolbarParams(
      playCallback: toolbarPlayButtonCallback,
      stopCallback: { },
      playImageSystemName: toolbarPlayImageName,
      stopImageSystemName: toolbarStopImageName)

    return VStack {
      Text("Yo!")
      Text("Yo!")
      Text("Yo!")
      Text("Yo!")
      TimerToolbar(params: timerToolbarParams)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    return ContentView()
  }
}
