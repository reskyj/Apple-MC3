//
//  DraftViewController.swift
//  MC3Group4
//
//  Created by Resky Javieri on 16/08/18.
//  Copyright © 2018 Resky Javieri. All rights reserved.
//

import UIKit
import CoreData

class DraftViewController: UIViewController {
    
    @IBOutlet weak var draftTableView: UITableView!
    
    var schoolName: String = ""
    var isNewDraft: Bool = false
    var currentDraft: PostModel!
    
    var draftArray: [PostModel] = []
    var tempResult: [DraftEntity] = []
    
    @IBAction func addDraftButton(_ sender: Any) {
//        let draftAlert = UIAlertController(title: "Draft Baru", message: nil, preferredStyle: .alert)
//        draftAlert.addTextField {
//            $0.placeholder = "Nama sekolah"
//            $0.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
//        }
//        let submitAction = UIAlertAction(title: "Tambah", style: .default) { (UIAlertAction) in
//            self.createNewDraft()
//        }
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (UIAlertAction) in
//        }
//        submitAction.isEnabled = false
//        draftAlert.addAction(submitAction)
//        draftAlert.addAction(cancelAction)
//        present(draftAlert, animated: true, completion: nil)
        self.createNewDraft()
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
            
            if (self.isNewDraft == true){
                let tempUUID = UUID().uuidString
                self.currentDraft = PostModel(schoolImages: [], roadImages: [], schoolName: "", aboutPost: "", needsPost: "", addressPost: "", accessPost: "", notesPost: "", locationName: "", locationAdminArea: "", locationLocality: "", locationAOI: "", locationLatitude: 0, locationLongitude: 0, postUUID: tempUUID)
            }
            destination.currentDraft = self.currentDraft
        }
    }
    
        
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.isNewDraft = false
        
        self.fetchFromCoreData()
    }
    
    func fetchFromCoreData(){
        let fetchRequest: NSFetchRequest<DraftEntity> = DraftEntity.fetchRequest()
        do{
            let fetchData = try LocalServices.context.fetch(fetchRequest)
            self.tempResult = fetchData
        
            // x as each row in entity
            for x in self.tempResult{
                var tempSchool: [UIImage] = []
                var tempRoad: [UIImage] = []
                
                //get school images
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: x.schoolImages! as Data) as? NSArray{
                    for i in 0..<mySavedData.count{
                        let image = UIImage(data: mySavedData[i] as! Data)
                        tempSchool.append(image!)
                    }
                }
                //get road images
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: x.roadImages! as Data) as? NSArray{
                    for i in 0..<mySavedData.count{
                        let image = UIImage(data: mySavedData[i] as! Data)
                        tempRoad.append(image!)
                    }
                }
                
                self.draftArray.append(PostModel(schoolImages: tempSchool, roadImages: tempRoad, schoolName: x.schoolName!, aboutPost: x.aboutPost!, needsPost: x.needsPost!, addressPost: x.addressPost!, accessPost: x.accessPost!, notesPost: x.notesPost!, locationName: x.locationName!, locationAdminArea: x.locationAdminArea!, locationLocality: x.locationLocality!, locationAOI: x.locationAOI!, locationLatitude: x.locationLatitude, locationLongitude: x.locationLongitude, postUUID: x.postUUID!))
        
            }
        } catch {}
    }

}
   


