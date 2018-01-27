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
        
        let sampleTitleText:    String = "Yazzzz"
        let sampleContentsText: String = "My boy"

        let tablesCountBeforeAdding = mainScreen.tablesCount
        mainScreen.tapNewNoteButton()
        
        noteViewScreen.fillSampleTextToFields(titleText: sampleTitleText, contentsText: sampleContentsText)
        noteViewScreen.pressBackButton()
        
        XCTAssertEqual((tablesCountBeforeAdding + UInt(1)), mainScreen.tablesCount, "Hey")
    }
    
    func testThatItDeletesNote() {
        let dateNow = Date()
        let timeStamp = dateNow.dateString() + " " + dateNow.timeString()
        let sampleTitleText:    String = "The note I'm about to delete" + timeStamp
        let sampleContentsText: String = "Yes, I'm really sorry, but I don't need you no more"
        
        mainScreen.tapNewNoteButton()
        
        noteViewScreen.enterTextToElement(.title, text: sampleTitleText)
        noteViewScreen.enterTextToElement(.contents, text: sampleContentsText)
        noteViewScreen.pressBackButton()
        
//        let createdNoteCell = app.tables.cells.element(boundBy: 0)
//        XCTAssertEqual(createdNoteCell.label, sampleContentsText)
        
        mainScreen.tapOnCell(boundBy: 0)
        noteViewScreen.deleteNote()
    }
    
    func testThatItDeletesAllNotes() {
        
        // Given
        for _ in 0 ..< 3 {
            mainScreen.tapNewNoteButton()
            noteViewScreen.fillSampleTextToFields()
            noteViewScreen.pressBackButton()
        }
        
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
    
    func testTest() {
        XCUIDevice.shared().orientation = .portrait

        let app = XCUIApplication()
        app.navigationBars["Notes"].buttons["Compose"].tap()
        XCUIDevice.shared().orientation = .faceUp
        XCUIDevice.shared().orientation = .portrait
        app.textFields["Title"].tap()
    }
}
