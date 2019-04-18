//
//  LoginViewController.swift
//  Fantasy Stock App
//
//  Created by Matt W on 4/18/19.
//  Copyright © 2019 Group 4. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        let userEmail = userEmailTextField.text;
        let userPassword = userPasswordTextField.text;
        
        // QUERY DATABASE TO GET PASSWORD BASED ON USEREMAIL
        
        // IF PASSWORDS MATCH:
            // LOGIN SUCCESSFUL
        // ELSE:
            // ERROR MESSAGE
        
        // PLACEHOLDER CODE
        if (userPassword == "password") {
            UserDefaults.standard.set(true, forKey: "userLoggedIn");

            UserDefaults.standard.synchronize();

            self.dismiss(animated: true, completion: nil);
        }
        else {
            displayAlertMessage(userMessage: "Email/password invaild");
        }
        
    }
    
    func displayAlertMessage(userMessage:String) {
        var myAlert = UIAlertController(title:"Alert", message:userMessage, preferredStyle: .alert);
        
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
