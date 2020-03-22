//
//  TimerToolbarParams.swift
//  Stepped Timer
//
//  Created by Robert Sikorski on 3/21/20.
//  Copyright © 2020 Robert Sikorski. All rights reserved.
//

struct TimerToolbarParams {
  var playCallback: () -> Void
  var stopCallback: () -> Void
  var playImageSystemName: String
  var stopImageSystemName: String
}
