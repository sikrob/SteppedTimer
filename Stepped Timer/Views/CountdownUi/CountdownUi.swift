//
//  CountdownUi.swift
//  Stepped Timer
//
//  Created by Robert Sikorski on 4/20/20.
//  Copyright © 2020 Robert Sikorski. All rights reserved.
//

import SwiftUI

struct CountdownUi: View {
  var running: Bool

  @State var coolVar: Int = 10



  var body: some View {
    VStack{
      Text("yo")
      Text("\(coolVar)")
    }
  }
}

struct CountdownUi_Previews: PreviewProvider {
  static var previews: some View {
    return CountdownUi(running: false)
  }
}
