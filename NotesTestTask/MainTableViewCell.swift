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
    
    @IBOutlet weak var favoriteView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configureCell(with note: Note) {
        let dayModified = DateHelper.dayModified(note.dateModified! as Date)
        
        self.titleLabel.text =      note.title!.isEmpty ? LabelFactory.EmptyFields.noTitle : note.title
        self.contentsLabel.text =   note.contents!.isEmpty ? LabelFactory.EmptyFields.noContents : note.contents
        self.dateLabel.text =       dayModified
        
        self.titleLabel.accessibilityLabel = note.title!.isEmpty ? LabelFactory.Accessibility.noTitle : "Title: " + note.title!
        self.dateLabel.accessibilityLabel = "Created " + dayModified
        
        let appearance: CellAppearance = note.isFavorited ? .highlighted : .regular
        favoriteView.backgroundColor = appearance.boxViewColor
        self.backgroundColor = appearance.backgroundColor
        
        titleLabel.textColor = (note.title!.isEmpty ? UIColor.gray : UIColor.black)
        
        self.favoriteView.layer.cornerRadius = 2.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
