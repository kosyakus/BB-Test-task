//
//  UsersListTableViewController.swift
//  BinaryBlitzTestTask
//
//  Created by Admin on 31.10.17.
//  Copyright © 2017 NS. All rights reserved.
//

import UIKit

class UsersListTableViewController: UITableViewController {
    
    var users = [User]()
    let userService = UserService()

    override func viewDidLoad() {
        super.viewDidLoad()
       
        userService.downloadUsers(completion: { (success) in
            if success {
                print("success")
                self.users = self.userService.showUser()
                self.tableView.reloadData()
            }
        })
   
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UsersListCell", for: indexPath) as! UsersTableViewCell
        // sort the array of users by id
        let userArray = users.sorted{ $0.userId > $1.userId }
        let user = userArray[indexPath.row]
        
        cell.nameLabel.text = "\(user.name) \(user.surname)"
        cell.emailLabel.text = user.email
        
        if let imgURL:URL = URL(string: user.thumbnail) {
            let imgData = try? Data(contentsOf: imgURL)
                if let imgData = imgData {
                    cell.thumbnail.image = UIImage(data: imgData)
            }
        } else {
            cell.thumbnail.image = UIImage(named: "noimage")
        }

        
        return cell
    }
    
    // make a custom height
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
        
    }
    
    // in storyboard change the Refresh to "Enabled", refr controll will appear. then connect it to this method
    @IBAction func refreshControlActivated(_ sender: UIRefreshControl) {
        tableView.reloadData()
        sender.endRefreshing() // this line ends the animation
    }

    
    
    // MARK: - Navigation

     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     
     if segue.identifier == "AddUser" {
     let navigationController = segue.destination as! UINavigationController
     let _ = navigationController.topViewController as! AddEditUserTableViewController
     
     
     } else if segue.identifier == "EditUser" {
     let navigationController = segue.destination as! UINavigationController
     let controller = navigationController.topViewController as! AddEditUserTableViewController
     
     
     // that UITableViewCell object find the row number by looking up the corresponding index-path using tableView.indexPath(for)
     if let indexPath = tableView.indexPath(
     for: sender as! UITableViewCell) {
        let userArray = users.sorted{ $0.userId > $1.userId }
        controller.userToEdit = userArray[indexPath.row]
            }
        }
    }
   
    
}
