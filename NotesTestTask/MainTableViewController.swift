//
//  MainTableViewController.swift
//  NotesTestTask
//
//  Created by Bogdan Koshyrets on 9/21/17.
//  Copyright © 2017 Bohdan Koshyrets. All rights reserved.
//

import UIKit
import CoreData

class MainTableViewController: UITableViewController {
    
    let segueShowNote =     "showNote"
    let segueNewNote =      "newNote"
    
    var notesStore: [Note] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
//        addSampleData()
        initializeDataFromCoreData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        initializeDataFromCoreData()
    }
    
    func setupUI() {
        title = "Notes"
        
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
    }
    
    func initializeData() {
        notesStore = SampleGeneration.generate()
        
        sortStore()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
    }
    
    func initializeDataFromCoreData() {
        do {
            notesStore = try context.fetch(Note.fetchRequest())
            tableView.reloadData()
        } catch {
            print(error)
        }
        
        sortStore()
        
    }
    
    func addSampleData() {
        
        for index in 0 ..< 10 {
            let note = NSEntityDescription.insertNewObject(forEntityName: "Note", into: context) as! Note
            note.title = "Note #\(index)"
            note.contents = "Hey bitch"
            note.key = UUID().uuidString
            note.dateModified = NSDate()
        }
        
    }
    
    func sortStore() {
        // Sort note elements by date modified (newest first)
        notesStore = notesStore.sorted { $0.dateModified!.timeIntervalSinceReferenceDate > $1.dateModified!.timeIntervalSinceReferenceDate }

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notesStore.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier, for: indexPath) as? MainTableViewCell else { fatalError("Could not dequeue a cell as MainTableViewCell") }
        
        cell.titleLabel.text =      notesStore[indexPath.row].title
        cell.contentsLabel.text =   notesStore[indexPath.row].contents
        cell.dateLabel.text =       notesStore[indexPath.row].dateModified?.description
        
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */
    
    

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueShowNote {
            let destinationViewController = segue.destination as? NoteViewController
            // destinationViewController?.note = notesStore[tableView.indexPathForSelectedRow!.row]
            destinationViewController?.uuid = notesStore[tableView.indexPathForSelectedRow!.row].key
            
            destinationViewController?.context = context
        }
        
        if segue.identifier == segueNewNote {
            let destinationViewController = segue.destination as? NoteViewController
            destinationViewController?.context = context
        }
    }

}
