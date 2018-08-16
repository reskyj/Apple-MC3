//
//  RegisterViewController.swift
//  MC3Group4
//
//  Created by Resky Javieri on 16/08/18.
//  Copyright © 2018 Resky Javieri. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet var secondRegisterButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.secondRegisterButton.backgroundColor = UIColor.init(red: 100/255, green: 171/255, blue: 255/255, alpha: 1)
        self.secondRegisterButton.layer.cornerRadius = secondRegisterButton.frame.height / 2
        self.secondRegisterButton.setTitleColor(UIColor.white, for: .normal)

       
    }

   
}
