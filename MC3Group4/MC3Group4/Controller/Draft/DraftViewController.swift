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
        performSegue(withIdentifier: "draftToEditDraft", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "draftToEditDraft"{
            let destination = segue.destination as! EditDraftViewController
            destination.isNewDraft = self.isNewDraft
        
            let tempUUID = UUID().uuidString
            destination.currentDraft = PostModel(schoolImages: [], roadImages: [], schoolName: self.schoolName, aboutPost: "", needsPost: "", addressPost: "", accessPost: "", notesPost: "", locationName: "", locationAdminArea: "", locationLocality: "", locationAOI: "", locationLatitude: 0, locationLongitude: 0, postUUID: tempUUID)
        }
    }
    
        
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.isNewDraft = false
    }

   

}
