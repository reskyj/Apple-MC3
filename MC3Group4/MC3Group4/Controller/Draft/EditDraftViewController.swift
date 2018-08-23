//
//  EditDraftViewController.swift
//  MC3Group4
//
//  Created by Steven Muliamin on 23/08/18.
//  Copyright © 2018 Resky Javieri. All rights reserved.
//

import Foundation
import UIKit

class EditDraftViewController: UIViewController {
    
    
    @IBOutlet weak var aboutTextView: UITextView!
    @IBOutlet weak var needsTextView: UITextView!
    @IBOutlet weak var accessTextView: UITextView!
    @IBOutlet weak var addressTextView: UITextView!
    
    var isNewDraft: Bool!
    var currentDraft: PostModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.aboutTextView.textViewDesign()
        self.needsTextView.textViewDesign()
        self.accessTextView.textViewDesign()
        self.addressTextView.textViewDesign()
    }
}
