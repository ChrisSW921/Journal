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
        guard let entryTitle = titleTextField.text, !entryTitle.isEmpty,
              let bodyText = bodyTextView.text, !bodyText.isEmpty,
              let selectedJournal = journal else {print("NO!")
            return}
        EntryController.createEntryWith(title: entryTitle, body: bodyText, journal: selectedJournal)
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
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
