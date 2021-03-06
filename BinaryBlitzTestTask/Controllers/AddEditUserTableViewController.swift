//
//  AddEditUserTableViewController.swift
//  BinaryBlitzTestTask
//
//  Created by Admin on 31.10.17.
//  Copyright © 2017 NS. All rights reserved.
//

import UIKit
import Alamofire

class AddEditUserTableViewController: UITableViewController, UITextFieldDelegate {

    var userToEdit: User? //This variable contains the existing UserItem object that the user will be editing
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    
    var buttonHelper: ButtonValidationHelper!
    
    let postPatchService = PostPatchService()
    
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
        
        
        buttonHelper = ButtonValidationHelper(textFields: [nameTextField, surnameTextField, emailTextField], buttons: [doneBarButton])
            
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
            
            postPatchService.patchUser(parameters: params, url: url)
            
            
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
            
            postPatchService.postUser(parameters: params)
        }
        dismiss(animated: true, completion: nil)
    }
    
    

}
