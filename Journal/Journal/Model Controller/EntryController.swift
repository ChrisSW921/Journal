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
        saveToPersistentStorage()
    }
    
    func delete(entry: Entry) {
        guard let index = entries.firstIndex(of: entry) else { return }
        entries.remove(at: index)
        saveToPersistentStorage()
    }
    
    
    private func fileURL() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectoryURL = urls[0].appendingPathComponent("Journal.json")
        return documentsDirectoryURL
    }
    
    func saveToPersistentStorage(){
        do {
            let data = try JSONEncoder().encode(EntryController.shared.entries)
            try data.write(to: fileURL())
        }catch{
            print("Error saving items \(error.localizedDescription)")
        }
    }
    
    func loadFromPersistentStorage() {
        do {
            let decodedData = try Data(contentsOf: fileURL())
            entries = try JSONDecoder().decode([Entry].self, from: decodedData)
        }catch {
            print("Error loading items \(error.localizedDescription)")
        }
    }
    
}
