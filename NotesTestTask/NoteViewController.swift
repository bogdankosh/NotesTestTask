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
        // TODO: Save changes to an existing note here or create a new one.
        currentNote?.title = titleLabel.text
        currentNote?.contents = contentsTextView.text
        
        // TODO: Check if note has changes. then update date modified.
        currentNote?.dateModified = NSDate()
        
        saveContext()
    }
    
    func saveContext() {
        do {
            try context.save()
        } catch {
            print(error)
        }
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
