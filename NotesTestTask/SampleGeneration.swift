//
//  SampleGeneration.swift
//  NotesTestTask
//
//  Created by Bogdan Koshyrets on 9/21/17.
//  Copyright © 2017 Bohdan Koshyrets. All rights reserved.
//

import Foundation

struct SampleGeneration {
    static func generate() -> [Note] {
        
        var notes: [Note] = []
        
        let titles = ["Shopping list", "Random thoughts", "Movies to watch"]
        let contents = ["Buy milk, cereal, 2 lightbulbs, chocolates!", "Be or not to be, that's the real question!", "Dark Knight, La La Land (or maybe not), Dunkirk, Dark Knight Rises."]
        for index in 0 ..< 3 {
            let note = Note()
            note.title = titles[index]
            note.contents = contents[index]
            note.key = UUID().uuidString
            notes.append(note)
        }
        return notes
    }
}
