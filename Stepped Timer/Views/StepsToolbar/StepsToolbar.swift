//
//  StepsToolbar.swift
//  Stepped Timer
//
//  Created by Robert Sikorski on 6/11/20.
//  Copyright © 2020 Robert Sikorski. All rights reserved.
//

import SwiftUI

struct StepsToolbar: View {
  var addStepCallback: () -> Void
  var resetListCallback: () -> Void
  @Binding var editMode: EditMode
  @Binding var timerRunning: Bool

  // now create a modal that gets activated by stepstoolbar
  // and pass addStepCallback again down the line
  // we will update addStepCallback to include whatever
  // we need to make it add the form data

  // reset should open a modal that asks
  // are you sure?

  var body: some View {
    let buttonPadding: CGFloat = 20

    return HStack {
      Button(action: addStepCallback) { Text("Add") }
        .disabled(timerRunning)
        .opacity(timerRunning ? 0 : 1)
        .padding(.leading, buttonPadding)
        .animation(.easeInOut)
      Spacer()
      Button(action: resetListCallback) { Text("Delete All") }
        .disabled(timerRunning || editMode == .inactive)
        .opacity(timerRunning || editMode == .inactive ? 0 : 1)
        .animation(.easeInOut)
      Spacer()
      SimpleEditButton(editMode: $editMode)
        .disabled(timerRunning)
        .opacity(timerRunning ? 0 : 1)
        .padding(.trailing, buttonPadding)
        .animation(.easeInOut)
    }.padding(.bottom, buttonPadding)
  }
}
