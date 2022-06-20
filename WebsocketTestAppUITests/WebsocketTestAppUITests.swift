//
//  WebsocketTestAppUITests.swift
//  WebsocketTestAppUITests
//
//  Created by hayden on 2022/6/20.
//

import XCTest
@testable import WebsocketTestApp


class WebsocketTestAppUITests: XCTestCase {

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        let app = XCUIApplication()
        app.launch()
    }

    func testUIElementsVisible() {
        let app = XCUIApplication()
        XCTAssertEqual(app.label, "WebsocketTestApp")
    }

}
