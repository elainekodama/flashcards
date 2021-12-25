//
//  FlashcardsModel.swift
//  KodamaElaineFinalProject
//
//  Created by Elaine Kodama on 4/21/21.
//

import Foundation
import Firebase
import FirebaseAuth
import PencilKit

class FlashcardsModel {

    //private var folder: [Flashcard]?] //one set of flashcards, with title
    var currentFlashcard: Flashcard?
    var flashcardFolders = [String : [Flashcard?]?]() //folder name : list of flaschards
    internal var flashcards = [Flashcard?]() //list of flashcards from chosen flashcard folders
//    var flashcardsFileLocation: URL!
   // let currentUser : User? //whoever is logged in currently


    //let dataModel = DataModel.shared
    //SAVE DATA TO FIRESTORE

    static let shared = FlashcardsModel()

     init(){
////        let flash1 = Flashcard(frontFlashcard: "hi", backFlashcard: "bye", favorite: true)
////        let flash2 = Flashcard(question: "elaine", answer: "kodama", favorite: false)
////        let flash3 = Flashcard(question: "winnie", answer: "the poo", favorite: true)
////        self.flashcards = [flash1, flash2, flash3]
//        //self.folder = ["" : [Flashcard]()]
//        currentUser = UserModel.shared.loggedInUser
//        var path = "UnknownUser"
//        if let currentUser = currentUser{
//            path = currentUser.uid
//        }
//        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
//        flashcardsFileLocation = documentsDirectory.appendingPathComponent("\(path).json") //set location for file
//        print(flashcardsFileLocation ?? "") //print path
//        if FileManager.default.fileExists(atPath: flashcardsFileLocation.path){ //if the file already exists
//            self.load() //load the data on the file
//            self.currentFlashcard = flashcard(at: 0)
//        }
//        else{ //
//            self.save()
//            self.currentFlashcard = nil
//        }
    }

    init(flashcards: [Flashcard]){
//        self.currentUser = User() use listener helper to get the current user
        //folder: [String : [Flashcard]?],
//        flashcardFolders = [String : [Flashcard?]?]()
        self.flashcards = flashcards
        self.currentFlashcard = flashcards[0]
//        self.goPublic = goPublic
//        self.displayName = displayName
    }

    //get num flashcards in set
    func numberOfFlashcards() -> Int {
        return flashcards.count
    }

    func flashcard(at index: Int) -> Flashcard? {
        if (numberOfFlashcards() > 0) && (index < numberOfFlashcards()){
            return flashcards[index]
        }
        else{
            return nil
        }
    }

    func nextFlashcard() -> Flashcard? {
        if ((flashcards.isEmpty) != nil){ //if there are flashcards in set
            if currentFlashcard == flashcards.last { //if the current flashcard is the last flashcard
                currentFlashcard = flashcard(at: 0) //return the first flashcard in set
                return currentFlashcard
            }
            else{ //if the current flashcard is NOT the last flashcard
                let index = flashcards.firstIndex(of: currentFlashcard) //get the index of the current flashcard
                currentFlashcard = flashcard(at: ((index ?? 0) + 1)) //return the next card in list
                return currentFlashcard
            }
        }
        return nil
    }

    func previousFlashcard() -> Flashcard? {
        if ((flashcards.isEmpty) != nil){ //if there are flashcards in set
            if currentFlashcard == flashcards.first { //if the current flashcard is the first flashcard
                currentFlashcard = flashcard(at: (flashcards.endIndex ?? 0) - 1) //return the last flashcard in set
                return currentFlashcard
            }
            else{ //if the current flashcard is NOT the first flashcard
                let index = flashcards.firstIndex(of: currentFlashcard) //get the index of the current flashcard
                currentFlashcard = flashcard(at: ((index ?? 0) - 1)) //return the next card in list
                return currentFlashcard
            }
        }
        return nil
    }

    //remove a flashcard in table view
    func removeFlashcard(at index: Int) {
        if index > numberOfFlashcards() || index < 0{ //if the index is out of bounds
            print("That flashcard doesn't exist") //error message
            //do nothing to array
        }
        else{
            flashcards.remove(at: index) //remove card
            }
        //UPDATE FLASHCARDS DICTIONARY
        }

    func toggleFavorite() {
//        if var flashcard = currentFlashcard{
//            let index = flashcards.firstIndex(of: flashcard)
//            if flashcard.favorite == true { //if the card is favorited already
//                flashcard.favorite = false
//            }
//            else{ //if the card is not favorited
//                flashcard.favorite = true //favorite the card
//            }
//            flashcards[index ?? 0] = flashcard
//        }


//        let index = flashcards.firstIndex(of: currentFlashcard ?? Flashcard(question: "", answer: "", favorite: true))
//        //var updateFlashcard = flashcards[index ?? 0]
//        if currentFlashcard?.favorite == true { //if the card is favorited already
//            currentFlashcard?.favorite = false
//        }
//        else{ //if the card is not favorited
//            currentFlashcard?.favorite = true //favorite the card
//        }
//        flashcards[index ?? 0] = currentFlashcard
        //save()
    }

    //return a list of favorite flashcards
    func favoritesList() -> [Flashcard]{
        var favFlashcards = [Flashcard]() //initialize array of favorite flashcards
        for flashcard in flashcards { //loop through all flashcards
            if flashcard?.favorite == true{
                favFlashcards.append(flashcard!) //add favorited cards to array
            }
        }
        //save()
        return favFlashcards
    }

    func shuffle(){
        var randomFlashcards = flashcards //create a copy of flashcardSet
        randomFlashcards = randomFlashcards.shuffled() //shuffle the copied set
        currentFlashcard = randomFlashcards[0]
    }

    func addNewFlashcard(newFlashcard: Flashcard){
        flashcards.append(newFlashcard)
        //save()
    }
    
//    func save(){
//        do{
//            let encoder = JSONEncoder()
//            let data = try encoder.encode(flashcards) //encode flashcard array
//            let jsonString = String(data: data, encoding: .utf8) //convert array to json file
//            try jsonString?.write(to: flashcardsFileLocation, atomically: true, encoding: .utf8) //save json file to location
//        } catch{
//            print("Error writing to file system!")
//        }
//    }
//
//    //load data from file
//    func load() {
//        do{
//            let data = try Data(contentsOf: flashcardsFileLocation)
//            let decoder = JSONDecoder() //decode flashcard array
//            flashcards = try decoder.decode([Flashcard].self, from: data) //get array of flashcards
//        } catch{
//            print("Error reading file system!")
//        }
//    }
    
    func getImageFromPNGData(pngData: Data) -> UIImage?{
        if let image = UIImage(data: pngData){
            return image
        }
        else{
            return nil
        }
    }
    
    func getDataFromImage(image: UIImage) -> Data?{
        if let pngData = image.pngData() {
            return pngData
        }
        else{
            return nil
        }
    }
}
