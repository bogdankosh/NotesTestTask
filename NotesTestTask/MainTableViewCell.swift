//
//  MainTableViewCell.swift
//  NotesTestTask
//
//  Created by Bogdan Koshyrets on 9/21/17.
//  Copyright © 2017 Bohdan Koshyrets. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentsLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configureCell(with note: Note) {
        let dayModified = DateHelper.dayModified(note.dateModified! as Date)
        
        self.titleLabel.text =      note.title!.isEmpty ? "(No title)" : note.title
        self.contentsLabel.text =   note.contents!.isEmpty ? "(No contents)" : note.contents
        self.dateLabel.text =       dayModified
        
        self.titleLabel.accessibilityLabel = note.title!.isEmpty ? "Note has no title" : "Title: " + note.title!
        self.dateLabel.accessibilityLabel = "Created " + dayModified
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
