//
//  NoteStoreHelper.swift
//  NotesTestTask
//
//  Created by Bogdan Koshyrets on 1/26/18.
//  Copyright © 2018 Bohdan Koshyrets. All rights reserved.
//

import Foundation

enum NoteSortDescriptor {
    case newestFirst
    case oldestFirst
}

class NoteStoreHelper {
    func sort(store: [Note], by sortDescriptor: NoteSortDescriptor = .newestFirst) -> [Note] {
        // Sort note elements by date modified
        switch sortDescriptor {
        case .newestFirst:
            return store.sorted { $0.dateModified!.timeIntervalSinceReferenceDate > $1.dateModified!.timeIntervalSinceReferenceDate }
        case .oldestFirst:
            return store.sorted { $0.dateModified!.timeIntervalSinceReferenceDate < $1.dateModified!.timeIntervalSinceReferenceDate }

        }
    }
}
