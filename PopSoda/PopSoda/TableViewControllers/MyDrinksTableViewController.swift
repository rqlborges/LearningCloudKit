//
//  MyDrinksTableViewController.swift
//  PopSoda
//
//  Created by Erick Borges on 04/10/2017.
//  Copyright © 2017 Erick Borges. All rights reserved.
//

import UIKit

class MyDrinksTableViewController: UITableViewController {

    var user:User!
    @IBOutlet var tbView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.reloadData()
        
        if UserDefaults.standard.string(forKey: "username") == nil {
            askUserName()
        } else {
            searchUser()
        }

        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
         self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    func askUserName() {
        let alert = UIAlertController(title: "User Name", message: "Type your name bellow, and press Ok.", preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        alert.addAction(UIAlertAction(title: "Ok", style: .default , handler: { (action) in
            let text = alert.textFields?.first?.text ?? "BURRO"
            UserDefaults.standard.set(text, forKey: "username")
            self.user = User(name: text)
            UserManager.shared.save(user: self.user)
        }))
        self.present(alert, animated: true, completion: nil)
    tableView.reloadData()
    }
    
    func searchUser() {
        let name = UserDefaults.standard.string(forKey: "username")
        UserManager.shared.fetchData(name: name!, callback: { (users, error) in
            guard error == nil else {
                print("an error occurred.")
                return
            }
            
            if let user = users?.first {
                self.user = user
            } else {
                return
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
        if user != nil{
          return self.user.drinks.count
        }
        
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myDrinkCell", for: indexPath) as! MyDrinkTableViewCell

        if user != nil{
         cell.drinkName.text = user.drinks[indexPath.row].name
        }else{
         cell.drinkName.text = ""
        }

        return cell
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            self.user.drinks.remove(at: indexPath.row)
            self.user.drinksString.remove(at: indexPath.row)
            UserManager.shared.update(user: self.user)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    @IBAction func addAction(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "New Drink", message: "Type new drink name, and tap Ok", preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Ok", style: .default , handler: { (action) in
                let text = alert.textFields?.first?.text ?? "LeiteDeBurra"
                let drink = Drink(name:text)
                self.user.drinks.append(drink)
                self.user.drinksString.append(drink.name)
                UserManager.shared.update(user: self.user)
                print(self.user)
                self.tableView.reloadData()
            }))
        self.present(alert, animated: true, completion: nil)
        tableView.reloadData()
    }
    
}
