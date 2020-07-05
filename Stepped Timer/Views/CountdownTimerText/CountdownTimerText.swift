//
//  CountdownTimerText.swift
//  Stepped Timer
//
//  Created by Robert Sikorski on 3/22/20.
//  Copyright © 2020 Robert Sikorski. All rights reserved.
//

import SwiftUI

// So ideally this is the text that we use in both the big and little timer labels,
// as in, this is a replacement for Text("label") where we can instead just drop in
// CountdownTimerText(params: { timeInterval: TimeInterval (Double), font: Font })
// and we get pretty formatted time in return (00:00:00.00)

struct CountdownTimerText: View {
  var timeInterval: TimeInterval
  var font: Font

  var body: some View {
    Text(convertTimeIntervalToTimerString(timeInterval: timeInterval))
      .font(font)
  }
}

struct CountdownTimerText_Previews: PreviewProvider {
  static var previews: some View {
    return CountdownTimerText(timeInterval: 1267.31, font: .largeTitle)
  }
}
