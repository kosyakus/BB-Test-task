//
//  User.swift
//  BinaryBlitzTestTask
//
//  Created by Admin on 31.10.17.
//  Copyright © 2017 NS. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

class News: Object {
    
    dynamic var name: String = ""
    dynamic var surname: String = ""
    dynamic var thumbnail: String = ""
    dynamic var email: String = ""
    
    
    convenience init?(_ json: JSON) {
        
        guard
            let name = json["first_name"].string,
            let surname = json["last_name"].string,
            let thumbnail = json["avatar_url"].string,
            let email = json["email"].string,
            else { return nil }
        
        self.init()
        self.name = name
        self.surname = surname
        self.thumbnail = thumbnail
        self.email = email
        
        
    }
    
}
