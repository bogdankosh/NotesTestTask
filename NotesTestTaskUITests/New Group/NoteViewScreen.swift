//
//  NoteViewScreen.swift
//  NotesTestTaskUITests
//
//  Created by Bogdan Koshyrets on 1/26/18.
//  Copyright © 2018 Bohdan Koshyrets. All rights reserved.
//

import XCTest


enum NoteScreenTextElement {
    case title
    case contents
}


class NoteViewScreen: BaseScreen {
    
    private let titleTextField = app.textFields["Title"]
    private let contentsTextView = app.textViews["Note text view"]
    
    
    
    override init() {
        super.init()
        
        //wait()
    }
    
    func pressBackButton() {
        let backButton = BaseScreen.app.navigationBars.buttons["Notes"]
        backButton.tap()
    }
    
    func deleteNote() {
        let deleteButton = BaseScreen.app.navigationBars.buttons["Delete"]
        deleteButton.tap()
        getDeleteConfirmationButton().tap()
    }
    
    func fillSampleTextToFields(titleText: String = "Sample title " + Date().dateTimeString(),
                                contentsText: String = "Sample contents " + Date().dateTimeString()) {
        enterTextToElement(.title, text: titleText)
        enterTextToElement(.contents, text: contentsText)
    }
    
    func enterTextToElement(_ element: NoteScreenTextElement, text: String) {
        let textElement = getElement(element)
        textElement.tap()
        textElement.typeText(text)
    }
    
    private func getDeleteConfirmationButton() -> XCUIElement {
        let deleteAlertQuery = BaseScreen.app.alerts["Delete note"].buttons["Delete Note"]
        let deleteSheetQuery = BaseScreen.app.sheets["Delete note"].buttons["Delete Note"]
        
        if deleteAlertQuery.exists { return deleteAlertQuery }
//         deleteSheetQuery.exists {
            return deleteSheetQuery
    }
        
    private func getElement(_ element: NoteScreenTextElement) -> XCUIElement {
        let textElement: XCUIElement
        switch element {
            case .title:    textElement = titleTextField
            case .contents: textElement = contentsTextView
        }
        return textElement
    }
    
    private func wait() {
        titleTextField.waitToExist()
    }
    
    
}
