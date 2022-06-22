//
//  NewSetViewController.swift
//  KodamaElaineFinalProject
//
//  Created by Elaine Kodama on 5/30/21.
//

import UIKit

class NewSetViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var comboBox: UITextField! //picker view
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var publicSwitch: UISwitch!
    @IBOutlet weak var displayNameSwitch: UISwitch!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var displayNameLabel: UITextField!
    //create segue
    var folderTitle : String!
    var template : String!
    
    var pickerItems = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleTextField.text = ""
        publicSwitch.isOn = false
        showDisplayNameSwitch()
        // Do any additional setup after loading the view.
    }

    
    //Hide the display name attribute if they do not want their set to be public
    func showDisplayNameSwitch(){
        if publicSwitch.isOn{ //when they do want to be public
            displayNameLabel.isHidden = false
            displayNameSwitch.isHidden = false //hide display name
        }
        else{ //they don't want to be public
            displayNameLabel.isHidden = true
            displayNameSwitch.isHidden = true //hide display name
        }
    }
    
    //store set in firebase
    @IBAction func userDidTappedSave(_ sender: UIBarButtonItem) {
        print("Saved")
        if titleTextField.text != ""{
            let title = titleTextField.text ?? ""
            //TODO: blank string since no folder title
            folderTitle = ""
            FirestoreModel.shared.addFlashcardSet(setTitle: title)
            
            if publicSwitch.isOn{
                addToPublic()
            }
            performSegue(withIdentifier: "newSet", sender: self)
        }
        
        func addToPublic(){
            if displayNameSwitch.isOn{
                //include name
            }
            else{
                //dont include name
            }
        }

    }
    
    //view the individual flashcards for set
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let flashcardsViewController = segue.destination as? FlashcardsViewController{
            // Pass the selected object to the new view controller
            flashcardsViewController.folderTitle = title //image
            flashcardsViewController.setTitle = titleTextField.text
        }
    }
    
    //resign text field
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
