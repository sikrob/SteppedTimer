//
//  ContentView.swift
//  Stepped Timer
//
//  Created by Robert Sikorski on 3/21/20.
//  Copyright © 2020 Robert Sikorski. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    var timerToolbarParams = TimerToolbarParams(
      playCallback: { },
      stopCallback: { },
      playImageSystemName: "play.fill",
      stopImageSystemName: "stop.fill")

    return VStack {
      Text("Yo!")
      Text("Yo!")
      Text("Yo!")
      Text("Yo!")
      // Toolbar
      TimerToolbar(params: timerToolbarParams)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    return ContentView()
  }
}
