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
    @IBOutlet var aboutTextView: UITextView!
    @IBOutlet var accessTextView: UITextView!
    @IBOutlet var needsTextView: UITextView!
    
    var schoolName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        
        
        schoolNameLabel.text = schoolName
        
        aboutTextView.text = "Placeholder"
        aboutTextView.textColor = UIColor.lightGray
        needsTextView.text = "Placeholder"
        needsTextView.textColor = UIColor.lightGray
        accessTextView.text = "Placeholder"
        accessTextView.textColor = UIColor.lightGray
        
        
        
        

    }

    func customInit(schoolName: String) {
        self.schoolName = schoolName
    }
    
   
    
  


}
