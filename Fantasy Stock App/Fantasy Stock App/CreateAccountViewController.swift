//
//  CreateAccountViewController.swift
//  Fantasy Stock App
//
//  Created by Matt W on 4/17/19.
//  Copyright © 2019 Group 4. All rights reserved.
//

import UIKit
import SQLite

class CreateAccountViewController: UIViewController {
    
    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    @IBOutlet weak var userRepeatPasswordTextField: UITextField!
    
    var database : Connection!
    
    let userTable = Table("users")
    let email = Expression<String>("email")
    let password = Expression<String>("password")
    let userId = Expression<Int>("id")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // DATABASE INITIALIZATION
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = documentDirectory.appendingPathExtension("users").appendingPathExtension("sqlite3")
            let database = try Connection(fileUrl.path)
            self.database = database
        }
        catch {
            print(error)
        }
        
        
        // TESTING delete userTable
//        do {
//            try database.run(userTable.drop(ifExists: true))
//        }
//        catch {
//            print(error)
//        }
        
    }
    
    @IBAction func createAccountButtonClicked(_ sender: Any) {
        let userEmail = userEmailTextField.text!;
        let userPassword = userPasswordTextField.text!;
        let userPassword2 = userRepeatPasswordTextField.text!;
        
        
        // check for empty fields
        if (userEmail.isEmpty ?? true || userPassword.isEmpty ?? true || userPassword2.isEmpty ?? true) {
            displayAlertMessage(userMessage: "Please fill out all required fields");
            
            return;
        }
        
        // send alert if passwords don't match
        else if (userPassword != userPassword2) {
            displayAlertMessage(userMessage: "Passwords don't match");
            
            return;
        }
        
        else {
            // database: create user table
            let createUserTable = self.userTable.create {
                (table) in
                table.column(self.userId, primaryKey: true)
                table.column(self.email, unique: true)
                table.column(self.password)
            }
            do {
                try self.database.run(createUserTable)
                print("USER TABLE CREATED")
            }
            catch {
                print(error)
            }
            
            
            // database: add new user
            let insertUser = self.userTable.insert(self.email <- userEmail, self.password <- userPassword)
            do {
                
                // TODO ONLY INSERT USER IF USER NOT ALREADY IN DATABASE; IF YES, NOTIFY
                
                try self.database.run(insertUser)
                print("User inserted!")
            }
            catch {
                print(error)
            }
            
            
            // TESTING: print users in database
            do {
                let users = try self.database.prepare(self.userTable)
                for user in users {
                    print("id: \(user[self.userId]), email: \(user[self.email]), password: \(user[self.password])")
                }
            }
            catch {
                print(error)
            }
            
            
            // display confirmation message
            displayAlertMessage(userMessage: "Registration successful!")
        }
    }
    
    func displayAlertMessage(userMessage:String) {
        let myAlert = UIAlertController(title:"Alert", message:userMessage, preferredStyle: .alert);

        let okAction = UIAlertAction(title:"Ok", style: UIAlertAction.Style.default, handler:nil);

        myAlert.addAction(okAction);

        self.present(myAlert, animated: true);
    }

}
