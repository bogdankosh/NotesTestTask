//
//  DateHelperTests.swift
//  NotesTestTask
//
//  Created by Bogdan Koshyrets on 1/26/18.
//  Copyright © 2018 Bohdan Koshyrets. All rights reserved.
//

import XCTest

class DateHelperTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testThatItModifiesDayCorrectly() {
        
        let referenceDateComponents = DateComponents(year: 2018,
                                           month: 01,
                                           day: 30,
                                           hour: 12,
                                           minute: 00,
                                           second: 00)
        let _ = Calendar(identifier: .gregorian).date(from: referenceDateComponents)
        
        var dayComponent = DateComponents()
        dayComponent.day = 1
        
        
    }
    
}
