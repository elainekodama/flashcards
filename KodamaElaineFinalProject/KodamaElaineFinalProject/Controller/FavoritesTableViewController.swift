//
//  FavoritesTableViewController.swift
//  KodamaElaineFinalProject
//
//  Created by Elaine Kodama on 5/3/21.
//

import UIKit

class FavoritesTableViewController: UITableViewController {

    var favoritesArray = [Any]()
    //let flashcard = FlashcardsModel.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoritesArray = []
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return favoritesArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoritesCell", for: indexPath)
        let flash = favoritesArray[indexPath.row]
        //cell.textLabel?.text = flash.getQuestion() //get drawing
        return cell
    }
    
    @IBAction func userDidTappedLogOut(_ sender: UIBarButtonItem) {
        UserModel.shared.signOut()
        //performSegue(withIdentifier: "LogOutSegue", sender: self)
    }

}
