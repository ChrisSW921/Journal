//
//  EntryController.swift
//  Journal
//
//  Created by Chris Withers on 1/11/21.
//

import Foundation

class EntryController {
    
    static func createEntryWith(title: String, body: String, journal: Journal) {
        let newEntry = Entry(title: title, body: body)
        JournalController.shared.addEntryTo(journal: journal, entry: newEntry)
    }
    
    static func delete(entry: Entry, journal: Journal) {
        guard let index = journal.entries.firstIndex(of: entry) else { return }
        JournalController.shared.removeEntryFrom(journal: journal, entry: journal.entries[index])
    }
    
    static func update(title: String, body: String, entry: Entry) {
        entry.title = title
        entry.body = body
        JournalController.shared.saveToPersistentStorage()
    }
    
}
