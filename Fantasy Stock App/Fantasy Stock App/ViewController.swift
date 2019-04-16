//
//  ViewController.swift
//  Fantasy Stock App
//
//  Created by Matt W on 4/8/19.
//  Copyright © 2019 Group 4. All rights reserved.
//

import UIKit
//import MongoKitten

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.performSegue(withIdentifier: "loginView", sender: self);
    }

//    print("Testing MongoKitten")
    
//    let server = try Server("mongodb://localhost")
//    let database = server["mydatabasename"]
//    let database = try Database("mongodb://localhost/mydatabasename")
//
//    if database.server.isConnected {
//        print("Successfully connected!")
//    } else {
//        print("Connection failed")
//    }

}

