//
//  UserService.swift
//  BinaryBlitzTestTask
//
//  Created by Admin on 08.11.17.
//  Copyright © 2017 NS. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class UserService {
    
    let url = "https://bb-test-server.herokuapp.com/users.json"
    var users = [User]()
    
    // function for parsing json
    typealias downloadUsersCompletion = () -> Void
    
    func downloadUsers(completion: @escaping (_ success: Bool) -> Void) {
        
        Alamofire.request(url).responseJSON { response in
            
            switch response.result {
            case .success(let rawJson):
                let json = JSON(rawJson)
                //print(json)
                for  (_, subJson):(String, JSON) in json[] {
                    if  let addUsers = User(subJson) {
                        self.users.append(addUsers)
                    }
                }
                
                completion(true)
                
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    func showUser() -> [User] {
        return Array(users)
    }

    
    
}
