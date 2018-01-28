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
        
        let sampleText: String = "Note to check: " + Date().dateTimeString()

        let cellCountBeforeAdding = self.mainScreen.cellsCount
        
        self.mainScreen.tapNewNoteButton()
        self.noteViewScreen.fillSampleTextToFields(titleText: sampleText, contentsText: sampleText)
        self.noteViewScreen.pressBackButton()
        
        XCTAssertEqual((cellCountBeforeAdding + UInt(1)), self.mainScreen.cellsCount)
    }
    
    func testThatItDeletesNote() {
        let text: String = "Note I'm about to delete. " + Date().dateTimeString()
        
        XCTAssertFalse(findElementCellContaining(text: text).exists)

        self.mainScreen.tapNewNoteButton()
        self.noteViewScreen.enterTextToElement(.title, text: text)
        self.noteViewScreen.pressBackButton()
        ()
        XCTAssertTrue(findElementCellContaining(text: text).exists)

        self.deleteNote(boundBy: 0)
        
        XCTAssertFalse(findElementCell(withText: "Title: \(text)").exists)
        XCTAssertFalse(findElementCellContaining(text: text).exists)
    }
    
    func testThatItCreatesNotesWithNoTitle() {
        let accessibilityLabel = "Note has no title"
        
        var cell: XCUIElement {
            return app.tables.cells.element(boundBy: 0).staticTexts[accessibilityLabel]
        }
        
        // Given
        XCTAssertFalse(cell.exists)
        
        // When
        self.mainScreen.tapNewNoteButton()
        self.noteViewScreen.enterTextToElement(.contents, text: "a")
        self.app.keys["delete"].tap()
        self.noteViewScreen.pressBackButton()
        
        // Then
        XCTAssertTrue(cell.exists)
        ()
    }
    
    func testThatItDoesntCreateNoteWhenNoTextWasEntered() {
        let cellsCountBefore = mainScreen.cellsCount
        
        self.mainScreen.tapNewNoteButton()
        self.noteViewScreen.pressBackButton()
        
        let cellsCountAfter = mainScreen.cellsCount
        XCTAssertEqual(cellsCountBefore, cellsCountAfter)
    }
    
    func testThatItDeletesAllNotes() {
        
        // Given
            self.addNewSampleNote(quantity: 3)
        
        var tableCount = app.tables.cells.count
        
        // When
        while app.tables.cells.count > 0 {
            self.mainScreen.tapOnCell(boundBy: 0)
            self.noteViewScreen.deleteNote()
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
    
    func testThatItCreatesLargeNotes() {
        
    }
    
    func testThatItMovesNotesToBeginningWhenBeingEdited() {
        let text = Date().dateTimeString()
        let count = mainScreen.cellsCount
        let randomCellIndex = UInt(arc4random_uniform(UInt32(count)))
        
        mainScreen.tapOnCell(boundBy: randomCellIndex)
        noteViewScreen.enterTextToElement(.title, text: text)
        noteViewScreen.pressBackButton()
        
        let cell = findElementCell(withText: text, atIndex: 0)
        ()
        XCTAssertTrue(cell.exists)
        
    }
    
    private func findElementCell(withText text: String, atIndex index: UInt = 0) -> XCUIElement {
        return app.tables.cells.element(boundBy: index).staticTexts[text]
    }
    
    private func findElementCellContaining(text: String) -> XCUIElement {
        return app.tables.cells.staticTexts.matching(NSPredicate(format: "label CONTAINS %@", text)).element
    }
    
    private func addNewSampleNote(quantity: UInt = 1) {
        for _ in 0 ..< quantity {
            self.mainScreen.tapNewNoteButton()
            self.noteViewScreen.fillSampleTextToFields()
            self.noteViewScreen.pressBackButton()
        }
    }
    
    private func deleteNote(boundBy index: UInt = 0) {
        self.mainScreen.tapOnCell(boundBy: index)
        self.noteViewScreen.deleteNote()
    }
    
    private func deleteAllNotes() {
        while app.tables.cells.count > 0 {
            self.mainScreen.tapOnCell(boundBy: 0)
            self.noteViewScreen.deleteNote()
        }
    }
    
    func UNUSED_testTest() {
        XCUIDevice.shared().orientation = .portrait

        let app = XCUIApplication()
        app.navigationBars["Notes"].buttons["Compose"].tap()
        XCUIDevice.shared().orientation = .faceUp
        XCUIDevice.shared().orientation = .portrait
        app.textFields["Title"].tap()
        
        app.tables.children(matching: .cell).element(boundBy: 0).staticTexts["Yes, I'm really sorry, but I don't need you no more"].tap()
        app.navigationBars["Notes"].buttons["Delete"].tap()
        app.sheets["Delete note"].buttons["Delete"].tap()
        
    
    }
}
