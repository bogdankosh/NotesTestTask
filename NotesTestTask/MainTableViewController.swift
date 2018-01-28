//
//  MainTableViewController.swift
//  NotesTestTask
//
//  Created by Bogdan Koshyrets on 9/21/17.
//  Copyright © 2017 Bohdan Koshyrets. All rights reserved.
//

import UIKit
import WatchConnectivity
import CoreData

class MainTableViewController: UITableViewController {
    
    let kSegueShowNote =     "showNote"
    let kSegueNewNote =      "newNote"
    
    let kNotFirstLaunchKey = "notFirstLaunch"
    
    var notesStore: [Note] = []
    let noteStoreHelper = NoteStoreHelper()
    
    var navigationTitle: String = "" {
        didSet {
            self.title = navigationTitle
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
        
        self.addSampleData()
        self.initializeDataFromCoreData()
        // transferDataToWatch()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setupUI()
        self.initializeDataFromCoreData()
    }
    
    private func setupUI() {
        self.navigationTitle = "Notes"
        
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
            self.navigationController?.navigationItem.largeTitleDisplayMode = .always
        }
        
        // TODO: Deleting notes from table view.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func initializeDataFromCoreData() {
        do {
            notesStore = try context.fetch(Note.fetchRequest())
            tableView.reloadData()
        } catch {
            print(error)
        }
        
        self.notesStore = noteStoreHelper.sort(store: notesStore, by: .newestFirst)
        self.navigationTitle = "Notes " + "(\(notesStore.count))"
    }
    
    private func addSampleData() {
        
        let defaults = UserDefaults.standard
        if defaults.bool(forKey: kNotFirstLaunchKey) {
            
        } else {
            for index in 0 ..< 3 {
                
                let titles = ["Shopping list", "Random thoughts", "Movies to watch"]
                let contents = ["Buy milk, cereal, 2 lightbulbs, chocolates!", "Be or not to be, that's the real question!", "Dark Knight, La La Land (or maybe not), Dunkirk, Dark Knight Rises."]
                
                let note = NSEntityDescription.insertNewObject(forEntityName: "Note", into: context) as! Note
                note.title = titles[index]
                note.contents = contents[index]
                note.key = UUID().uuidString
                note.dateModified = DateHelper.dateFromTodayByAdding(day: -index) as NSDate
            }
            
            defaults.set(true, forKey: kNotFirstLaunchKey)
            saveContext()
        }
    }
    
    func saveContext() {
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    
    /*
    func transferDataToWatch() {
        var array = [String?]()
        for item in notesStore {
            array.append(item.title)
        }
        var dict = [String: Any]()
        dict = ["notes": array]
        let session = WCSession.default()
        
        do {
            try session.updateApplicationContext(dict)
        } catch {
            print(error.localizedDescription)
        }
    }
    */
    


    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notesStore.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier, for: indexPath) as? MainTableViewCell else { fatalError("Could not dequeue a cell as MainTableViewCell") }
        
        cell.configureCell(with: notesStore[indexPath.row])
        return cell
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let backItem = UIBarButtonItem()
        backItem.title = "Notes"
        navigationItem.backBarButtonItem = backItem
        
        let destinationViewController = segue.destination as? NoteViewController
        switch segue.identifier! {
        case kSegueShowNote:
            destinationViewController?.uuid = notesStore[tableView.indexPathForSelectedRow!.row].key
        case kSegueNewNote: ()
        default: fatalError("Called non-existent segue")
        }
    }
}
