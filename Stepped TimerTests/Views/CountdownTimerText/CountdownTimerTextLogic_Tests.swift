//
//  CountdownTimerTextLogic_Tests.swift
//  Stepped TimerTests
//
//  Created by Robert Sikorski on 3/29/20.
//  Copyright © 2020 Robert Sikorski. All rights reserved.
//

import XCTest
@testable import Stepped_Timer

class CountdownTimerTextLogic_Tests: XCTestCase {
  func test_convertTimeIntervalToTimerString() {
    let timeInterval = 0.0
    let result = convertTimeIntervalToTimerString(timeInterval: timeInterval)

    let expectedResult = "0.00"
    XCTAssertEqual(result, expectedResult)
  }
}
