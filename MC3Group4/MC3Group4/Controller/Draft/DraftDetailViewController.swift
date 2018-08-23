//
//  DraftDetailViewController.swift
//  MC3Group4
//
//  Created by Resky Javieri on 21/08/18.
//  Copyright © 2018 Resky Javieri. All rights reserved.
//

import UIKit

@IBDesignable
class DraftDetailViewController: UIViewController {

    
    @IBOutlet weak var schoolNameLabel: UILabel!
    var schoolName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        schoolNameLabel.text = schoolName
        
        
    }
    
    func customInit(schoolName: String) {
        self.schoolName = schoolName
    }

}
