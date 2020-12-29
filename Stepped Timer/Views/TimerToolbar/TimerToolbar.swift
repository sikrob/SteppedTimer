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
    return HStack {

      if (self.editMode == .inactive) {
        HStack {
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
        }.frame(height: 60.0)
      } else {
        HStack {
          Spacer()
          Text("About / Donate") // turn into button, create info/donate sheet
          Spacer()
        }.frame(height: 60.0)
      }

    }.background(Color(UIColor(named: "ToolbarBackgroundColor")!))
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
        get: { return EditMode.active },
        set: { _ in }
      )
    )
  }
}
