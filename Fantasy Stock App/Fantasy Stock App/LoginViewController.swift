//
//  LoginViewController.swift
//  Fantasy Stock App
//
//  Created by Matt W on 4/18/19.
//  Copyright © 2019 Group 4. All rights reserved.
//

import UIKit
import SQLite

class LoginViewController: UIViewController {

    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    
    var db : Connection!
    
    let userTable = Table("users")
    let email = Expression<String>("email")
    let password = Expression<String>("password")
    let userId = Expression<String>("id")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // DATABASE INITIALIZATION
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = documentDirectory.appendingPathExtension("users").appendingPathExtension("sqlite3")
            let database = try Connection(fileUrl.path)
            self.db = database
        }
        catch {
            print(error)
        }
    }
    
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        let userEmail = userEmailTextField.text!;
        let userPassword = userPasswordTextField.text!;
        
        var correctPassword = "";
        var currentUserEmail = ""
        
        // get correct password based on userEmail
        let query = userTable.select(password).filter(userEmail == email);
        do {
            for row in try self.db.prepare(query) {
                correctPassword = row[password]
            }
        }
        catch {
            print(error)
        }
        
        print("CORRECT PASS: " + correctPassword)
        
        // see if passwords match #111
        if (correctPassword == userPassword && userPassword != "") {
            print("PASSWORD IS CORRECT")
            UserDefaults.standard.set(true, forKey: "userLoggedIn");
            
            // query userEmail and save to UserDefaults
            let query = userTable.filter(userEmail==email);
            do {
                for row in try self.db.prepare(query) {
                    currentUserEmail = row[email]
                }
            } catch {print(error)}
            print("currentUserEmail: \(currentUserEmail)");
            UserDefaults.standard.set(currentUserEmail, forKey: "userEmail");
            
            UserDefaults.standard.synchronize();
            self.performSegue(withIdentifier: "loginToMainSegue", sender: nil);
        }
        else {
            displayAlertMessage(userMessage: "Email/password invaild");
        }
    }
    
    func displayAlertMessage(userMessage:String) {
        let myAlert = UIAlertController(title:"Alert", message:userMessage, preferredStyle: .alert);
        
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
