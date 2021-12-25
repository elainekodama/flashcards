//
//  LogInViewController.swift
//  KodamaElaineFinalProject
//
//  Created by Elaine Kodama on 4/18/21.
//

import UIKit
import FirebaseAuth


class LogInViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    var userModel = UserModel.shared
            
    override func viewDidLoad() {
      
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        //GIDSignIn.sharedInstance().presentingViewController = self
        signInButton.isEnabled = false
    }
    
    func configureSignInButton(){
        if emailTextField.hasText && passwordTextField.hasText{ //if there is text in both field and view
            signInButton.isEnabled = true //save button can be enabled
        }
        else{ //text view OR field does not have text
            signInButton.isEnabled = false //save button is disabled
        }
    }
    
    //when text is added to text field check if sign in button can be enabled
    @IBAction func textFieldEditingDidChanged(_ sender: UITextField) {
        configureSignInButton()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if emailTextField.isFirstResponder {
            emailTextField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
        }
        else{
            passwordTextField.resignFirstResponder()
        }
        return true
    }
    
    @IBAction func backgroundDidTapped(_ sender: UITapGestureRecognizer) {
        if emailTextField.isFirstResponder {
            emailTextField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
        }
        else{
            passwordTextField.resignFirstResponder()
        }
    }
    
    func incorrectLogIn(){
        let alert = UIAlertController(title: "Error logging in", message: nil, preferredStyle: .alert)
        //option to clear all will set default values
        let okay = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
        //add the actions to the alert
        alert.addAction(okay)
        //present the alert
        present(alert, animated: true, completion: nil)
        
        emailTextField.text = ""
        passwordTextField.text = ""
        //alert controllers
        signInButton.isEnabled = false
        emailTextField.becomeFirstResponder()
    }
    
    @IBAction func userDidTappedSignIn(_ sender: UIButton) {
        passwordTextField.resignFirstResponder()
        if let email = emailTextField.text, let password = passwordTextField.text{
            userModel.signInWithEmail(email: email, password: password) { (authDataResult, error) in
                if let error = error{
                    self.incorrectLogIn()
                }
            }
            
        }
   }
    
    @IBAction func userDidTappedSignUp(_ sender: UIButton) {
        performSegue(withIdentifier: "NewUserSegue", sender: self) //segue to new user page
    }
}
