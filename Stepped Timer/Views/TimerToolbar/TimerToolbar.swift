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
  @Binding var editMode: EditMode

  var body: some View {
    HStack {
      Spacer()
      Button(action: playCallback) {
        Image(systemName: playImageSystemName)
          .imageScale(.large)
      }
        .disabled(editMode != .inactive)
        .animation(.easeInOut)
      Spacer()
      Button(action: stopCallback) {
        Image(systemName: stopImageSystemName)
        .imageScale(.large)
      }
        .disabled(editMode != .inactive)
        .animation(.easeInOut)
      Spacer()
    }
    .frame(height: 60.0)
    .background(Color(UIColor(named: "ToolbarBackgroundColor")!))
  }
}
