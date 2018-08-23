//
//  DraftDetailViewController.swift
//  MC3Group4
//
//  Created by Resky Javieri on 21/08/18.
//  Copyright © 2018 Resky Javieri. All rights reserved.
//

import UIKit

class DraftDetailViewController: UIViewController {

    
    @IBOutlet weak var schoolNameLabel: UILabel!
    @IBOutlet weak var aboutLabel: UILabel!
    @IBOutlet weak var needsLabel: UILabel!
    @IBOutlet weak var accessLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var notesLabel: UILabel!
    
    
    var isNewDraft: Bool!
    var currentDraft: PostModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (self.isNewDraft == true){
            performSegue(withIdentifier: "DraftDetailToEditDraft", sender: self)
        }
        else{
            // masukin info2 draft detail
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DraftDetailToEditDraft"{
            let destination = segue.destination as! EditDraftViewController
            destination.isNewDraft = self.isNewDraft
        }
    }
    
}
