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
    func presentAlert(title: String, message: String, yesHandler: @escaping (UIAlertAction) -> Void) {
        let yesButton = UIAlertAction(title: "Delete", style: .destructive, handler: yesHandler)
        let noButton = UIAlertAction(title: "Cancel", style: .cancel)
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(yesButton)
        alert.addAction(noButton)
        present(alert, animated: true, completion: nil)
    }
}
