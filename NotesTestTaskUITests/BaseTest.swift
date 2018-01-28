//
//  BaseTest.swift
//  NotesTestTask
//
//  Created by Bogdan Koshyrets on 1/26/18.
//  Copyright © 2018 Bohdan Koshyrets. All rights reserved.
//

import XCTest

class BaseTest: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app.launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
}
