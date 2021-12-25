//
//  StudyViewController.swift
//  KodamaElaineFinalProject
//
//  Created by Elaine Kodama on 4/21/21.
//

import UIKit

class StudyViewController: UIViewController {
    
//    var currentFlashcard: Flashcard? = nil
    @IBOutlet weak var frontBack: UIImageView!
    @IBOutlet weak var cardSideLabel: UITextField!
    @IBOutlet weak var shuffleButton: UIButton!
    @IBOutlet weak var starButton: UIButton!
    var questionOrAnswer: Bool = true //true means front is displayed, false means back is displayed
    var flashcards = [Flashcard]()
    var frontDrawings: [String]? = nil
    var backDrawings: [String]? = nil
    var currentFlashcard: Flashcard? = nil
    
    var folderTitle: String!
    var setTitle: String!
    //USE THIS ID TO GET FLASHCARDS
    
    let firestoreModel = FirestoreModel.shared
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentFlashcard = nil
        starButton.setImage(UIImage(systemName: "star"), for: .normal) //set images for star button
        starButton.setImage(UIImage(systemName: "star.fill"), for: .selected) //filled star if button is
        updateUI()

        if let label = cardSideLabel.text{
            if label.elementsEqual("Front"){
                questionOrAnswer = true
            }
            else{
                questionOrAnswer = false
        }
            updateUI()
        //get the folders object from folder vc
        //get the array of flashcard from folders
        //
        }
    }
    
    func getFlashcards(){
        let flashcardArray = firestoreModel.getFlashcards(flashcardSetTitle: setTitle, folderTitle: folderTitle, completionHandler: { querySnapshot, error in
            if let error = error{
                print("Problem getting documents")
            }
            else{
                for document in querySnapshot!.documents {
                    //flashModel.addNewFlashcard(newFlashcard: document.data().values)
                    self.frontDrawings?.append(document.data()["front"] as! String)
                    self.backDrawings?.append(document.data()["back"] as! String)
                }
            }
        })
    }

    func getFrontImage() -> UIImage?{
        if let frontData = currentFlashcard?.frontFlashcard, //if there is data for the front flashcard
           let frontImage = firestoreModel.getImageFromPNGData(pngData: frontData) { //convert data to image
            return frontImage //display the image
        }
        return nil //there is no flashcard
    }
    
    func getBackImage() -> UIImage?{
        if let backData = currentFlashcard?.backFlashcard, //if there is data for the back flashcard
           let backimage = firestoreModel.getImageFromPNGData(pngData: backData){ //convert data to image
            return backimage //display the image
        }
        return nil //there is no flashcard
    }

    //update questionAnswer on card
    func updateUI(){
        if questionOrAnswer == true{ //if front should be displayed
            frontBack.image = getFrontImage()
            //get frontFlashcard
            //questionAnswer.text = currentFlashcard?.getQuestion()
        }
        else{ //if back should be displayed
            frontBack.image = getBackImage()
            //get backFlashcard
            //questionAnswer.text = currentFlashcard?.getAnswer()
        }
        starButton.isSelected = false
        if currentFlashcard?.favorite == true{
            starButton.isSelected = true //adjust star button
        }
    }


    @IBAction func userDidSwipedLeft(_ sender: UISwipeGestureRecognizer) {
        let moveLeft = UIViewPropertyAnimator(duration: 0.2, curve: .linear){
            var left = CGAffineTransform.identity
            left = left.translatedBy(x: -500, y: 0) //move flashcard off screen to the left
            self.frontBack.transform = left
        }
        moveLeft.startAnimation()

        moveLeft.addCompletion { (position) in
            print("\(position)")
            let goRight = UIViewPropertyAnimator(duration: 0.2, curve: .linear){
                var goRight = CGAffineTransform.identity
                goRight = goRight.translatedBy(x: 0, y: 0) //move card back into middle of screen
                self.frontBack.transform = goRight
            }
            if self.flashcards.count == 0{ //if no flashcards
                self.starButton.isSelected = false
                self.cardSideLabel.isHidden = true
                self.frontBack.image = UIImage(named: "BlankTemplate")
            }
            else{
                //self.currentFlashcard = self.flashModel.nextFlashcard() //get the next flashcard
                self.questionOrAnswer = true
                //update ui
                self.updateUI()
            }
            goRight.startAnimation()
        }
    }

    @IBAction func userDidSwipedRight(_ sender: UISwipeGestureRecognizer) {
        let moveRight = UIViewPropertyAnimator(duration: 0.2, curve: .linear){
            var right = CGAffineTransform.identity
            right = right.translatedBy(x: 500, y: 0) //move flashcard off screen to the right
            self.frontBack.transform = right
        }
        moveRight.startAnimation()

        moveRight.addCompletion { (position) in
            print("\(position)")
            let goLeft = UIViewPropertyAnimator(duration: 0.2, curve: .linear){
                var goLeft = CGAffineTransform.identity
                goLeft = goLeft.translatedBy(x: 0, y: 0) //move card back into middle of screen
                self.frontBack.transform = goLeft
            }
            if self.flashcards.count == 0{ //if no flashcards
                self.starButton.isSelected = false
                self.cardSideLabel.isHidden = true
                self.frontBack.image = UIImage(named: "BlankTemplate")
            }
            else{
                //self.currentFlashcard = self.flashModel.previousFlashcard() //get the next flashcard
                self.questionOrAnswer = true
                //update ui
                self.updateUI()
            }
            goLeft.startAnimation()
        }
    }

    @IBAction func userDidSingleTap(_ sender: UITapGestureRecognizer) {
        if questionOrAnswer == true { //front is currently displayed
            questionOrAnswer = false //display back
        }
        else { //back is currently displayed
            questionOrAnswer = true //display front
        }
        updateUI()
    }

    @IBAction func userDidTappedStarButton(_ sender: UIButton) {
       //flashModel.toggleFavorite()
        updateUI()
    }

    @IBAction func userDidTappedShuffle(_ sender: UIButton) {
        //flashModel.shuffle()
        updateUI()
    }
    
//    @IBAction func userDidTapBack(_ sender: UIBarButtonItem) {
//        performSegue(withIdentifier: "backButton", sender: self)
//    }
    


}
