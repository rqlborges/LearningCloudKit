//
//  FriendsDrinksTableViewController.swift
//  PopSoda
//
//  Created by Erick Borges on 04/10/2017.
//  Copyright © 2017 Erick Borges. All rights reserved.
//

import UIKit

class FriendsDrinksTableViewController: UITableViewController {

    @IBOutlet weak var titleNavgationItem: UINavigationItem!
    var nameTitle: String = ""
    var drinks: [String] = []
    var friendsDrinksCell = "friendsDrinksCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

    }
    
    override func viewWillAppear(_ animated: Bool) {
        titleNavgationItem.title = "\(nameTitle)'s Drinks"
        tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return drinks.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: friendsDrinksCell, for: indexPath) as? FriendsDrinksTableViewCell
        // Configure the cell...
        cell?.drinkNameLabel.text = drinks[indexPath.row]
        return cell!
    }

}
