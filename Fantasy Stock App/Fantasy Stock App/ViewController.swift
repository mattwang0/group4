//
//  ViewController.swift
//  Fantasy Stock App
//
//  Created by Matt W on 4/8/19.
//  Copyright © 2019 Group 4. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        // TESTING
//        UserDefaults.standard.set(false, forKey: "userLoggedIn");
//        UserDefaults.standard.synchronize();
        
        UserDefaults.standard.synchronize();
        let isLoggedIn = UserDefaults.standard.bool(forKey: "userLoggedIn");

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
