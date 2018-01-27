//
//  UIXCElementExtension.swift
//  NotesTestTaskUITests
//
//  Created by Bogdan Koshyrets on 1/26/18.
//  Copyright © 2018 Bohdan Koshyrets. All rights reserved.
//

import XCTest

let kDefaultTimeoutInSeconds = 10.0

extension XCUIElement {
    @discardableResult func waitToExist() -> XCUIElement {
        
        let doesElementExist: () -> Bool = {
            return self.exists
        }
        waitFor(doesElementExist, failureMessage: "Timed out waiting for element to exist")
        return self
    }
    
    private func waitFor(_ expression: () -> Bool, failureMessage: String) {
        let startTime = Date.timeIntervalSinceReferenceDate
        
        while !expression() {
            if Date.timeIntervalSinceReferenceDate - startTime < kDefaultTimeoutInSeconds {
                NSException(name: NSExceptionName(rawValue: "Timeout"), reason: failureMessage, userInfo: nil).raise()
            }
            CFRunLoopRunInMode(CFRunLoopMode.defaultMode, 0.1, true)
            
        }
    }
}
