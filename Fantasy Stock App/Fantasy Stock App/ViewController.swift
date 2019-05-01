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
    let email = Expression<String>("userEmail")
    let leagueId = Expression<Int>("leagueId")
    
    var userEmail = "";
    var currentLeagueId = -1;

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
        
        // database: create inLeague table
        let createInLeagueTable = self.inLeagueTable.create {
            (table) in
            table.column(self.email, primaryKey: true)
            table.column(self.leagueId, unique: false)
        }
        do {
            try self.db.run(createInLeagueTable)
            print("INLEAGUE TABLE CREATED")
        }
        catch {
            print(error)
        }
        
        
        // TESTING database: add mawang@davidson.edu to league table with leagueId 1
        let insertTuple = self.inLeagueTable.insert(self.email <- "mawang@davidson.edu", self.leagueId <- 336)
        do {
            
            // TODO ONLY INSERT USER IF USER NOT ALREADY IN DATABASE; IF YES, NOTIFY
            
            try self.db.run(insertTuple)
            print("TEST tuple inserted!")
        }
        catch {
            print(error)
        }
        
        
        // TESTING delete inLeagueTable
//        do {
//            try db.run(inLeagueTable.drop(ifExists: true))
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
        print("userEmail from UserDefaults: \(userEmail)")
        do {
            for row in try self.db.prepare(query) {
                currentLeagueId = row[leagueId]
            }
        } catch {print(error)}
        print("currentLeagueId from query: \(currentLeagueId)")
        
        // if currentLeagueId = -1 then not in league already
        // --> send to create or join league page
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
