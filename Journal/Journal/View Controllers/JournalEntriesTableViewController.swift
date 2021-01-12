//
//  JournalEntriesTableViewController.swift
//  Journal
//
//  Created by Chris Withers on 1/11/21.
//

import UIKit

class JournalEntriesTableViewController: UITableViewController {
    
    var journal: Journal?

    override func viewDidLoad() {
        super.viewDidLoad()
        JournalController.shared.loadFromPersistentStorage()
    }

    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return journal?.entries.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "journalEntry", for: indexPath)
        let currentJournal = journal ?? Journal(title: "Empty Journal")
        cell.textLabel?.text = currentJournal.title
        
        //format the date
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        cell.detailTextLabel?.text = formatter.string(from: currentJournal.entries[indexPath.row].timeStamp)

        return cell
    }
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let entryToDelete = journal?.entries[indexPath.row] ?? Entry(title: "", body: "") //Makes me provide default
            EntryController.delete(entry: entryToDelete, journal: journal!) //It makes me unwrap
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Segue code
        if segue.identifier == "seeEntry"{
            if let indexPath = tableView.indexPathForSelectedRow {
                if let detailViewController = segue.destination as? DetailViewController {
                    guard let selectedJournal = journal else {return}
                    let selectedEntry = selectedJournal.entries[indexPath.row]
                    detailViewController.entry = selectedEntry
                    detailViewController.journal = journal
                    
                }
            }
        }else{
            if let detailViewController = segue.destination as? DetailViewController {
                guard let selectedJournal = journal else {return}
                detailViewController.journal = journal
            }
        }
    }
    

}

