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
        for index in 0..<1000 {
            let note = Note()
            note.title = "Note #\(index)"
            note.contents = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed aliquam pellentesque commodo. Integer eget nunc dignissim, convallis neque at, tincidunt orci. Quisque efficitur tincidunt lacus id scelerisque. Sed fermentum erat aliquet commodo auctor. Sed vel posuere neque. Mauris quam turpis, faucibus et vulputate nec, rutrum ut odio. Maecenas nec risus dignissim, scelerisque purus ac, venenatis mauris. Morbi blandit lacus nec erat pretium, id laoreet justo posuere. Sed viverra et ante ac elementum"
            notes.append(note)
        }
    return notes
    }
}
