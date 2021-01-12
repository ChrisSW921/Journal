//
//  DetailViewController.swift
//  Journal
//
//  Created by Chris Withers on 1/11/21.
//

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    
    var entry: Entry?
    var journal: Journal?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        titleTextField.resignFirstResponder()
    }
    
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        if let currentEntry = entry {
            guard let entryTitle = titleTextField.text, !entryTitle.isEmpty,
                  let bodyText = bodyTextView.text, !bodyText.isEmpty else {return}
            EntryController.update(title: entryTitle, body: bodyText, entry: currentEntry)
        }else{
            guard let entryTitle = titleTextField.text, !entryTitle.isEmpty,
                  let bodyText = bodyTextView.text, !bodyText.isEmpty,
                  let selectedJournal = journal else {print("NO!")
                return}
            EntryController.createEntryWith(title: entryTitle, body: bodyText, journal: selectedJournal)
        }
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clearAllButtonPressed(_ sender: UIButton) {
        titleTextField.text = ""
        bodyTextView.text = ""
    }
    
    func updateViews(){
        
        guard let sentEntry = entry else {return}
        titleTextField.text = sentEntry.title
        bodyTextView.text = sentEntry.body

    }

}
