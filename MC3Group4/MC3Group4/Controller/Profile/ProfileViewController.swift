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
        
//        self.navigationController?.isNavigationBarHidden = true
//        self.navigationController?.hidesBarsOnSwipe = true
        
        
    }

    
    @IBAction func signInButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "profileToSignIn", sender: self)
    }

    @IBAction func registerButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "profileToRegister", sender: self)
    }
    
}


extension UIButton {
    func buttonDesignOne(){
        self.backgroundColor = UIColor.init(red: 100/255, green: 171/255, blue: 255/255, alpha: 1)
        self.layer.cornerRadius = self.frame.height / 2
        self.setTitleColor(UIColor.white, for: .normal)
    }
    
    func buttonDesignTwo(){
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.init(red: 100/255, green: 171/255, blue: 255/255, alpha: 1).cgColor
        self.layer.cornerRadius = self.frame.height / 2
        self.setTitleColor(UIColor.init(red: 100/255, green: 171/255, blue: 255/255, alpha: 1), for: .normal)
    }
}












