//
//  FlashcardSet.swift
//  KodamaElaineFinalProject
//
//  Created by Elaine Kodama on 4/28/21.
//

import Foundation
import PencilKit

struct Flashcard: Equatable, Codable {
    internal var frontFlashcard: Data //png data for front image
    internal var backFlashcard: Data //png data for back image
    internal var favorite: Bool //if it is a favorite flashcard or nto
    
    //create a new flashcard
    init(frontFlashcard: Data, backFlashcard: Data, favorite: Bool) {
        self.frontFlashcard = frontFlashcard
        self.backFlashcard = backFlashcard
        self.favorite = favorite
    }
}

struct FlashcardFolder{
    let title: String
    let template: String
    let flashcards: [Flashcard] //array of flashcards for this folder
    let goPublic: Bool //if user wants to add this folder to public database
    let displayName: Bool //if public, if they want to display their name
    
    //create new folder
    init(title: String, template: String, flashcards: [Flashcard], goPublic: Bool, displayName: Bool){
        self.title = title
        self.template = template
        self.flashcards = flashcards
        self.goPublic = goPublic
        self.displayName = displayName
    }
    
    //get the number of folders
    func numberOfFolders() -> Int{
        return flashcards.count
    }
}

struct FlashcardUser{
    var email: String
    var folders: [FlashcardFolder]
//    var allFlashcards: [Flashcard] {
//        var flashcardsArray = [Flashcard]()
//        for folder in folders{
//            for set in folder.sets{
//                for card in set.flashcards{
//                    flashcardsArray.append(card)
//                }
//            }
//        }
//        return flashcardsArray
    //}
}
