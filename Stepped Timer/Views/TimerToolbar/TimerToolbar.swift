//
//  TimerToolbar.swift
//  Stepped Timer
//
//  Created by Robert Sikorski on 3/21/20.
//  Copyright © 2020 Robert Sikorski. All rights reserved.
//

import SwiftUI

struct TimerToolbar: View {
  var playCallback: () -> Void
  var stopCallback: () -> Void
  var playImageSystemName: String
  var stopImageSystemName: String

  var body: some View {
    HStack {
      Spacer()
      Button(action: playCallback) {
        Image(systemName: playImageSystemName)
          .imageScale(.large)
      }
      Spacer()
      Button(action: stopCallback) {
        Image(systemName: stopImageSystemName)
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
    return TimerToolbar(playCallback: { },
                        stopCallback: { },
                        playImageSystemName: "play.fill",
                        stopImageSystemName: "stop.fill")
  }
}
