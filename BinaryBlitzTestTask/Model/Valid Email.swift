//
//  Valid Email.swift
//  BinaryBlitzTestTask
//
//  Created by Admin on 02.11.17.
//  Copyright © 2017 NS. All rights reserved.
//

import Foundation

func validateEmail(enteredEmail:String) -> Bool {
    
    let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
    return emailPredicate.evaluate(with: enteredEmail)
    
}

