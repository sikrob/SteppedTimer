//
//  AboutModalView.swift
//  Stepped Timer
//
//  Created by Robert Sikorski on 12/30/20.
//  Copyright © 2020 Robert Sikorski. All rights reserved.
//

import SwiftUI

struct AboutModalView: View {
  var closeCallback: () -> Void

  private let ABOUT_TEXT = "Stepped Timer was created to make it easier to have timers runnings for multistep processes - like pour over coffee, or cooking tasks where you need to flip something repeatedly before it's actually done.\n\nIt was developed by Robert Sikorski shortly after his first child came along - and paying attention to a silent clock or stopwatch got a lot harder!"
  private let DONATE_TEXT = "If you like this app, please consider supporting the dev!"

  var body: some View {
    VStack {
      Text(self.ABOUT_TEXT).padding(10)
      Text(self.DONATE_TEXT).padding(10)
      Button(action: closeCallback, label: {
        Text("Close")
      })
    }
  }
}

struct AboutModalView_Previews: PreviewProvider {
  static var previews: some View {
    return AboutModalView(closeCallback: { return })
  }
}
