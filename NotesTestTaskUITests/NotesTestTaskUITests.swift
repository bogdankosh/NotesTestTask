//
//  NotesTestTaskUITests.swift
//  NotesTestTaskUITests
//
//  Created by Bogdan Koshyrets on 1/26/18.
//  Copyright © 2018 Bohdan Koshyrets. All rights reserved.
//

import XCTest

class NotesTestTaskUITests: BaseTest {
    
    let mainScreen = MainScreen()
    let noteViewScreen = NoteViewScreen()
    
    func testThatItShowCreatedNote() {
        
        let sampleTitleText:    String = "Yazzzz " + Date().dateTimeString()
        let sampleContentsText: String = "My boy"

        let tablesCountBeforeAdding = mainScreen.tablesCount
        mainScreen.tapNewNoteButton()
        
        noteViewScreen.fillSampleTextToFields(titleText: sampleTitleText, contentsText: sampleContentsText)
        noteViewScreen.pressBackButton()
        
        let cell = mainScreen.tables.cells.element(boundBy: 0)
        ()
        XCTAssertEqual((tablesCountBeforeAdding + UInt(1)), mainScreen.tablesCount, "Hey")
    }
    
    func testThatItDeletesNote() {
        
        self.addNewSampleNote()

//        let createdNoteCell = app.tables.cells.element(boundBy: 0)
//        XCTAssertEqual(createdNoteCell.label, sampleContentsText)

        self.deleteNote()
    }
    
    func testThatItCreatesEmptyNotes() {
        var cell: XCUIElement {
            return app.tables.cells.element(boundBy: 0).staticTexts["Note has no title"]
        }
        
        // Given
        self.deleteAllNotes()
        XCTAssertFalse(cell.exists)
        
        // When
        mainScreen.tapNewNoteButton()
        noteViewScreen.enterTextToElement(.title, text: "a")
        app/*@START_MENU_TOKEN@*/.keys["delete"]/*[[".keyboards",".keys[\"Видалити\"]",".keys[\"delete\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        noteViewScreen.pressBackButton()
        
        // Then
        XCTAssertTrue(cell.exists)
        ()
    }
    
    func testThatItDeletesAllNotes() {
        
        // Given
            self.addNewSampleNote(quantity: 3)
        
        var tableCount = app.tables.cells.count
        
        // When
        while app.tables.cells.count > 0 {
            mainScreen.tapOnCell(boundBy: 0)
            noteViewScreen.deleteNote()
            XCTAssertEqual(tableCount, app.tables.cells.count + UInt(1))
            tableCount = app.tables.cells.count
        }
        
        // Then
        XCTAssertEqual(app.tables.cells.count, 0)
    }
    
    func testThatItCountsNotesCorrectly() {
        
        var notesNavBarCount: UInt {
            let onlyNumbersRegex = "(?:prefix)?([0-9]+)"
            let label = app.navigationBars.otherElements.matching(NSPredicate(format: "label CONTAINS 'Notes ('")).element(boundBy: 0).label
            let numberChars = label.matchesForRegexInText(regex: onlyNumbersRegex).first!
            return UInt(numberChars)!
        }
        
        var notesCount: UInt {
            return app.tables.cells.count
        }
        ()
        XCTAssertEqual(notesCount, notesNavBarCount)
        
        self.addNewSampleNote(quantity: 3)
        
        ()
        XCTAssertEqual(notesCount, notesNavBarCount)
    }
    
    private func addNewSampleNote(quantity: UInt = 1) {
        for _ in 0 ..< quantity {
            self.mainScreen.tapNewNoteButton()
            self.noteViewScreen.fillSampleTextToFields()
            self.noteViewScreen.pressBackButton()
        }
    }
    
    private func deleteNote(boundBy: UInt = 0) {
        mainScreen.tapOnCell(boundBy: 0)
        noteViewScreen.deleteNote()
    }
    
    private func deleteAllNotes() {
        while app.tables.cells.count > 0 {
            mainScreen.tapOnCell(boundBy: 0)
            noteViewScreen.deleteNote()
        }
    }
    
    func testTest() {
        XCUIDevice.shared().orientation = .portrait

        let app = XCUIApplication()
        app.navigationBars["Notes"].buttons["Compose"].tap()
        XCUIDevice.shared().orientation = .faceUp
        XCUIDevice.shared().orientation = .portrait
        app.textFields["Title"].tap()
        
        app.tables.children(matching: .cell).element(boundBy: 0).staticTexts["Yes, I'm really sorry, but I don't need you no more"].tap()
        app.navigationBars["Notes"].buttons["Delete"].tap()
        app.sheets["Delete note"].buttons["Delete"].tap()
        
        XCUIApplication().navigationBars["Notes (2)"].otherElements["Notes (2)"].tap()
        XCUIDevice.shared().orientation = .faceUp
        
        
        app.textFields["Title"].typeText("к")
        app/*@START_MENU_TOKEN@*/.keys["delete"]/*[[".keyboards",".keys[\"Видалити\"]",".keys[\"delete\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
    }
}
