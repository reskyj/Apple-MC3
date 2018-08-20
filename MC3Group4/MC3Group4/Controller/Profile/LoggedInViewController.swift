//
//  LoggedInViewController.swift
//  MC3Group4
//
//  Created by Steven Muliamin on 20/08/18.
//  Copyright © 2018 Resky Javieri. All rights reserved.
//

import UIKit

class LoggedInViewController: UIViewController {

    @IBOutlet weak var fullNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if (LoggedInUser.isLoggedIn == false){
            performSegue(withIdentifier: "LoggedInToProfile", sender: self)
        }
        else{
            self.fullNameLabel.text = LoggedInUser.user.fullName
        }
    }

}
