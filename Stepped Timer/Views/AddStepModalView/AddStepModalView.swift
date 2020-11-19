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
struct AddStepModalView: View {
  @Environment(\.presentationMode) var presentation
  @State var numberOfSeconds: String = ""

  var submitCallback: (String) -> Void
  var closeCallback: () -> Void

  var body: some View {
    VStack {
      Text("Add a New Step")
        .font(.largeTitle)
      TextField("Number of seconds", text: $numberOfSeconds)
        .keyboardType(.numberPad)
        .onReceive(Just(numberOfSeconds), perform: { newValue in
          let filtered = newValue.filter { "0123456789".contains($0) }
          if filtered != newValue {
            self.numberOfSeconds = filtered
          }
        })
        .frame(width: 200)
        .padding()
        .border(Color.blue, width: 2)
      Button("Add Step") {
        self.submitCallback(self.numberOfSeconds)
        self.closeCallback()
      }
      Button("Cancel") {
        self.closeCallback()
      }
    }
  }
}

struct AddStepModalView_Previews: PreviewProvider {
  static var previews: some View {
    return AddStepModalView(submitCallback: { foo in return }, closeCallback: { return } )
  }
}
