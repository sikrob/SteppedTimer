//
//  AddStepView.swift
//  Stepped Timer
//
//  Created by Robert Sikorski on 11/18/20.
//  Copyright © 2020 Robert Sikorski. All rights reserved.
//

import SwiftUI
import Combine

// Modal view for adding steps configured with the desired max time.
struct AddStepView: View {
  @State var numberOfSeconds: String = ""

  var cancelCallback: () -> Void

  var body: some View {
    VStack {
      Text("Add New Step")
      TextField("Number of seconds", text: $numberOfSeconds)
        .keyboardType(.numberPad)
        .onReceive(Just(numberOfSeconds), perform: { newValue in
          let filtered = newValue.filter { "0123456789".contains($0) }
          if filtered != newValue {
            self.numberOfSeconds = filtered
          }
        })
      Button("Cancel") {
        self.cancelCallback()
      }
    }
  }
}

struct AddStepView_Previews: PreviewProvider {
  static var previews: some View {
    return AddStepView(cancelCallback: { return } )
  }
}
