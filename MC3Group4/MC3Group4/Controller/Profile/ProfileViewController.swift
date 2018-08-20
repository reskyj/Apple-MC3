//
//  ProfileViewController.swift
//  MC3Group4
//
//  Created by Resky Javieri on 16/08/18.
//  Copyright © 2018 Resky Javieri. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    

    @IBOutlet var registerButton: UIButton!
    @IBOutlet var signInButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.signInButton.buttonDesignOne()
        self.registerButton.buttonDesignTwo()
        

        
        
    }

    
    @IBAction func signInButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "profileToSignIn", sender: self)
    }

    @IBAction func registerButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "profileToRegister", sender: self)
    }
    
}















