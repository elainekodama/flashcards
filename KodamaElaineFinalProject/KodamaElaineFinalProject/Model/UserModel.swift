//
//  UserModel.swift
//  KodamaElaineFinalProject
//
//  Created by Elaine Kodama on 4/27/21.
//

import UIKit
import Firebase
import FirebaseAuth


class UserModel {
    
    internal var loggedInUser: User? //currently logged in user
    static let shared = UserModel() //singleton
    
    //user signs in using their email and password
    func signInWithEmail(email: String, password: String, completionHandler: @escaping (AuthDataResult?, Error?) -> Void) {
        // once google comes back and the user is verified with google, you will have a authcredential object
        Auth.auth().signIn(withEmail: email, password: password) { (authDataResult, error) in
            completionHandler(authDataResult, error)
        }
    }

    //user creates a new profile with an email and password
    func newUser(email: String, password: String, completionHandler: @escaping (AuthDataResult?, Error?) -> Void){
        Auth.auth().createUser(withEmail: email, password: password) { (authDataResult, error) in
            completionHandler(authDataResult, error) //switch view controllers, or display error message
            //authResult returns UID that you can use to store in the User collection in firestore
            
            FirestoreModel.shared.addUsers(email: email) // uid / ""
            
        }
        
       
    }

    // user logs out
    func signOut(){
        do{
            try Auth.auth().signOut()
        } catch let error as NSError{
            print("Error signing out", error)
        }
    }
    
    //check to see if user is logged in or not
    func listenerHelper() {
        Auth.auth().addStateDidChangeListener{ (auth, user) in
        
            if let user = user{
                self.loggedInUser = user
                /// Make the root view controller your home screen
                let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "HomeTabBarViewController")
                UIApplication.shared.windows[0].rootViewController = viewController
                UIApplication.shared.windows[0].makeKeyAndVisible()
            }
            else{
                // Make the root view controller your login page
                self.loggedInUser = nil
                let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "LogInViewController")
                UIApplication.shared.windows[0].rootViewController = viewController
                UIApplication.shared.windows[0].makeKeyAndVisible()
            }
        }
    }
}
