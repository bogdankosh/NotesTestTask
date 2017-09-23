//
//  NoteViewController.swift
//  NotesTestTask
//
//  Created by Bogdan Koshyrets on 9/21/17.
//  Copyright © 2017 Bohdan Koshyrets. All rights reserved.
//

import UIKit
import CoreData

class NoteViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {
    
    var context: NSManagedObjectContext!
    var uuid: String?
    var currentNote: Note?
    
    // Boolean to keep track if note changed and if so - save the note.
    var hasChanged: Bool = false
    
    @IBOutlet weak var titleLabel: UITextField!
    
    @IBOutlet weak var contentsTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Dismiss the keyboard by sliding finger down
        contentsTextView.keyboardDismissMode = .interactive
        
        setupUI()
        setupContent()
        
        titleLabel.delegate = self
        contentsTextView.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if currentNote != nil {
            let deleteButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteCurrentNote))
            navigationItem.rightBarButtonItem = deleteButton
        }
    }

    func setupUI() {
        // Sets up a text inset for a text view.
        contentsTextView.textContainerInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }

    func setupContent()
    {
        // Check if we pass the reference to an existing note or creating a new one
        if let uuid = uuid {
            let request = NSFetchRequest<Note>(entityName: "Note")
            request.predicate = NSPredicate(format: "key == %@", uuid)
            
            do {
                let notes = try context.fetch(request)
                currentNote = notes.first
                
                titleLabel.text = currentNote?.title
                contentsTextView.text = currentNote?.contents
            } catch {
                print(error)
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if hasChanged {
            if let currentNote = currentNote {
                currentNote.title = titleLabel.text
                currentNote.contents = contentsTextView.text
                
                currentNote.dateModified = NSDate()
                
                saveContext()
            } else {
                let note = NSEntityDescription.insertNewObject(forEntityName: "Note", into: context) as! Note
                note.title = titleLabel.text
                note.contents = contentsTextView.text
                
                note.dateModified = NSDate()
                note.key = UUID().uuidString
                saveContext()
            }
        }
    }
    
    func deleteCurrentNote() {
        let handler: (UIAlertAction) -> Void = { _ in
            if let note = self.currentNote {
                self.context.delete(note)
                self.hasChanged = false
                self.saveContext()
                self.navigationController?.popViewController(animated: true)
            }
        }
        
        presentAlert(title: "Delete note", message: "Do you really want to delete the note?", yesHandler: handler)
    }
    
    func saveContext() {
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    
    // MARK: - UITextViewDelegate methods
    func textViewDidChange(_ textView: UITextView) {
        hasChanged = true
    }
    
    
    // MARK: - UITextFieldDelegate methods
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        hasChanged = true
        return true
    }

}


