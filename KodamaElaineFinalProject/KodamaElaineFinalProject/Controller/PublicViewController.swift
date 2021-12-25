//
//  PublicViewController.swift
//  KodamaElaineFinalProject
//
//  Created by Elaine Kodama on 5/1/21.
//

import UIKit

class PublicViewController: UIViewController {
    
    var publicFolders = [String]() //list of folder names
    //Should be same as FolderViewController except using table view instead of collection
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //FirestoreModel.shared.publicFlashcardSets(folderTitle: folderTitle, completionHandler: <#T##(QuerySnapshot?, Error?) -> Void#>)
        // Do any additional setup after loading the view.
        
        //use a collection view
    }
    
    @IBAction func userDidTappedLogOut(_ sender: UIBarButtonItem) {
        UserModel.shared.signOut()
    }

}
