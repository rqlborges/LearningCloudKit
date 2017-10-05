//
//  FriendsTableViewController.swift
//  PopSoda
//
//  Created by Erick Borges on 04/10/2017.
//  Copyright © 2017 Erick Borges. All rights reserved.
//

import UIKit

class FriendsTableViewController: UITableViewController {

    var friends:[User] = []
    var friendCell = "friendCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        loadFriends()
    }

    func loadFriends() {
        UserManager.shared.fetchDataFriends(callback: { (friends,error) in
            guard error == nil else {
                print("an error occurred.")
                return
            }
            
            if let friends = friends {
                self.friends = friends
            } else {
                print("Could not load friends")
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return friends.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: friendCell, for: indexPath) as! FriendsTableViewCell
        // Configure the cell...
        cell.friendNameLabel.text = friends[indexPath.row].name
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toFriendsDrinks" {
            if let friendsDrinksTableView = segue.destination as? FriendsDrinksTableViewController {
                let selectedFriend = self.friends[tableView.indexPathForSelectedRow!.row]
                friendsDrinksTableView.drinks = selectedFriend.drinksString
                friendsDrinksTableView.nameTitle = selectedFriend.name
            }
        }
    }

}
