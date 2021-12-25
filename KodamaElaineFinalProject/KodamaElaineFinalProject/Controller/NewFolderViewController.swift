//
//  NewSetViewController.swift
//  KodamaElaineFinalProject
//
//  Created by Elaine Kodama on 4/25/21.
//

import UIKit
import Firebase

class NewFolderViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var comboBox: UITextField! //picker view
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var titleTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleTextField.text = ""
        // Do any additional setup after loading the view.
    }
    
    @IBAction func userDidTappedSave(_ sender: UIBarButtonItem) {
        if titleTextField.text != ""{
            let title = titleTextField.text ?? ""
            FirestoreModel.shared.addFolder(folderTitle: title)
      
            performSegue(withIdentifier: "newFolder", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let flashcardSetViewController = segue.destination as? FlashcardSetViewController{
            let title = titleTextField.text //get a dictionary for a single document
            flashcardSetViewController.folderTitle = title ?? "" //pass over the folder title to flashcards view
        }
    }
       
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        titleTextField.resignFirstResponder()
    }
    
    //don't allow done if there is no text
    @IBAction func enableDoneButton(_ sender: UITextField) {
        if titleTextField.hasText { //if there is a title
            saveButton.isEnabled = true //done button can be enabled
        }
        else{ //title does not have text
            saveButton.isEnabled = false //done button is disabled
        }
    }
}
