//
//  FlashcardViewController.swift
//  KodamaElaineFinalProject
//
//  Created by Elaine Kodama on 5/2/21.
//

import UIKit
import PencilKit

class FlashcardsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{

    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var flashcards = [Any?]() //array of flashcards data snapshot
    var flashcardID = [Any?]() //array of individual flashcards id
    var frontDrawings = [Any?]() //array of front drawings
    var backDrawings = [Any?]() //array of back drawings
    var folderTitle: String! //title of folder that flashcards are in, passed in from FolderCollectionView or NewFolder
    var setTitle: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    func getFlashcards(){
        FirestoreModel.shared.getFlashcards(flashcardSetTitle: setTitle, folderTitle: folderTitle, completionHandler: { querySnapshot, error in
            if let error = error{
                print("Problem getting documents")
            }
            else{
                for document in querySnapshot!.documents {   self.flashcards.append(document.data()) //add snapshot of individual flashcards into flashcards
                    // [String : Any]
                    //self.flashcardID.append(document.documentID) //get each flashcards doc ID
                    self.frontDrawings.append(document.data()["front"])
                }
                self.collectionView.reloadData()
            }
        })
    }

    @IBAction func userDidTappedAdd(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "addFlashcard", sender: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return flashcards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FolderCell", for: indexPath)
        let data = flashcards[indexPath.row] //get a dictionary for a single document
        let front = frontDrawings[indexPath.row]
        let drawing = FirestoreModel.shared.getImageFromPNGData(pngData: front)
        (cell as! FlashcardCollectionViewCell).frontFlashcards = drawing

        return cell

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let addFlashcardViewController = segue.destination as? AddFlashcardViewController{
            // Pass the selected object to the new view controller
            addFlashcardViewController.folderTitle = folderTitle //title of folder
            addFlashcardViewController.setTitle = setTitle
        }
    }
    
    @IBAction func userDidTappedLogOut(_ sender: UIBarButtonItem) {
        UserModel.shared.signOut()
    }
}
