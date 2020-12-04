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

struct StepsToolbar_Previews: PreviewProvider {
  static var previews: some View {
    let foo = Binding<EditMode>(get: { return EditMode.active }, set: { _ in return })
    let bar = Binding<Bool>(get: { return true }, set: { _ in return })

    return StepsToolbar(addStepCallback: { return }, resetListCallback: { return }, editMode: foo, timerRunning: bar)
  }
}
