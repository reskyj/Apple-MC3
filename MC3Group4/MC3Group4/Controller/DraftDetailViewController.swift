//
//  DraftDetailViewController.swift
//  MC3Group4
//
//  Created by Resky Javieri on 16/08/18.
//  Copyright © 2018 Resky Javieri. All rights reserved.
//

import UIKit

class DraftDetailViewController: UIViewController {

    @IBOutlet var schoolNameLabel: UILabel!
    
    var schoolName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        schoolNameLabel.text = schoolName

    }

    func customInit(schoolName: String) {
        self.schoolName = schoolName
    }
    


}
