//
//  FolderViewController.swift
//  KodamaElaineFinalProject
//
//  Created by Elaine Kodama on 5/1/21.
//

import UIKit

class FolderCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var foldersSearchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var settingsButton: UIBarButtonItem!
    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet var backgroundTap: UITapGestureRecognizer!
    
//    var folders = [String : Any]() //folder name : array of flashcards
    var titles = [String]() //titles of folders
    var data = [Any]() //
    var userModel = UserModel.shared
        
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        //collectionView.becomeFirstResponder()
        collectionView.dataSource = self
        foldersSearchBar.delegate = self
        getFolders()
        
////            print("User: \(firebase.loggedInUser)")
////            let currentUser = firebase.loggedInUser?.email
        }
    
    //get all folders on startup
    func getFolders(){
        FirestoreModel.shared.getAllFolders(completionHandler: { querySnapshot, error in
            if error != nil{
                print("Problem getting documents")
            }
            else{
                for document in querySnapshot!.documents {
                    //self.folders.updateValue(document.data(), forKey: document.documentID) //list of Folder documents [String : Any]
                    //self.titles.append(document.data().keys)
                    let folderTitle = document.documentID as String
                    self.titles.append(folderTitle)
                }
                self.collectionView.reloadData()
            }
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        collectionView.reloadData() //refresh data
    }
    
    //resign keyboard on background tap or enter key
    @IBAction func userDidTappedBackground(_ sender: UITapGestureRecognizer) {
        foldersSearchBar.resignFirstResponder()
    }
    func userDidTappedReturnKey(_ textView: UISearchBar) {
        foldersSearchBar.resignFirstResponder()
    }

    //recycle collectionviews
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return titles.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FolderCell", for: indexPath)
        //folders = [[documentID : folderDoc]]
        let title = titles[indexPath.row]
        
        print("collection view data: \(data)")
        (cell as! FolderCollectionViewCell).folderTextLabel.text = title
        (cell as! FolderCollectionViewCell).folderImageView.image = UIImage(systemName: "folder.fill")

        return cell
    }
    
    //set the size of the view to fit device
    override func viewDidLayoutSubviews() {
        //print("view did layout subviews")
        let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        flowLayout?.estimatedItemSize = .zero
        if UIDevice.current.userInterfaceIdiom == .phone{ //phone
            let size = (collectionView.bounds.width / 3) - 15 //calculate a little less than half width
            flowLayout?.itemSize = CGSize(width: size, height: size) //display two cells per row
        }
        else { //ipad
            let size = (collectionView.bounds.width / 5) - 15 //calculate a little less than half width
            flowLayout?.itemSize = CGSize(width: size, height: size)
        }
    }
    
    // Pass the selected folder to the next view
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let flashcardSetViewController = segue.destination as? SetViewController{
            let indexPath = collectionView.indexPathsForSelectedItems!.first!.row
            let title = titles[indexPath] //get the index of the titles array and pass that as a string
            
//            TODO: pass over the folder title name to the set view controller
//            flashcardSetViewController.folderTitle = title //pass over the folder title to flashcards view
        }
    }
    
//    @IBAction func userDidTappedFolder(_ sender: FolderCollectionViewCell) {
//        performSegue(withIdentifier: "folderToSet", sender: self)
//    }
 
    //make a new folder
    @IBAction func userDidTappedAdd(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "NewFolderSegue", sender: self)
    }
    
    //log out
    @IBAction func userDidTappedLogOut(_ sender: UIBarButtonItem) {
        userModel.signOut()
    }
}
