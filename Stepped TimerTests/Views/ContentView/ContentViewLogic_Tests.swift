//
//  ContentViewLogic_Tests.swift
//  Stepped TimerTests
//
//  Created by Robert Sikorski on 4/6/20.
//  Copyright © 2020 Robert Sikorski. All rights reserved.
//

import XCTest
@testable import Stepped_Timer

class ContentViewLogic_Tests: XCTestCase {
  func test_updateStateOnPlayButtonAction_returnPlayingStateIfNotTimerRunning() {
    let timerRunning = false
    let maxTimes = [10.0]
    let currentTimes = [5.0]
    let result = updateStateOnPlayButtonAction(timerRunning: timerRunning, maxTimes: maxTimes, currentTimes: currentTimes)

    let expectedResult = ContentViewState(maxTimes: [10.0], currentTimes: [5.0],
                                          timerRunning: true, toolbarPlayImageName: "pause", toolbarStopImageName: "stop.fill")
    XCTAssertEqual(result.maxTimes, expectedResult.maxTimes)
    XCTAssertEqual(result.currentTimes, expectedResult.currentTimes)
    XCTAssertEqual(result.timerRunning, expectedResult.timerRunning)
    XCTAssertEqual(result.toolbarPlayImageName, expectedResult.toolbarPlayImageName)
    XCTAssertEqual(result.toolbarStopImageName, expectedResult.toolbarStopImageName)
  }

  func test_updateStateOnPlayButtonAction_returnNonPlayingStateIfTimerRunning() {
    let timerRunning = true
    let maxTimes = [10.0]
    let currentTimes = [5.0]
    let result = updateStateOnPlayButtonAction(timerRunning: timerRunning, maxTimes: maxTimes, currentTimes: currentTimes)

    let expectedResult = ContentViewState(maxTimes: [10.0], currentTimes: [5.0],
                                          timerRunning: false, toolbarPlayImageName: "play.fill", toolbarStopImageName: "arrow.clockwise.circle.fill")
    XCTAssertEqual(result.timerRunning, expectedResult.timerRunning)
    XCTAssertEqual(result.maxTimes, expectedResult.maxTimes)
    XCTAssertEqual(result.currentTimes, expectedResult.currentTimes)
    XCTAssertEqual(result.toolbarPlayImageName, expectedResult.toolbarPlayImageName)
    XCTAssertEqual(result.toolbarStopImageName, expectedResult.toolbarStopImageName)
  }

  func test_updateStateOnStopButtonAction_returnNonPlayingStateIfTimerRunning() {
    let timerRunning = true
    let maxTimes = [10.0]
    let currentTimes = [5.0]
    let result = updateStateOnStopButtonAction(timerRunning: timerRunning, maxTimes: maxTimes, currentTimes: currentTimes)

    let expectedResult = ContentViewState(maxTimes: [10.0], currentTimes: [5.0],
                                          timerRunning: false, toolbarPlayImageName: "play.fill", toolbarStopImageName: "arrow.clockwise.circle.fill")
    XCTAssertEqual(result.maxTimes, expectedResult.maxTimes)
    XCTAssertEqual(result.currentTimes, expectedResult.currentTimes)
    XCTAssertEqual(result.timerRunning, expectedResult.timerRunning)
    XCTAssertEqual(result.toolbarPlayImageName, expectedResult.toolbarPlayImageName)
    XCTAssertEqual(result.toolbarStopImageName, expectedResult.toolbarStopImageName)
  }

  func test_updateStateOnStopButtonAction_returnResetNonPlayingStateIfNotTimerRunning() {
    let timerRunning = false
    let maxTimes = [10.0]
    let currentTimes = [5.0]
    let result = updateStateOnStopButtonAction(timerRunning: timerRunning, maxTimes: maxTimes, currentTimes: currentTimes)

    let expectedResult = ContentViewState(maxTimes: [10.0], currentTimes: [10.0],
                                          timerRunning: false, toolbarPlayImageName: "play.fill", toolbarStopImageName: "arrow.clockwise.circle.fill")
    XCTAssertEqual(result.maxTimes, expectedResult.maxTimes)
    XCTAssertEqual(result.currentTimes, expectedResult.currentTimes)
    XCTAssertEqual(result.timerRunning, expectedResult.timerRunning)
    XCTAssertEqual(result.toolbarPlayImageName, expectedResult.toolbarPlayImageName)
    XCTAssertEqual(result.toolbarStopImageName, expectedResult.toolbarStopImageName)
  }
}
