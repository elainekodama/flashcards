//
//  FlashcardSetViewController.swift
//  KodamaElaineFinalProject
//
//  Created by Elaine Kodama on 5/30/21.
//

import UIKit

class SetViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var setSearchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
//    @IBOutlet weak var settingsButton: UIBarButtonItem!
    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet var backgroundTap: UITapGestureRecognizer!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var navigationBarTitle: UINavigationItem!

//    var folderTitle: String!

    //    var flashcardSets = [String]()
    var titles = [String]()
    var data = [Any]()
    var userModel = UserModel.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        //collectionView.becomeFirstResponder()
        collectionView.dataSource = self
        setSearchBar.delegate = self
        getSets()
//        navigationBarTitle.title = folderTitle
        }

    //store flashcard sets on start up
    func getSets(){
        //need to pass title on to this vc
//        FirestoreModel.shared.getFlashcardSets(folderTitle: "folderTitle", completionHandler: {
        FirestoreModel.shared.getFlashcardSets(completionHandler: {
            querySnapshot, error in
                if error != nil {
                    print("Problem getting documents")
                }
                else {
                    for document in querySnapshot!.documents {
                        let setTitle = document.documentID as String
                        self.titles.append(setTitle)
                    }
                    self.collectionView.reloadData()
                }
        })
    }

    override func viewWillAppear(_ animated: Bool) {
        collectionView.reloadData() //refresh data
    }

    //resign keyboard on background tap or return key
    @IBAction func userDidTappedBackground(_ sender: UITapGestureRecognizer) {
        setSearchBar.resignFirstResponder()
    }
    func userDidTappedReturnKey(_ textView: UISearchBar) {
        setSearchBar.resignFirstResponder()
    }

    //recycle collection view
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return titles.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "flashcardSetCell", for: indexPath)
        //folders = [[documentID : folderDoc]]
        let setTitle = titles[indexPath.row]

        print("collection view data: \(data)")
        (cell as! SetCollectionViewCell).titleLabel.text = setTitle
        (cell as! SetCollectionViewCell).imageView.image = UIImage(systemName: "folder.fill")

        return cell
    }

    //adjust ui for iphone or ipad
    override func viewDidLayoutSubviews() {
        //print("view did layout subviews")
        let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        flowLayout?.estimatedItemSize = .zero
        if UIDevice.current.userInterfaceIdiom == .phone{ //devise is phone
            let size = (collectionView.bounds.width / 3) - 15 //calculate a little less than half width
            flowLayout?.itemSize = CGSize(width: size, height: size) //display two cells per row
        }
        else { //device is ipad
            let size = (collectionView.bounds.width / 5) - 15 //calculate a little less than half width
            flowLayout?.itemSize = CGSize(width: size, height: size)
        }
    }
    
    //open up the set and view the individual flashcards
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let flashcardsViewController = segue.destination as? FlashcardsViewController{
            let indexPath = collectionView.indexPathsForSelectedItems!.first!.row
            // Pass the selected folder to the next view
            //get the index of the titles array and pass that as a string
            //title of folder
            
            let title = titles[indexPath] //get a dictionary for a single document
            flashcardsViewController.folderTitle = title //pass over the folder title to flashcards view
        }
    }
    
    //new set
    @IBAction func userDidTappedAdd(_ sender: UIBarButtonItem) {
        //performSegue(withIdentifier: "NewFolderSegue", sender: self)
    }

    @IBAction func userDidTappedBackButton(_ sender: UIBarButtonItem) {
//        performSegue(withIdentifier: "backToFolders", sender: self)
        //TODO: log out for the back button instead of going back to folders
            //deleted the segue for now (Present Modually, Full screen, same as destination)
        userModel.signOut()
    }
    
}
