//
//  AddEditUserTableViewController.swift
//  BinaryBlitzTestTask
//
//  Created by Admin on 31.10.17.
//  Copyright © 2017 NS. All rights reserved.
//

import UIKit
import Alamofire
//import SwiftyJSON

class AddEditUserTableViewController: UITableViewController, UITextFieldDelegate {

    var userToEdit: User? //This variable contains the existing ChecklistItem object that the user will be editing
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // the keyboard automatically appeared once the screen opens
        nameTextField.becomeFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // In editing mode, when itemToEdit is not nil, the title in the navigation bar is “Edit Item”
        if let user = userToEdit {
            title = "Edit User"
            nameTextField.text = user.name
            surnameTextField.text = user.surname
            emailTextField.text = user.email
            
            doneBarButton.isEnabled = true // enable the Done button
            
        }
        
        //nameTextField.delegate = self; surnameTextField.delegate = self; emailTextField.delegate = self
        //doneBarButton.isEnabled = false
        
    }

    
    
    
    // check if the text field is empty, then the Done button is not enabled (also in the storyboard attr inspector)
    func textField(_ nameTextField: UITextField, _ surnameTextField: UITextField, _ emailTextField: UITextField, shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        let oldNameText = nameTextField.text! as NSString
        let newNameText = oldNameText.replacingCharacters(in: range, with: string) as NSString
        let oldSurnameText = surnameTextField.text! as NSString
        let newSurnameText = oldSurnameText.replacingCharacters(in: range, with: string) as NSString
        let oldEmailText = emailTextField.text! as NSString
        let newEmailText = oldEmailText.replacingCharacters(in: range, with: string) as NSString
        
        //doneBarButton.isEnabled = (newText.length > 0) // the same as if-else
        
         if newNameText.length > 0 && newSurnameText.length > 0 && newEmailText.length > 0 {
         doneBarButton.isEnabled = true
         } else {
         doneBarButton.isEnabled = false
         }
    
        return true
    }
    

    

    

    

    
    
    @IBAction func cancel() {
        // This tells the app to close the Add Item screen with an animation
         dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    
    
    
    
    
    @IBAction func done() {
        if let user = userToEdit {
            
            user.name = nameTextField.text!
            user.surname = surnameTextField.text!
            user.email = emailTextField.text!
            let id = "\(user.userId).json"
            
            //PATCH
            
            let params: Parameters = [
                "user": [
                    "first_name": user.name,
                    "last_name": user.surname,
                    "email": user.email,
                    "avatar_url": user.thumbnail
                ]
            ]
            
            let url = "https://bb-test-server.herokuapp.com/users/\(id)"
            
            Alamofire.request(url, method: .patch, parameters: params).validate().responseJSON { responseJSON in
                
                switch responseJSON.result {
                case .success(let value):
                    print(value)
                case .failure(let error):
                    print(error)
                }
            }
            
        } else {
            let user = User()
            user.name = nameTextField.text!
            user.surname = surnameTextField.text!
            user.email = emailTextField.text!
            
            // POST
            let params: Parameters = [
                "user": [
                    "first_name": user.name,
                    "last_name": user.surname,
                    "email": user.email,
                    "avatar_url": "https://channelkit-assets.s3.amazonaws.com/uploads/card/cover/105607/thumb_Homepage-slide-for-NB-FEB-768x432.jpeg"
                        ]
            ]
            
            Alamofire.request("https://bb-test-server.herokuapp.com/users.json", method: .post, parameters: params).validate().responseJSON { responseJSON in
                
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
        dismiss(animated: true, completion: nil)
    }
    
    

}
