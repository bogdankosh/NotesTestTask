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
    var uuid: String!
    var context: NSManagedObjectContext!
    
    @IBOutlet weak var titleLabel: UITextField!
    
    @IBOutlet weak var contentsTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentsTextView.keyboardDismissMode = .interactive
        
        setupUI()
        setupContent()
        
    }

    func setupUI() {
        contentsTextView.textContainerInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    func setupContent() {
        let request = NSFetchRequest<Note>(entityName: "Note")
        request.predicate = NSPredicate(format: "key == %@", uuid)
        
        do {
            let notes = try context.fetch(request)
            let note = notes.first
            
            titleLabel.text = note?.title
            contentsTextView.text = note?.contents
        } catch {
            print(error)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        // TODO: Save a note here.
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
