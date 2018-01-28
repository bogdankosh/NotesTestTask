//
//  CellAppearance.swift
//  NotesTestTask
//
//  Created by Bogdan Koshyrets on 1/28/18.
//  Copyright © 2018 Bohdan Koshyrets. All rights reserved.
//

import UIKit

enum CellAppearance {
    case regular
    case highlighted
    
    var backgroundColor: UIColor {
        switch self {
        case .regular:  return UIColor.white
        case .highlighted: return UIColor(red: 1.0, green: 1.0, blue: 0.4, alpha: 0.2)
        }
    }
    
    var boxViewColor: UIColor {
        switch self {
        case .regular: return UIColor.lightGray
        case .highlighted: return UIColor(red: 1.0, green: 0.8, blue: 0.4, alpha: 1)
            
        }
    }
}
