//
//  Valid Email.swift
//  BinaryBlitzTestTask
//
//  Created by Admin on 02.11.17.
//  Copyright © 2017 NS. All rights reserved.
//

import Foundation

/*extension NSRegularExpression {
    
    convenience init(pattern: String) {
        try! self.init(pattern: pattern, options: [])
    }
}

extension String {
    
    var isValidEmail: Bool {
        return isMatching(expression: NSRegularExpression(pattern: "^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$"))
    }
    
    //MARK: - Private
    
    private func isMatching(expression: NSRegularExpression) -> Bool {
        return expression.numberOfMatches(in: self, range: NSRange(location: 0, length: characters.count)) > 0
    }
}*/


//with a valid regex
func validateEmail(enteredEmail:String) -> Bool {
    
    let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
    return emailPredicate.evaluate(with: enteredEmail)
    
}

