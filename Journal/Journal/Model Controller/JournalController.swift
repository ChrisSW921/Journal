//
//  JournalController.swift
//  Journal
//
//  Created by Chris Withers on 1/12/21.
//

import Foundation
class JournalController {
    
    var journals: [Journal] = []
    
    static var shared = JournalController()
    
    func addJournal(title: String){
       let newJournal = Journal(title: title)
        journals.append(newJournal)
        saveToPersistentStorage()
    }
    
    func deleteJournal(journal: Journal) {
        guard let index = journals.firstIndex(of: journal) else {return}
        journals.remove(at: index)
        saveToPersistentStorage()
    }
    
    func addEntryTo(journal: Journal, entry: Entry) {
        journal.entries.append(entry)
        saveToPersistentStorage()
    }
    
    func removeEntryFrom(journal: Journal, entry: Entry){
        guard let index = journal.entries.firstIndex(of: entry) else {return}
        journal.entries.remove(at: index)
        saveToPersistentStorage()
    }
    
    
    private func fileURL() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectoryURL = urls[0].appendingPathComponent("Journal.json")
        return documentsDirectoryURL
    }
    
    func saveToPersistentStorage(){
        do {
            let data = try JSONEncoder().encode(journals)
            try data.write(to: fileURL())
        }catch{
            print("Error saving items \(error.localizedDescription)")
        }
    }
    
    func loadFromPersistentStorage() {
        do {
            let decodedData = try Data(contentsOf: fileURL())
            journals = try JSONDecoder().decode([Journal].self, from: decodedData)
        }catch {
            print("Error loading items \(error.localizedDescription)")
        }
    }
    
    
}
