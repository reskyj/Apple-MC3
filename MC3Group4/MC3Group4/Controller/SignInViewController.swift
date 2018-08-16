//
//  SignInViewController.swift
//  MC3Group4
//
//  Created by Resky Javieri on 16/08/18.
//  Copyright © 2018 Resky Javieri. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {

    var x: Int = 10
    
    @IBOutlet var secondSignInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.secondSignInButton.backgroundColor = UIColor.init(red: 100/255, green: 171/255, blue: 255/255, alpha: 1)
        self.secondSignInButton.layer.cornerRadius = secondSignInButton.frame.height / 2
        self.secondSignInButton.setTitleColor(UIColor.white, for: .normal)


    }

   

}
