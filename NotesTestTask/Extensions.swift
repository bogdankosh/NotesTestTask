//
//  Extensions.swift
//  NotesTestTask
//
//  Created by Bogdan Koshyrets on 9/21/17.
//  Copyright © 2017 Bohdan Koshyrets. All rights reserved.
//

import UIKit

extension UITableViewCell {
    class var identifier: String {
        return String(describing: self)
    }
    
    class var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}

extension UIViewController {
    func presentAlert() {
        let yesButton = UIAlertAction(title: "Delete", style: .destructive, handler: nil)
        let noButton = UIAlertAction(title: "Cancel", style: .cancel)
        let alert = UIAlertController(title: "Delete note", message: "Do you really want to delete a note?", preferredStyle: .alert)
        alert.addAction(yesButton)
        alert.addAction(noButton)
        present(alert, animated: true, completion: nil)
    }
}
