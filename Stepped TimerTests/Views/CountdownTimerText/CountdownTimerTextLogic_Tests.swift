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
  func test_convertTimeIntervalToTimerString_convertsSingleDigitSeconds() {
    let timeInterval = 1.0
    let result = convertTimeIntervalToTimerString(timeInterval: timeInterval)

    let expectedResult = "00:01.0"
    XCTAssertEqual(result, expectedResult)
  }

  func test_convertTimeIntervalToTimerString_convertsDoubleDigitSeconds() {
    let timeInterval = 10.0
    let result = convertTimeIntervalToTimerString(timeInterval: timeInterval)

    let expectedResult = "00:10.0"
    XCTAssertEqual(result, expectedResult)
  }

  func test_convertTimeIntervalToTimerString_convertsSingleDigitMinutes() {
    let timeInterval = 60.0
    let result = convertTimeIntervalToTimerString(timeInterval: timeInterval)

    let expectedResult = "01:00.0"
    XCTAssertEqual(result, expectedResult)
  }

  func test_convertTimeIntervalToTimerString_convertsDoubleDigitMinutes() {
    let timeInterval = 600.0
    let result = convertTimeIntervalToTimerString(timeInterval: timeInterval)

    let expectedResult = "10:00.0"
    XCTAssertEqual(result, expectedResult)
  }

  func test_convertTimeIntervalToTimerString_convertsFractionalSeconds() {
    let timeInterval = 0.1
    let result = convertTimeIntervalToTimerString(timeInterval: timeInterval)

    let expectedResult = "00:00.1"
    XCTAssertEqual(result, expectedResult)
  }

  func test_convertTimeIntervalToTimerString_truncatesDeeplyFractionalSeconds() {
    let timeInterval = 0.987654321
    let result = convertTimeIntervalToTimerString(timeInterval: timeInterval)

    let expectedResult = "00:00.9"
    XCTAssertEqual(result, expectedResult)
  }

  func test_convertTimeIntervalToTimerString_convertsComplexValues() {
    let timeInterval = 687.777777
    let result = convertTimeIntervalToTimerString(timeInterval: timeInterval)

    let expectedResult = "11:27.7"
    XCTAssertEqual(result, expectedResult)
  }
}
