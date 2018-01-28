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
    
    func testThatItShowsCreatedNote() {
        let sampleText: String = "Note to check: " + Date().dateTimeString()

        let cellCountBeforeAdding = self.mainScreen.cellsCount
        
        self.mainScreen.tapNewNoteButton()
        self.noteViewScreen.fillSampleTextToFields(titleText: sampleText, contentsText: sampleText)
        self.noteViewScreen.pressBackButton()
        
        let cell = findElementCellContaining(text: sampleText)
        
        XCTAssertEqual((cellCountBeforeAdding + 1), self.mainScreen.cellsCount)
        XCTAssertTrue(cell.exists)
        
    }
    
    func testThatItDeletesNote() {
        let text: String = "Note I'm about to delete. " + Date().dateTimeString()
        
        XCTAssertFalse(findElementCellContaining(text: text).exists)

        self.mainScreen.tapNewNoteButton()
        self.noteViewScreen.enterTextToElement(.title, text: text)
        self.noteViewScreen.pressBackButton()
        
        XCTAssertTrue(findElementCellContaining(text: text).exists)

        self.deleteNote(boundBy: 0)
        
        XCTAssertFalse(findElementCellContaining(text: text).exists)
    }
    
    func testThatItCreatesNotesWithNoTitle() {
        let accessibilityLabel = LabelFactory.Accessibility.noTitle
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
    }
    
    func testThatItDoesntCreateNoteWhenNoTextWasEntered() {
        // Given
        let cellsCountBefore = mainScreen.cellsCount
        
        // When
        self.mainScreen.tapNewNoteButton()
        self.noteViewScreen.pressBackButton()
        
        // Then
        let cellsCountAfter = mainScreen.cellsCount
        XCTAssertEqual(cellsCountBefore, cellsCountAfter)
    }
    
    func testThatItDeletesAllNotes() {
        
        // Given
        self.addNewSampleNote(quantity: 3)
        
        // When
        while mainScreen.cellsCount > 0 {
            self.deleteNote(boundBy: 0)
        }
        
        // Then
        XCTAssertEqual(mainScreen.cellsCount, 0)
    }
    
    func testThatItCountsNotesCorrectly() {
        
        var notesNavBarCount: Int {
            let onlyNumbersRegex = "(?:prefix)?([0-9]+)"
            let label = app.navigationBars.otherElements.matching(NSPredicate(format: "label CONTAINS 'Notes ('")).firstMatch.label
            let numberChars = label.matchesForRegexInText(regex: onlyNumbersRegex).first!
            return Int(numberChars)!
        }
        ()
        var notesCount: Int {
            return app.tables.cells.count
        }
        XCTAssertEqual(notesCount, notesNavBarCount)
        ()
        self.addNewSampleNote(quantity: 1)
        ()
        XCTAssertEqual(notesCount, notesNavBarCount)
    }
    
    func testThatItMovesNotesToBeginningWhenBeingEdited() {
        let text = Date().dateTimeString()
        let count = mainScreen.cellsCount
        let randomCellIndex = Int(arc4random_uniform(UInt32(count)))
        
        self.mainScreen.tapOnCell(boundBy: randomCellIndex)
        self.noteViewScreen.enterTextToElement(.title, text: text)
        self.noteViewScreen.pressBackButton()
        
        let cell = findElementCellContaining(text: text, atIndex: 0)
        XCTAssertTrue(cell.exists)
        
    }
    
    private func findElementCell(withText text: String, atIndex index: Int = 0) -> XCUIElement {
        return app.tables.cells.element(boundBy: index).staticTexts[text]
    }
    
    private func findElementCellContaining(text: String) -> XCUIElement {
        return app.tables.cells.staticTexts.matching(NSPredicate(format: "label CONTAINS %@", text)).element
    }
    
    private func findElementCellContaining(text: String, atIndex index: Int = 0) -> XCUIElement {
        return app.tables.cells.element(boundBy: index).staticTexts.matching(NSPredicate(format: "label CONTAINS %@", text)).element
    }
    
    private func addNewSampleNote(quantity: UInt = 1) {
        for _ in 0 ..< quantity {
            self.mainScreen.tapNewNoteButton()
            self.noteViewScreen.fillSampleTextToFields()
            self.noteViewScreen.pressBackButton()
        }
    }
    
    private func deleteNote(boundBy index: Int = 0) {
        self.mainScreen.tapOnCell(boundBy: index)
        self.noteViewScreen.deleteNote()
    }
    
    private func deleteAllNotes() {
        while app.tables.cells.count > 0 {
            self.mainScreen.tapOnCell(boundBy: 0)
            self.noteViewScreen.deleteNote()
        }
    }
}
