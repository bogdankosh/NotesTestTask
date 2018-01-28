//
//  NoteViewController.swift
//  NotesTestTask
//
//  Created by Bogdan Koshyrets on 9/21/17.
//  Copyright © 2017 Bohdan Koshyrets. All rights reserved.
//

import UIKit
import CoreData

class NoteViewController: UIViewController {
    
    var uuid: String?
    var currentNote: Note?
    
    // Boolean to keep track if note changed and if so - save the note.
    var hasChanged: Bool = false
    
    @IBOutlet weak var titleLabel: UITextField!
    @IBOutlet weak var contentsTextView: UITextView!
    
    var favoriteButton = UIBarButtonItem()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Dismiss the keyboard by sliding finger down
        contentsTextView.keyboardDismissMode = .interactive
        
        self.setupContent()
        
        self.titleLabel.delegate = self
        self.contentsTextView.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setupUI()
        
        if currentNote != nil {
            
            favoriteButton = UIBarButtonItem(image: (currentNote?.isFavorited)! ? #imageLiteral(resourceName: "star-filled") : #imageLiteral(resourceName: "star"), style: .plain, target: self, action: #selector(favoriteCurrentNote))
            let deleteButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteCurrentNote))
            navigationItem.rightBarButtonItems = [deleteButton, favoriteButton]
        }
    }

    func setupUI() {
        // Sets up a text inset for a text view.
        self.contentsTextView.textContainerInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        
        self.titleLabel.accessibilityLabel = "Title text field"
        self.contentsTextView.accessibilityLabel = "Note text view"
        
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = false
        }
        
        if currentNote == nil {
            self.titleLabel.becomeFirstResponder()
        }
    }

    func setupContent() {
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
                print(error.localizedDescription)
            }
        }
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // FIX: -
        
        if hasChanged {
            if let currentNote = currentNote {
                currentNote.title = titleLabel.text
                currentNote.contents = contentsTextView.text
                
                
                currentNote.dateModified = NSDate() as Date
            } else {
                let note = NSEntityDescription.insertNewObject(forEntityName: "Note", into: context) as! Note
                note.title = titleLabel.text
                note.contents = contentsTextView.text
                
                note.isFavorited = false
                note.dateModified = NSDate() as Date
                note.key = UUID().uuidString
            }
            saveContext()
        }
        hasChanged = false
    }
    
    @objc private func deleteCurrentNote() {
        let handler: (UIAlertAction) -> Void = { _ in
            if let note = self.currentNote {
                context.delete(note)
                self.hasChanged = false
                self.saveContext()
                self.navigationController?.popViewController(animated: true)
            }
        }
        
        self.presentAlert(title: "Delete note", message: "Do you really want to delete the note? This action cannot be undone.", yesHandler: handler)
    }
    
    @objc private func favoriteCurrentNote() {
        self.hasChanged = true
        if let note = currentNote {
            note.isFavorited = !note.isFavorited
            favoriteButton.image = note.isFavorited ? #imageLiteral(resourceName: "star-filled") : #imageLiteral(resourceName: "star")
            
        }
    }
    
    func saveContext() {
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}

extension NoteViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        hasChanged = true
        return true
    }
}

extension NoteViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        hasChanged = true
    }
}

