//
//  CreateAccountViewController.swift
//  Fantasy Stock App
//
//  Created by Matt W on 4/17/19.
//  Copyright © 2019 Group 4. All rights reserved.
//

import UIKit

class CreateAccountViewController: UIViewController {
    
    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    @IBOutlet weak var userRepeatPasswordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func createAccountButtonClicked(_ sender: Any) {
        let userEmail = userEmailTextField.text;
        let userPassword = userPasswordTextField.text;
        let userPassword2 = userRepeatPasswordTextField.text;
        
        print(userEmail);
        print(userPassword);
        
        // check for empty fields
        if (userEmail?.isEmpty ?? true || userPassword?.isEmpty ?? true || userPassword2?.isEmpty ?? true) {
            displayAlertMessage(userMessage: "Please fill out all required fields.");
            
            return;
        }
        
        // check if passwords match
        
        // store data
        
        // display confirmation message
        
        
    }
    
    func displayAlertMessage(userMessage:String) {
        var myAlert = UIAlertController(title:"Alert", message:userMessage, preferredStyle: .alert);
//        var myAlert = UIAlertController(title:"Alert", message:userMessage, preferredStyle: UIAlertAction.Style);

        let okAction = UIAlertAction(title:"Ok", style: UIAlertAction.Style.default, handler:nil);
        
        myAlert.addAction(okAction);
        
        self.present(myAlert, animated: true);
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
