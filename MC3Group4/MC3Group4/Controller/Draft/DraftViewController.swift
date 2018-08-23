//
//  DraftViewController.swift
//  MC3Group4
//
//  Created by Resky Javieri on 16/08/18.
//  Copyright © 2018 Resky Javieri. All rights reserved.
//

import UIKit

class DraftViewController: UIViewController {
    
    var schoolName: String = ""
    var isNewDraft: Bool = false
    var currentDraft: PostModel!
    
    @IBAction func addDraftButton(_ sender: Any) {
        let draftAlert = UIAlertController(title: "Draft Baru", message: nil, preferredStyle: .alert)
        draftAlert.addTextField {
            $0.placeholder = "Nama sekolah"
            $0.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        }
        let submitAction = UIAlertAction(title: "Tambah", style: .default) { (UIAlertAction) in
            self.createNewDraft()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (UIAlertAction) in
        }
        submitAction.isEnabled = false
        draftAlert.addAction(submitAction)
        draftAlert.addAction(cancelAction)
        present(draftAlert, animated: true, completion: nil)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField){
        self.schoolName = textField.text!
        if let alert = presentedViewController as? UIAlertController,
        let submitAction = alert.actions.first,
            let text = textField.text{
            submitAction.isEnabled = (text != "")
        }
    }
    
    func createNewDraft(){
        self.isNewDraft = true
        performSegue(withIdentifier: "draftToDraftDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "draftToDraftDetail"{
            let destination = segue.destination as! DraftDetailViewController
            destination.isNewDraft = self.isNewDraft
            
            
        }
    }
    
        
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.isNewDraft = false
    }

   

}
