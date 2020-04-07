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
    let maxTime = 10.0
    let currentTime = 5.0
    let result = updateStateOnPlayButtonAction(timerRunning: timerRunning, maxTime: maxTime, currentTime: currentTime)

    let expectedResult = ContentViewState(maxTime: 10.0, currentTime: 5.0,
                                          timerRunning: true, toolbarPlayImageName: "pause", toolbarStopImageName: "stop.fill")
    XCTAssertEqual(result.maxTime, expectedResult.maxTime)
    XCTAssertEqual(result.currentTime, expectedResult.currentTime)
    XCTAssertEqual(result.timerRunning, expectedResult.timerRunning)
    XCTAssertEqual(result.toolbarPlayImageName, expectedResult.toolbarPlayImageName)
    XCTAssertEqual(result.toolbarStopImageName, expectedResult.toolbarStopImageName)
  }

  func test_updateStateOnPlayButtonAction_returnNonPlayingStateIfTimerRunning() {
    let timerRunning = true
    let maxTime = 10.0
    let currentTime = 5.0
    let result = updateStateOnPlayButtonAction(timerRunning: timerRunning, maxTime: maxTime, currentTime: currentTime)


    let expectedResult = ContentViewState(maxTime: 10.0, currentTime: 5.0,
                                          timerRunning: false, toolbarPlayImageName: "play.fill", toolbarStopImageName: "arrow.clockwise.circle.fill")
    XCTAssertEqual(result.timerRunning, expectedResult.timerRunning)
    XCTAssertEqual(result.maxTime, expectedResult.maxTime)
    XCTAssertEqual(result.currentTime, expectedResult.currentTime)
    XCTAssertEqual(result.toolbarPlayImageName, expectedResult.toolbarPlayImageName)
    XCTAssertEqual(result.toolbarStopImageName, expectedResult.toolbarStopImageName)
  }

  func test_updateStateOnStopButtonAction_returnNonPlayingStateIfTimerRunning() {
    let timerRunning = true
    let maxTime = 10.0
    let currentTime = 5.0
    let result = updateStateOnStopButtonAction(timerRunning: timerRunning, maxTime: maxTime, currentTime: currentTime)

    let expectedResult = ContentViewState(maxTime: 10.0, currentTime: 5.0,
                                          timerRunning: false, toolbarPlayImageName: "play.fill", toolbarStopImageName: "arrow.clockwise.circle.fill")
    XCTAssertEqual(result.maxTime, expectedResult.maxTime)
    XCTAssertEqual(result.currentTime, expectedResult.currentTime)
    XCTAssertEqual(result.timerRunning, expectedResult.timerRunning)
    XCTAssertEqual(result.toolbarPlayImageName, expectedResult.toolbarPlayImageName)
    XCTAssertEqual(result.toolbarStopImageName, expectedResult.toolbarStopImageName)
  }

  func test_updateStateOnStopButtonAction_returnResetNonPlayingStateIfNotTimerRunning() {
    let timerRunning = false
    let maxTime = 10.0
    let currentTime = 5.0
    let result = updateStateOnStopButtonAction(timerRunning: timerRunning, maxTime: maxTime, currentTime: currentTime)

    let expectedResult = ContentViewState(maxTime: 10.0, currentTime: 10.0,
                                          timerRunning: false, toolbarPlayImageName: "play.fill", toolbarStopImageName: "arrow.clockwise.circle.fill")
    XCTAssertEqual(result.maxTime, expectedResult.maxTime)
    XCTAssertEqual(result.currentTime, expectedResult.currentTime)
    XCTAssertEqual(result.timerRunning, expectedResult.timerRunning)
    XCTAssertEqual(result.toolbarPlayImageName, expectedResult.toolbarPlayImageName)
    XCTAssertEqual(result.toolbarStopImageName, expectedResult.toolbarStopImageName)
  }
}
