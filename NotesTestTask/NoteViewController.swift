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
    
    // var note: Note?
    var uuid: String?
    var context: NSManagedObjectContext!
    var currentNote: Note?
    
    // Boolean to keep track if note changed.
    var hasChanged: Bool = false
    
    @IBOutlet weak var titleLabel: UITextField!
    
    @IBOutlet weak var contentsTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
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
        } else {
            // TODO: Create a path where we create a new note.
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
        
        // TODO: Encapsulate alert into extension
        let yesButton = UIAlertAction(title: "Delete", style: .destructive) { _ in
            if let note = self.currentNote {
                self.context.delete(note)
                self.hasChanged = false
                self.saveContext()
                self.navigationController?.popViewController(animated: true)
            }

        }
        let noButton = UIAlertAction(title: "Cancel", style: .cancel)
        let alert = UIAlertController(title: "Delete note", message: "Do you really want to delete a note?", preferredStyle: .alert)
        alert.addAction(yesButton)
        alert.addAction(noButton)
        present(alert, animated: true, completion: nil)
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


