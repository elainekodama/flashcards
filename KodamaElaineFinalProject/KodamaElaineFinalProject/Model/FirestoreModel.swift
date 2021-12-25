//
//  FirestoreModel.swift
//  KodamaElaineFinalProject
//
//  Created by Elaine Kodama on 5/5/21.
//

import Foundation
import Firebase
import PencilKit

class FirestoreModel{
    
    
    var allFolders = [Any]() //get all of the users Folder names
    let fs = Firestore.firestore()
    static let shared = FirestoreModel() //singleton

    //get all the folders for the current user
    func getAllFolders(completionHandler: @escaping (QuerySnapshot?, Error?) -> Void){
        guard let userId = UserModel.shared.loggedInUser?.uid else { return }
        
        fs.collection("folders").whereField("uid", isEqualTo: userId).getDocuments { (querySnapshot, error) in //get all folders for the UID
            completionHandler(querySnapshot, error)
        }
    }
    
    //get all flashcard sets within a folder
    func getFlashcardSets(folderTitle: String, completionHandler: @escaping (QuerySnapshot?, Error?) -> Void){
        guard let userId = UserModel.shared.loggedInUser?.uid else { return }
        
        fs.collection("flashcardSet").whereField("uid", isEqualTo: userId).whereField("folderTitle", isEqualTo: folderTitle).getDocuments { (querySnapshot, error) in
            completionHandler(querySnapshot, error)
        }

    }
    
    func getFlashcards(flashcardSetTitle: String, folderTitle: String, completionHandler: @escaping (QuerySnapshot?, Error?) -> Void){
 
        fs.collection("flaschards").whereField("folderTitle", isEqualTo: folderTitle).whereField("setTitle", isEqualTo: flashcardSetTitle).getDocuments { (querySnapshot, error) in
            completionHandler(querySnapshot, error)
        }
    }
    
    //add a folder for user
    func addFolder(folderTitle: String){
        
        fs.collection("folders").document(folderTitle).setData(([
            "uid": UserModel.shared.loggedInUser!.uid,
        ])) { error in
            if let error = error {
                print("Error writing document: \(error)")
            }
            else {
                print("Document successfully written!")
            }
        }
    }
    
    //add a flashcard set to a folder
    func addFlashcardSet(folderTitle: String, setTitle: String, isPublic: Bool, displayName: Bool, template: String){
       
        fs.collection("flashcardSet").document(setTitle).setData(([
            "uid": UserModel.shared.loggedInUser!.uid,
            "folderTitle": folderTitle, //folder that deck is in
            //"setTitle" : setTitle, //title for flashcard deck
            "isPublic": isPublic, //if user wants the folder to be public
            "displayName" : displayName, //if public, and user wants to have their name shown
            "template" : template //whatever template the user chooses
        ])) { error in
            if let error = error {
                print("Error writing document: \(error)")
            }
            else {
                print("Document successfully written!")
            }
        }
    }
    
    //add flashcard to flashcard set
    func addFlashcards(folderTitle: String, setTitle: String, frontDrawing: Any, backDrawing: Any, favorite: Bool){
        fs.collection("flashcards").addDocument(data: ([
        "uid": UserModel.shared.loggedInUser!.uid,
        "folderTitle": folderTitle,
        "setTitle": setTitle,
        "front" : frontDrawing, // data for the front image
        "back" : backDrawing, // data for the back image
        "favorite" : favorite // favorite bool, should be false
        ])) { error in
            if let error = error {
                print("Error writing document: \(error)")
            }
            else {
                print("Document successfully written!")
            }
        }
    }
    
    //"users" -> uid : email
    func addUsers(email: String){
        fs.collection("users").document(UserModel.shared.loggedInUser!.uid).setData(["email" : email]) //connect user from auth to firestore
    }
    
    //for displaying the image on the flashcard
    func getImageFromPNGData(pngData: Any) -> UIImage?{
        if let image = UIImage(data: pngData as! Data){ //get image from png data
            return image
        }
        else{
            return UIImage(named: "BlankTemplate")
        }
    }
    
    //for storing the image
    func getDataFromImage(image: UIImage?) -> Any?{
        if let image = image{
            let pngData = image.pngData() // get png data for image
            return pngData
        }
        else{
            return nil
        }
    }
    
    //return all folders that have been marked as public
    func publicFlashcardSets(folderTitle: String, completionHandler: @escaping (QuerySnapshot?, Error?) -> Void){
        fs.collection("flashcardSet").whereField("isPublic", isEqualTo: true).getDocuments { (querySnapshot, error) in
            completionHandler(querySnapshot, error)
        }
    }
    
}
