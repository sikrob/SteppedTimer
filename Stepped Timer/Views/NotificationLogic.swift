//
//  NotificationLogic.swift
//  Stepped Timer
//
//  Created by Robert Sikorski on 11/16/20.
//  Copyright © 2020 Robert Sikorski. All rights reserved.
//

import UserNotifications

func requestNotificationAuthorization(callbackAction: () -> Void) {
  let center = UNUserNotificationCenter.current()
  var success = false
  center.requestAuthorization(options: [.alert, .sound], completionHandler: { granted, error in
    if let _ = error {
      // notify user to let them know this means we can't run in the background...
    } else {
      success = true
    }
  })

  if (success) {
    callbackAction()
  }
}
