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
        
        self.setUpButtons()
//        self.navigationController?.isNavigationBarHidden = true
        
        
    }

    func setUpButtons(){
        self.signInButton.backgroundColor = UIColor.init(red: 100/255, green: 171/255, blue: 255/255, alpha: 1)
        self.signInButton.layer.cornerRadius = signInButton.frame.height / 2
        self.signInButton.setTitleColor(UIColor.white, for: .normal)
        
        self.registerButton.layer.borderWidth = 1
        self.registerButton.layer.borderColor = UIColor.init(red: 100/255, green: 171/255, blue: 255/255, alpha: 1).cgColor
        self.registerButton.layer.cornerRadius = registerButton.frame.height / 2
        self.registerButton.setTitleColor(UIColor.init(red: 100/255, green: 171/255, blue: 255/255, alpha: 1), for: .normal)
    }
    
    @IBAction func signInButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "profileToSignIn", sender: self)
    }

    @IBAction func registerButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "profileToRegister", sender: self)
    }
    
}
