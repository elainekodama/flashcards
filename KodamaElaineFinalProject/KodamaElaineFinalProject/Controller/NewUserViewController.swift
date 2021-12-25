//
//  NewUserViewController.swift
//  KodamaElaineFinalProject
//
//  Created by Elaine Kodama on 4/29/21.
//

import UIKit

class NewUserViewController: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var newEmailTextField: UITextField!
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var newSignInButton: UIButton!
    var userModel = UserModel.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newEmailTextField.delegate = self
        newPasswordTextField.delegate = self
        newEmailTextField.text = "" //start with blank lines
        newPasswordTextField.text = ""
        newSignInButton.isEnabled = false
        // Do any additional setup after loading the view.
    }
    
    func configureSignInButton(){
        if newEmailTextField.hasText && newPasswordTextField.hasText{ //if there is text in both field and view
            newSignInButton.isEnabled = true //save button can be enabled
        }
        else{ //text view OR field does not have text
            newSignInButton.isEnabled = false //save button is disabled
        }
    }

    @IBAction func backgroundDidTapped(_ sender: UITapGestureRecognizer) {
        if newEmailTextField.isFirstResponder {
            newEmailTextField.resignFirstResponder()
            newPasswordTextField.becomeFirstResponder()
        }
        else{
            newPasswordTextField.resignFirstResponder()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if newEmailTextField.isFirstResponder {
            newEmailTextField.resignFirstResponder()
            newPasswordTextField.becomeFirstResponder()
        }
        else{
            newPasswordTextField.resignFirstResponder()
        }
        return true
    }
    
    @IBAction func textFieldEditingDidChanged(_ sender: UITextField) {
        configureSignInButton()
    }
    
    func signUpError(){
        newEmailTextField.text = ""
        newPasswordTextField.text = ""
        let alert = UIAlertController(title: "Error creating account", message: nil, preferredStyle: .alert)
        let okay = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
        //add the action to the alert
        alert.addAction(okay)
        //present the alert
        self.present(alert, animated: true, completion: nil)
        newSignInButton.isEnabled = false
        newEmailTextField.becomeFirstResponder()
    }
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using [segue destinationViewController].
//        if let UserFoldersViewController = segue.destination as? UIViewController{
////            let currentUser =
////                UserFoldersViewController.variable = current user
//            // Pass the selected object to the new view controller
//
//        }
//    }
    
    @IBAction func userDidTappedSignUp(_ sender: Any) {
        newPasswordTextField.resignFirstResponder()
        if let email = newEmailTextField.text, let password = newPasswordTextField.text{
            userModel.newUser(email: email, password: password) { (authDataResult, error) in
                if let error = error{
                    //alert controller for error
                    print(error)
                    self.signUpError()
                }
            }
        }
    }
    
}
