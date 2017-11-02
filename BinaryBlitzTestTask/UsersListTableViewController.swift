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
        
        //let yourObject = dataArray[[dataArray count] - 1 - indexPath.row];
        //cell.textLabel.text = yourObject
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

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
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
