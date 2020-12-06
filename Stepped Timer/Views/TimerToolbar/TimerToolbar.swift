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
      HStack {
        Spacer()
          .frame(width: 30, height: 60, alignment: .center)
        Spacer()

        Button(action: playCallback) {
          Image(systemName: playImageSystemName)
            .resizable()
            .frame(width: 40, height: 40, alignment: .center)
        }
          .disabled(editMode != .inactive)
          .animation(.easeInOut)
        Spacer()
        Button(action: stopCallback) {
          Image(systemName: stopImageSystemName)
            .resizable()
            .frame(width: 40, height: 40, alignment: .center)
        }
          .disabled(editMode != .inactive)
          .animation(.easeInOut)

        Spacer()
        Button(action: { }) { // TODO: info, donate pay
          Image(systemName: "info.circle")
        }
          .frame(width: 25, height: 60, alignment: .center)
          .hidden() // unhide when ready
        Spacer()
          .frame(width: 5, height: 64, alignment: .center)
      }
      .frame(height: 60.0)
    }
    .background(Color(UIColor(named: "ToolbarBackgroundColor")!))
  }
}

struct TimerToolbar_Previews: PreviewProvider {
  static var previews: some View {
    return TimerToolbar(
      playCallback: { return },
      stopCallback: { return },
      playImageSystemName: "play.fill",
      stopImageSystemName: "arrow.clockwise.circle.fill",
      editMode: Binding<EditMode>(
        get: { return EditMode.inactive },
        set: { _ in }
      )
    )
  }
}
