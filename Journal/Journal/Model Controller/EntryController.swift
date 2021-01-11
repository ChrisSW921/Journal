//
//  EntryController.swift
//  Journal
//
//  Created by Chris Withers on 1/11/21.
//

import Foundation

class EntryController {
    
    static let shared = EntryController()
    
    var entries: [Entry] = []
    
    func createEntryWith(title: String, body: String) {
        let newEntry = Entry(title: title, body: body)
        entries.append(newEntry)
    }
    
    func delete(entry: Entry) {
        guard let index = entries.firstIndex(of: entry) else { return }
        entries.remove(at: index)
    }
    
    
}
