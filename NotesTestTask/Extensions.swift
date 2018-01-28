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
        let yesButton = UIAlertAction(title: "Delete Note", style: .destructive, handler: yesHandler)
        let noButton = UIAlertAction(title: "Cancel", style: .cancel)
        let alert = UIAlertController(title: "Delete note", message: message, preferredStyle: .actionSheet)
        alert.addAction(yesButton)
        alert.addAction(noButton)
        present(alert, animated: true, completion: nil)
    }
}

extension String {
    func matchesForRegexInText(regex: String!) -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: regex, options: [])
            let nsString = self as NSString
            
            let results = regex.matches(in: self,
                                        options: [],
                                        range: NSMakeRange(0, nsString.length))
            return results.map { nsString.substring(with: $0.range)}
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }}
}
