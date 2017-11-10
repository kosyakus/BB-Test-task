//
//  PostPatchUserService.swift
//  BinaryBlitzTestTask
//
//  Created by Admin on 10.11.17.
//  Copyright © 2017 NS. All rights reserved.
//

import Foundation
import Alamofire

class PostPatchService {
    
    func postUser(parameters: Parameters) {
    
        let url = "https://bb-test-server.herokuapp.com/users.json"
    
        Alamofire.request(url, method: .post, parameters: parameters).validate().responseJSON { responseJSON in
        
            switch responseJSON.result {
            case .success(let value):
                print(value)
            case .failure(let error):
            
                let message : String
                if let httpStatusCode = responseJSON.response?.statusCode {
                    switch(httpStatusCode) {
                    case 400:
                        message = "Username or password not provided."
                        print(message)
                    case 401:
                        message = "Incorrect password for user."
                        print(message)
                    default:
                        print(error)
                    }
                } else {
                    message = error.localizedDescription
                    print(message)
                }
                print(error)
            }
        }
    }

    func patchUser(parameters: Parameters, url: String) {
    
        Alamofire.request(url, method: .patch, parameters: parameters).validate().responseJSON { responseJSON in
        
            switch responseJSON.result {
            case .success(let value):
                print(value)
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
