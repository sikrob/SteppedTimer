//
//  CountdownTimerText.swift
//  Stepped Timer
//
//  Created by Robert Sikorski on 3/22/20.
//  Copyright © 2020 Robert Sikorski. All rights reserved.
//

import SwiftUI

struct CountdownTimerText: View {
  var params: CountdownTimerTextParams

  var body: some View {
    Text("foo")
  }
}

struct CountdownTimerText_Previews: PreviewProvider {
  static var previews: some View {
    let countdownTimerTextParams = CountdownTimerTextParams()
    return CountdownTimerText(params: countdownTimerTextParams)
  }
}
