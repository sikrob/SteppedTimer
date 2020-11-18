//
//  NotificationLogic.swift
//  Stepped Timer
//
//  Created by Robert Sikorski on 11/16/20.
//  Copyright © 2020 Robert Sikorski. All rights reserved.
//

import UserNotifications

// THIS HAS BEEN BACK BURNERED UNTIL A FUTURE VERSION - WE DON'T NEED THIS TO MAKE THIS APP WORK GENERALLY.

// Ask on first press play, which is closest point to notification.
func requestNotificationAuthorization() {
  let center = UNUserNotificationCenter.current()
  center.requestAuthorization(options: [.alert, .sound], completionHandler: { granted, error in
    if let _ = error {
      // not background running
    }
  })
}

// any should probably be TimeStep? or something more reduced? what's actually available when we head to background?
func scheduleAlerts(steps: [Any]) {
  let center = UNUserNotificationCenter.current()
  center.getNotificationSettings(completionHandler: { settings in
    guard (settings.authorizationStatus == .authorized) ||
          (settings.authorizationStatus == .provisional)
    else { return }


  })
}

func scheduleAlert() {

}
