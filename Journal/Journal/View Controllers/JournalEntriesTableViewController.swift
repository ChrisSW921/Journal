//
//  JournalEntriesTableViewController.swift
//  Journal
//
//  Created by Chris Withers on 1/11/21.
//

import UIKit

class JournalEntriesTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        EntryController.shared.loadFromPersistentStorage()
    }

    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EntryController.shared.entries.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "journalEntry", for: indexPath)
        cell.textLabel?.text = EntryController.shared.entries[indexPath.row].title
        
        //format the date
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        cell.detailTextLabel?.text = formatter.string(from: EntryController.shared.entries[indexPath.row].timeStamp)

        return cell
    }
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let entryToDelete = EntryController.shared.entries[indexPath.row]
            EntryController.shared.delete(entry: entryToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Segue code
        if segue.identifier == "seeEntry"{
            if let indexPath = tableView.indexPathForSelectedRow {
                if let detailViewController = segue.destination as? DetailViewController {
                    let selectedEntry = EntryController.shared.entries[indexPath.row]
                    detailViewController.entry = selectedEntry
                }
            }
        }
    }
    

}

