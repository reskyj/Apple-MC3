//
//  ProfileSettingsViewController.swift
//  MC3Group4
//
//  Created by Steven Muliamin on 23/08/18.
//  Copyright © 2018 Resky Javieri. All rights reserved.
//

import UIKit

class ProfileSettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    
    @IBAction func signOutButtonClicked() {
        LoggedInUser.isLoggedIn = false
        LoggedInUser.user = nil
        
        UserDefaultReference.udRef.set(false, forKey: "udLoggedIn")
        UserDefaultReference.udRef.set("", forKey: "udEmail")
        UserDefaultReference.udRef.set("", forKey: "udHashedPassword")
        UserDefaultReference.udRef.set("", forKey: "udUserUUID")
        
        self.navigationController?.popViewController(animated: true)
    }
    
}
