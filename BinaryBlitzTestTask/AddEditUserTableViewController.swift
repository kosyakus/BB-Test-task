//
//  AddEditUserTableViewController.swift
//  BinaryBlitzTestTask
//
//  Created by Admin on 31.10.17.
//  Copyright © 2017 NS. All rights reserved.
//

import UIKit

class AddEditUserTableViewController: UITableViewController {

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
    

    

    

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func cancel() {
        // This tells the app to close the Add Item screen with an animation
         dismiss(animated: true, completion: nil)
    }
    
    

}
