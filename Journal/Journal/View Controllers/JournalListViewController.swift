//
//  JournalListViewController.swift
//  Journal
//
//  Created by Chris Withers on 1/12/21.
//

import UIKit

class JournalListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    
    //MARK: - Outlets
    
    @IBOutlet weak var journalTitleTextField: UITextField!
    
    @IBOutlet weak var journalTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        JournalController.shared.loadFromPersistentStorage()
        journalTableView.delegate = self
        journalTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        journalTableView.reloadData()
    }
    
    //MARK: - Actions

    @IBAction func addJournalButtonTapped(_ sender: UIButton) {
        guard let newJournalTitle = journalTitleTextField.text, !newJournalTitle.isEmpty else {return}
        JournalController.shared.addJournal(title: newJournalTitle)
        journalTableView.reloadData()
        journalTitleTextField.text = ""
    }
    
    
    //MARK: - Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return JournalController.shared.journals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "journalCell", for: indexPath)
        
        cell.textLabel?.text = JournalController.shared.journals[indexPath.row].title
        cell.detailTextLabel?.text = "\(JournalController.shared.journals[indexPath.row].entries.count) entries"
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let journalToDelete = JournalController.shared.journals[indexPath.row]
            JournalController.shared.deleteJournal(journal: journalToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToJournal" {
            guard let indexPath = journalTableView.indexPathForSelectedRow else {return}
            let selectedJournal = JournalController.shared.journals[indexPath.row]
            let destinationVC = segue.destination as? JournalEntriesTableViewController
            destinationVC?.journal = selectedJournal
        }
    }
    

}
