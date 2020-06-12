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
        .padding(.leading, buttonPadding)
      Spacer()
      Button(action: resetListCallback) { Text("Reset") }
        .disabled(editMode == .inactive)
        .opacity(editMode == .inactive ? 0 : 1)
        .animation(.easeInOut)
      Spacer()
      SimpleEditButton(editMode: $editMode)
        .padding(.trailing, buttonPadding)
    }.padding(.bottom, buttonPadding)
  }
}
