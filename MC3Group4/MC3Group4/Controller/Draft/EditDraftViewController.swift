//
//  EditDraftViewController.swift
//  MC3Group4
//
//  Created by Resky Javieri on 16/08/18.
//  Copyright © 2018 Resky Javieri. All rights reserved.
//

import UIKit

@IBDesignable
class EditDraftViewController: UIViewController {
    
    @IBOutlet weak var aboutTextView: UITextView!
    @IBOutlet weak var needsTextView: UITextView!
    @IBOutlet weak var accessTextView: UITextView!
    @IBOutlet weak var notesTextView: UITextView!
    
    var isNewDraft: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        aboutTextView.textViewDesign()
        needsTextView.textViewDesign()
        accessTextView.textViewDesign()
        notesTextView.textViewDesign()
    }
}
