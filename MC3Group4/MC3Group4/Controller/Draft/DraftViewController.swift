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
        
        self.draftTableView.delegate = self
        self.draftTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.isNewDraft = false
        self.draftArray.removeAll()
        
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
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: x.schoolImages as! Data) as? NSArray{
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
            print("fetch successful")
            self.draftTableView.reloadData()
        } catch {}
    }
}


extension DraftViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.draftArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.draftTableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
        cell.fillCell(schoolName: self.draftArray[indexPath.row].schoolName, about: self.draftArray[indexPath.row].aboutPost)
        
        if (self.draftArray[indexPath.row].schoolImages.count > 0){
            cell.fillThumbnail(thumbnail: self.draftArray[indexPath.row].schoolImages[0])
        }
        
        var locationDesc: String = "Unspecified"
        
        if (self.draftArray[indexPath.row].locationLongitude != 0 && self.draftArray[indexPath.row].locationLatitude != 0){
            locationDesc = "\(self.draftArray[indexPath.row].locationLongitude), \(self.draftArray[indexPath.row].locationLatitude)"
        }
    
        if (self.draftArray[indexPath.row].locationLocality != ""){
            locationDesc = "\(self.draftArray[indexPath.row].locationLocality), \(self.draftArray[indexPath.row].locationAdminArea)"
        }
        
        cell.fillLocation(desc: locationDesc)
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.currentDraft = self.draftArray[indexPath.row]
        performSegue(withIdentifier: "draftToDraftDetail", sender: self)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.draftArray.remove(at: indexPath.row)
            
            let managedContext = LocalServices.persistentContainer.viewContext
            let node = self.tempResult[indexPath.row]
            managedContext.delete(node)
            
            do {
                try managedContext.save()
                
                self.draftTableView.deleteRows(at: [indexPath], with: .fade)
            } catch let error as NSError {
                print("Error While Deleting Note: \(error.userInfo)")
            }
        }
    }
    
    
}












   


