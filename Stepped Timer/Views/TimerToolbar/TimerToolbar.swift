//
//  TimerToolbar.swift
//  Stepped Timer
//
//  Created by Robert Sikorski on 3/21/20.
//  Copyright © 2020 Robert Sikorski. All rights reserved.
//

import SwiftUI

struct TimerToolbar: View {
  var params: TimerToolbarParams

  var body: some View {
    HStack {
      Spacer()
      Button(action: params.playCallback) {
        Image(systemName: params.playImageSystemName)
          .imageScale(.large)
      }
      Spacer()
      Button(action: params.stopCallback) {
        Image(systemName: params.stopImageSystemName)
        .imageScale(.large)
      }
      Spacer()
    }
    .frame(height: 60.0)
    .background(Color(UIColor(named: "ToolbarBackgroundColor")!))
  }
}

struct TimerToolbar_Previews: PreviewProvider {
  static var previews: some View {
    let timerToolbarParams = TimerToolbarParams(
      playCallback: { },
      stopCallback: { },
      playImageSystemName: "play.fill",
      stopImageSystemName: "stop.fill")
    return TimerToolbar(params: timerToolbarParams)
  }
}
