//
//  ViewController.swift
//  Fantasy Stock App
//
//  Created by Matt W on 4/8/19.
//  Copyright © 2019 Group 4. All rights reserved.
//

import UIKit
import SQLite

class ViewController: UIViewController {
    
    var db : Connection!
    
    let userTable = Table("users")
    let inLeagueTable = Table("inLeague")
    let email = Expression<Int>("userEmail")
    let leagueId = Expression<Int>("leagueId")
    
    var userEmail = "";

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

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
        
        // TESTING delete inLeagueTable
//        do {
//            try database.run(inLeagueTable.drop(ifExists: true))
//        }
//        catch {
//            print(error)
//        }
        
        //////////////////////////////////////////////////////////////////
        // SEGUE TO CREATE LEAGUE / JOIN LEAGUE PAGE IF USER NOT IN LEAGUE
        //////////////////////////////////////////////////////////////////
        
        // pass userEmail from login page
        userEmail =  UserDefaults.standard.string(forKey: "userEmail") ?? "empty"
        // query inLeague on userEmail
        let query = inLeagueTable.filter(userEmail == email);
        do {
            for row in try self.db.prepare(query) {
                currentUserEmail = row[email]
            }
        } catch {print(error)}
//        let query = inLeague.select(password).filter(userEmail == email);
        // if nothing comes up (if count of query is 0 or something), segue
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        // TESTING
//        UserDefaults.standard.set(false, forKey: "userLoggedIn");
//        UserDefaults.standard.synchronize();
        
        UserDefaults.standard.synchronize();
        let isLoggedIn = UserDefaults.standard.bool(forKey: "userLoggedIn");
        
        print("isLoggedIn: \(isLoggedIn)")

        if (isLoggedIn == false) {
            self.performSegue(withIdentifier: "loginView", sender: self);
        }
    }
    
    @IBAction func logoutButtonTapped(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "userLoggedIn");
        UserDefaults.standard.synchronize();

        self.performSegue(withIdentifier: "loginView", sender: self);
    }
}
