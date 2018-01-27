//
//  MainScreen.swift
//  NotesTestTaskUITests
//
//  Created by Bogdan Koshyrets on 1/26/18.
//  Copyright © 2018 Bohdan Koshyrets. All rights reserved.
//

import XCTest

class MainScreen: BaseScreen {
    
    private let button = app.navigationBars["Notes"].buttons["Compose"]
    
    override init() {
        super.init()
        
//        visible()
    }
    
    var tablesCount: UInt {
        return BaseScreen.app.tables.cells.count
    }
    
    func visible() {
        button.waitToExist()
    }
    
    func tapNewNoteButton() {
        button.tap()
    }
    
    func tapOnCell(boundBy index: UInt) {
        tables.cells.element(boundBy: index).tap()
    }

    
}

//protocol BaseScreenProtocol {
//    static var app: XCUIApplication { get }
//    static var tables: XCUIElementQuery { get }
//    
//}
//
//extension BaseScreenProtocol {
//    static var app: XCUIApplication {
//        return XCUIApplication()
//    }
//    
//    static var tables: XCUIElementQuery {
//        return XCUIApplication().tables
//    }
//}

