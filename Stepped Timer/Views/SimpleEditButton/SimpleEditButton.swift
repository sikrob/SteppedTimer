//
//  SimpleEditButton.swift
//  Stepped Timer
//
//  Created by Robert Sikorski on 5/31/20.
//  Copyright © 2020 Robert Sikorski. All rights reserved.
//

import SwiftUI
import CoreData

struct SimpleEditButton: View {
  @Binding var editMode: EditMode

  @State var editButtonText: String = "Edit"

  private func editButtonAction() -> Void {
    if editMode == .active {
      editMode = .inactive
      editButtonText = "Edit"
    } else {
      editMode = .active
      editButtonText = "Done"
    }
  }

  var body: some View {
    Button(action: editButtonAction) {
      Text(editButtonText)
    }
  }
}
