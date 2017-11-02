//
//  User.swift
//  BinaryBlitzTestTask
//
//  Created by Admin on 31.10.17.
//  Copyright © 2017 NS. All rights reserved.
//

import Foundation
import SwiftyJSON

class User {
    
    var name: String = ""
    var surname: String = ""
    var thumbnail: String = ""
    var email: String = ""
    var userId: Int = 0
    
    
    convenience init?(_ json: JSON) {
        
        guard
            let name = json["first_name"].string,
            let surname = json["last_name"].string,
            let thumbnail = json["avatar_url"].string,
            let email = json["email"].string,
            let userId = json["id"].int
            else { return nil }
        
        self.init()
        self.name = name
        self.surname = surname
        self.thumbnail = thumbnail
        self.email = email
        self.userId = userId
        
        
    }
    
}
