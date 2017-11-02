//
//  UsersListTableViewController.swift
//  BinaryBlitzTestTask
//
//  Created by Admin on 31.10.17.
//  Copyright © 2017 NS. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class UsersListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        downloadUsers(completion: { (success) in
            if success {
                print("success")
                //print(self.users)
                self.tableView.reloadData()
            }
        })
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
        
        let user = users.reversed()[indexPath.row]
        
        cell.nameLabel.text = "\(user.name) \(user.surname)"
        cell.emailLabel.text = user.email
        
        if let imgURL:URL = URL(string: user.thumbnail) {
            let imgData = try! Data(contentsOf: imgURL)
            cell.thumbnail.image = UIImage(data: imgData)
        } else {
            cell.thumbnail.image = UIImage(named: "noimage")
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
        
    }

    

    

    

    

    
    // MARK: - Navigation

     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     
     if segue.identifier == "AddUser" {
     let navigationController = segue.destination as! UINavigationController
     let controller = navigationController.topViewController as! AddEditUserTableViewController
     
     //controller.delegate = self
     
     } else if segue.identifier == "EditUser" {
     let navigationController = segue.destination as! UINavigationController
     let controller = navigationController.topViewController as! AddEditUserTableViewController
     
     //controller.delegate = self
     
     // that UITableViewCell object find the row number by looking up the corresponding index-path using tableView.indexPath(for)
     if let indexPath = tableView.indexPath(
     for: sender as! UITableViewCell) {
     controller.userToEdit = users.reversed()[indexPath.row]
            }
        }
    }
 
    
    
    
    
    var users = [User]()
    let url = "https://bb-test-server.herokuapp.com/users.json"
    
    // functions for parsing json
    typealias downloadUsersCompletion = () -> Void
    
    func downloadUsers(completion: @escaping (_ success: Bool) -> Void) {
        
        Alamofire.request(url).responseJSON { [weak self] response in
            
            switch response.result {
            case .success(let rawJson):
                let json = JSON(rawJson)
                //print(json)
                for  (_, subJson):(String, JSON) in json[] {
                    if  let addUsers = User(subJson) {
                        self?.users.append(addUsers)
                    }
                 }
                
                completion(true)
                
            case .failure(let error):
                print(error)
            }
        }
        
    }

}
