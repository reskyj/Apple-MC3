import UIKit
import MapKit
import CoreLocation
import CoreData

class DraftDetailViewController: UIViewController {
    
    
    @IBOutlet weak var detailDraftNavBar: UINavigationItem!
    
    
    @IBOutlet weak var schoolCollectionView: UICollectionView!
    @IBOutlet weak var roadCollectionView: UICollectionView!
    
    
    @IBOutlet weak var schoolNameTextView: UITextView!
    @IBOutlet weak var aboutTextView: UITextView!
    @IBOutlet weak var needsTextView: UITextView!
    @IBOutlet weak var accessTextView: UITextView!
    @IBOutlet weak var addressTextView: UITextView!
    @IBOutlet weak var notesTextView: UITextView!
    
    @IBOutlet weak var tapToShareButton: UIButton!
    @IBOutlet weak var myMapView: MKMapView!
    
    
    var isNewDraft: Bool!
    var currentDraft: PostModel!
    var isPickingSchool: Bool = false
    var isPickingRoad: Bool = false
    var isCurrentlyEditing: Bool = false
    
    let locationManager = CLLocationManager()
    var locationUpdateCounter: Int = 0
    
    var tempLocLongitude: Double = 0
    var tempLocLatitude: Double = 0
    var tempLocAOI: String = ""
    var tempLocAdminArea: String = ""
    var tempLocLocality: String = ""
    var tempLocName: String = ""
    
    
    @IBOutlet weak var openMaps: UIButton!
    @IBOutlet weak var submitToPublic: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tapToShareButton.buttonDesignTwo()
        self.tapToShareButton.buttonDesignDisabled()
        self.openMaps.buttonDesignTwo()
        self.submitToPublic.buttonDesignOne()
        self.submitToPublic.buttonDesignDisabled()
        
        
        self.setInitialLoad()
    }
    
    func setInitialLoad(){
        self.schoolNameTextView.text = self.currentDraft.schoolName
        self.aboutTextView.text = self.currentDraft.aboutPost
        self.needsTextView.text = self.currentDraft.needsPost
        self.accessTextView.text = self.currentDraft.accessPost
        self.addressTextView.text = self.currentDraft.addressPost
        self.notesTextView.text = self.currentDraft.notesPost
        
        if (self.currentDraft.locationLatitude != 0 && self.currentDraft.locationLongitude != 0){
            let tempLoc = CLLocation(latitude: self.currentDraft.locationLatitude, longitude: self.currentDraft.locationLongitude)
            self.setLocationOnMap(userLocation: tempLoc)
        }
        
        if (self.isNewDraft == true){
            self.changeEditState()
        }
    }
    
    
    func saveNewDraftToCoreData(){
        let tempPost = DraftEntity(context: LocalServices.context)
        tempPost.schoolName = self.currentDraft.schoolName
        tempPost.aboutPost = self.currentDraft.aboutPost
        tempPost.needsPost = self.currentDraft.needsPost
        tempPost.accessPost = self.currentDraft.accessPost
        tempPost.addressPost = self.currentDraft.addressPost
        tempPost.notesPost = self.currentDraft.notesPost
        tempPost.locationLongitude = self.currentDraft.locationLongitude
        tempPost.locationLatitude = self.currentDraft.locationLatitude
        tempPost.postUUID = self.currentDraft.postUUID
        
        tempPost.locationAOI = self.currentDraft.locationAOI
        tempPost.locationName = self.currentDraft.locationName
        tempPost.locationLocality = self.currentDraft.locationLocality
        tempPost.locationAdminArea = self.currentDraft.locationAdminArea
        
        var CDataArraySchool = NSMutableArray()
        var CDataArrayRoad = NSMutableArray()
        
        for img in self.currentDraft.schoolImages{
            let data : NSData = NSData(data: UIImageJPEGRepresentation(img, 1)!)
            CDataArraySchool.add(data)
        }
        
        for img in self.currentDraft.roadImages{
            let data : NSData = NSData(data: UIImageJPEGRepresentation(img, 1)!)
            CDataArrayRoad.add(data)
        }
        
        //convert the Array to NSData
        //you can save this in core data
        let coreDataObjectSchool = NSKeyedArchiver.archivedData(withRootObject: CDataArraySchool)
        let coreDataObjectRoad = NSKeyedArchiver.archivedData(withRootObject: CDataArrayRoad)

        tempPost.schoolImages = coreDataObjectSchool as NSData
        tempPost.roadImages = coreDataObjectRoad as NSData
        
        LocalServices.saveContext()
    }
    
    func updateToCoreData(){
        let context = LocalServices.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<DraftEntity> = DraftEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "postUUID = %@", self.currentDraft.postUUID)
        
        do {
            let results = try context.fetch(fetchRequest)
            fetchRequest.returnsObjectsAsFaults = false
            print("Results Count :", results.count)
            
            if(results.count > 0 ){
                
                var CDataArraySchool = NSMutableArray()
                var CDataArrayRoad = NSMutableArray()
                
                for img in self.currentDraft.schoolImages{
                    let data : NSData = NSData(data: UIImageJPEGRepresentation(img, 1)!)
                    CDataArraySchool.add(data)
                }
                
                for img in self.currentDraft.roadImages{
                    let data : NSData = NSData(data: UIImageJPEGRepresentation(img, 1)!)
                    CDataArrayRoad.add(data)
                }
                
                //convert the Array to NSData
                //you can save this in core data
                let coreDataObjectSchool = NSKeyedArchiver.archivedData(withRootObject: CDataArraySchool)
                let coreDataObjectRoad = NSKeyedArchiver.archivedData(withRootObject: CDataArrayRoad)
                
                
                results[0].setValue(coreDataObjectSchool, forKey: "schoolImages")
                results[0].setValue(coreDataObjectRoad, forKey: "roadImages")
                
                results[0].setValue(self.currentDraft.schoolName, forKey: "schoolName")
                results[0].setValue(self.currentDraft.aboutPost, forKey: "aboutPost")
                results[0].setValue(self.currentDraft.needsPost, forKey: "needsPost")
                results[0].setValue(self.currentDraft.accessPost, forKey: "accessPost")
                results[0].setValue(self.currentDraft.addressPost, forKey: "addressPost")
                results[0].setValue(self.currentDraft.notesPost, forKey: "notesPost")
                results[0].setValue(self.currentDraft.locationLongitude, forKey: "locationLongitude")
                results[0].setValue(self.currentDraft.locationLatitude, forKey: "locationLatitude")
                
                results[0].setValue(self.currentDraft.locationAOI, forKey: "locationAOI")
                results[0].setValue(self.currentDraft.locationName, forKey: "locationName")
                results[0].setValue(self.currentDraft.locationLocality, forKey: "locationLocality")
                results[0].setValue(self.currentDraft.locationAdminArea, forKey: "locationAdminArea")
                
                try context.save();
                print("Saved.....")
                //                } endfor
            } else {
                print("No Audios to save")
            }
        } catch{
            print("There was an error")
        }
    
    }

    func setUpMap(){
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }
    
    @IBAction func editButtonClicked(_ sender: Any) {
        self.changeEditState()
    }
    
    func changeEditState(){
        var textViewBG: UIColor!
        if (self.isCurrentlyEditing == false){
            textViewBG = UIColor(cgColor: #colorLiteral(red: 0.9537883997, green: 0.9537883997, blue: 0.9537883997, alpha: 1))
            self.isCurrentlyEditing = true
            self.detailDraftNavBar.rightBarButtonItem?.title = "Save"
            
            self.tapToShareButton.isEnabled = true
            self.tapToShareButton.buttonDesignTwo()
            
            self.submitToPublic.buttonDesignDisabled()
            self.submitToPublic.isEnabled = false
        }
        else{
            textViewBG = UIColor.white
            self.isCurrentlyEditing = false
            self.tapToShareButton.isEnabled = false
            self.tapToShareButton.buttonDesignDisabled()
            self.detailDraftNavBar.rightBarButtonItem?.title = "Edit"
            self.submitToPublic.buttonDesignOne()
            self.submitToPublic.isEnabled = true
            
            self.currentDraft.schoolName = self.schoolNameTextView.text
            self.currentDraft.aboutPost = self.aboutTextView.text
            self.currentDraft.needsPost = self.needsTextView.text
            self.currentDraft.accessPost = self.accessTextView.text
            self.currentDraft.addressPost = self.addressTextView.text
            self.currentDraft.notesPost = self.notesTextView.text
            
            self.currentDraft.locationLongitude = self.tempLocLongitude
            self.currentDraft.locationLatitude = self.tempLocLatitude
            
            self.currentDraft.locationAdminArea = self.tempLocAdminArea
            self.currentDraft.locationAOI = self.tempLocAOI
            self.currentDraft.locationName = self.tempLocName
            self.currentDraft.locationLocality = self.tempLocLocality
            
            
            if (self.isNewDraft == true){
                self.isNewDraft = false
                
                self.saveNewDraftToCoreData()
                // save new draft to core data
            }
            else{
                self.updateToCoreData()
                // update edited draft to core data
            }
        }
        
        self.schoolNameTextView.isEditable = self.isCurrentlyEditing
        self.aboutTextView.isEditable = self.isCurrentlyEditing
        self.needsTextView.isEditable = self.isCurrentlyEditing
        self.accessTextView.isEditable = self.isCurrentlyEditing
        self.addressTextView.isEditable = self.isCurrentlyEditing
        self.notesTextView.isEditable = self.isCurrentlyEditing
        
        UIView.animate(withDuration: 0.35, delay: 0, options: UIViewAnimationOptions.allowUserInteraction, animations: {
            self.schoolNameTextView.backgroundColor = textViewBG
            self.aboutTextView.backgroundColor = textViewBG
            self.needsTextView.backgroundColor = textViewBG
            self.accessTextView.backgroundColor = textViewBG
            self.addressTextView.backgroundColor = textViewBG
            self.notesTextView.backgroundColor = textViewBG
        }) { (finished) in
            // after finish
        }
    }
    
    @IBAction func schoolAddButtonClicked(_ sender: Any) {
        self.isPickingSchool = true
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        self.present(imagePicker, animated: true, completion: nil)
        
        if (self.isCurrentlyEditing == false){
            self.changeEditState()
        }
    }

    @IBAction func roadAddButtonClicked(_ sender: Any) {
        self.isPickingRoad = true
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        self.present(imagePicker, animated: true, completion: nil)
        
        if (self.isCurrentlyEditing == false){
            self.changeEditState()
        }
    }
    
    @IBAction func tapToShareButtonClicked(_ sender: Any) {
        self.setUpMap()
    }
    
    
    @IBAction func submitButtonClicked(_ sender: Any) {
        if (self.schoolNameTextView.text == "" || self.aboutTextView.text == "" || self.needsTextView.text == "" || self.accessTextView.text == "" || self.addressTextView.text == "" || self.notesTextView.text == ""){
            
            let alert = UIAlertController(title: "Unable to Submit", message: "Please fill in the fields!", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
            }
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
        else if (self.currentDraft.locationLongitude == 0 || self.currentDraft.locationLatitude == 0 ){
            let alert = UIAlertController(title: "Unable to Submit", message: "Location not set!", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
            }
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
        else if (self.currentDraft.schoolImages.count < 1){
            let alert = UIAlertController(title: "Unable to Submit", message: "Please include at least 1 school and road image!", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
            }
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
        else if (LoggedInUser.isLoggedIn == false){
            let alert = UIAlertController(title: "Unable to Submit", message: "You must be logged in to submit!", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
            }
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
        else{
            self.submitToFirebase()
        }
    }
    
    var tempFirebasePost: FirebasePostModel!
    var tempSchoolPicIds: [String:String] = [:]
    var tempRoadPicIds: [String:String] = [:]
    var postDateID: String = ""
    var dateString: String = ""
    var FirebaseStorageFlag: Int = 0{
        didSet{
            if (self.FirebaseStorageFlag == 2){
                self.tempFirebasePost = FirebasePostModel(schoolName: self.currentDraft.schoolName, about: self.currentDraft.aboutPost, needs: self.currentDraft.needsPost, access: self.currentDraft.accessPost, address: self.currentDraft.addressPost, notes: self.currentDraft.notesPost, schoolImages: self.tempSchoolPicIds, roadImages: self.tempRoadPicIds, locationName: self.currentDraft.locationName, locationAdminArea: self.currentDraft.locationAdminArea, locationLocality: self.currentDraft.locationLocality, locationAOI: self.currentDraft.locationAOI, locationLatitude: self.currentDraft.locationLatitude, locationLongitude: self.currentDraft.locationLongitude, postUUID: self.postDateID, posterID: LoggedInUser.user.userUUID, timeStamp: self.dateString)
                
                FirebaseReferences.databaseRef.child("Posts/\(self.postDateID)").setValue(self.tempFirebasePost.dataModel)
                
                self.FirebaseStorageFlag = 0
                
                let alert = UIAlertController(title: "Success", message: "Your draft has been submitted!", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
                    self.navigationController?.popViewController(animated: true)
                }
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
                
            }
        }
    }
    
    
    
    func submitToFirebase(){
        let currDate = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd-HH:mm:ss"
        self.dateString = formatter.string(from: currDate)
        self.postDateID = "\(self.dateString)-\(self.currentDraft.postUUID)"
        
        FirebaseReferences.databaseRef.child("Users/\(LoggedInUser.user.userUUID)/posts/\(self.postDateID)").setValue("")
        
        for picIndex in 0..<self.currentDraft.schoolImages.count{
            let tempPicId = "pic-\(UUID().uuidString)"
            
            let data = UIImageJPEGRepresentation(self.currentDraft.schoolImages[picIndex], 0.1)
            let tempRef = FirebaseReferences.storageRef.child("Posts/\(self.postDateID)/schoolImages/\(tempPicId).jpeg")
            
            let _ = tempRef.putData(data!, metadata: nil) { (metadata, error) in
                if error != nil{
                    print("ERROR - \(error?.localizedDescription)")
                    return
                }
                print("success upload to storage")
                            // You can also access to download URL after upload.
                tempRef.downloadURL { (url, error) in
                    guard let downloadURL = url else {
                        // Uh-oh, an error occurred!
                        return
                    }
                    self.tempSchoolPicIds[tempPicId] = downloadURL.absoluteString
                    if (picIndex == self.currentDraft.schoolImages.count-1){
                        self.FirebaseStorageFlag = self.FirebaseStorageFlag + 1
                    }

                }
            }
        }
        for picIndex in 0..<self.currentDraft.roadImages.count{
            let tempPicId = "pic-\(UUID().uuidString)"
            
            let data = UIImageJPEGRepresentation(self.currentDraft.roadImages[picIndex], 0.1)
            let tempRef = FirebaseReferences.storageRef.child("Posts/\(self.postDateID)/roadImages/\(tempPicId).jpeg")
            
            let _ = tempRef.putData(data!, metadata: nil) { (metadata, error) in
                if error != nil{
                    print("ERROR - \(error?.localizedDescription)")
                    return
                }
                print("success upload to storage")
                // You can also access to download URL after upload.
                tempRef.downloadURL { (url, error) in
                    guard let downloadURL = url else {
                        // Uh-oh, an error occurred!
                        return
                    }
                    self.tempRoadPicIds[tempPicId] = downloadURL.absoluteString
                    if (picIndex == self.currentDraft.roadImages.count-1){
                        self.FirebaseStorageFlag = self.FirebaseStorageFlag + 1
                    }

                }
            }
        }
        print("submitted draft to public")
    }
    
    
    @IBAction func openMapsButtonClicked(_ sender: Any) {
        // Open in Apple Maps
        let url = "http://maps.apple.com/maps?saddr=&daddr=\(self.currentDraft.locationLatitude),\(self.currentDraft.locationLongitude)"
        if UIApplication.shared.canOpenURL(NSURL(string: url)! as URL) {
            UIApplication.shared.openURL(URL(string:url)!)
        }
        else {
            let alert = UIAlertController(title: "Error", message: "Please Install Apple Maps", preferredStyle: UIAlertControllerStyle.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
            alert.addAction(okButton)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
}



extension DraftDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == self.schoolCollectionView){
            return self.currentDraft.schoolImages.count
        } else {
            return self.currentDraft.roadImages.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (collectionView == self.schoolCollectionView){
            let cell = self.schoolCollectionView.dequeueReusableCell(withReuseIdentifier: "schoolCell", for: indexPath) as! imagesCollectionCell
            cell.setCell(image: self.currentDraft.schoolImages[indexPath.row])
            
            return cell
        }
        
        let cell = self.roadCollectionView.dequeueReusableCell(withReuseIdentifier: "roadCell", for: indexPath) as! imagesCollectionCell
        cell.setCell(image: self.currentDraft.roadImages[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        var footerIdentifier: String = ""
        
        if (collectionView == self.schoolCollectionView){
            footerIdentifier = "schoolFooter"
        }
        else if (collectionView == self.roadCollectionView){
            footerIdentifier = "roadFooter"
        }
        
        let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footerIdentifier, for: indexPath)
        
        return footerView
    }
}


extension DraftDetailViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            picker.dismiss(animated: true, completion: nil)
            
            if (self.isPickingSchool == true){
                self.isPickingSchool = false
                self.currentDraft.schoolImages.append(image)
                let indexPath = IndexPath(row:self.currentDraft.schoolImages.count-1, section: 0) //at some index
                self.schoolCollectionView.insertItems(at: [indexPath])
            }
            else{
                self.isPickingRoad = false
                self.currentDraft.roadImages.append(image)
                let indexPath = IndexPath(row:self.currentDraft.roadImages.count-1, section: 0) //at some index
                self.roadCollectionView.insertItems(at: [indexPath])
            }
        }
    }
}


extension DraftDetailViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation = locations[0]
        self.setLocationOnMap(userLocation: userLocation)
        
        print(userLocation.coordinate.longitude)
        print(userLocation.coordinate.latitude)
        print("Coordinates saved")
        
        self.tempLocLongitude = userLocation.coordinate.longitude
        self.tempLocLatitude = userLocation.coordinate.latitude
        
        CLGeocoder().reverseGeocodeLocation(userLocation) { (placemark, error) in
            if self.locationUpdateCounter == 0
            {
                if error != nil
                {
                    // Kalo offline
                }
                else
                {
                    // Kalo online
                    if let place = placemark?[0]
                    {
                        print(userLocation.coordinate.latitude)
                        print(userLocation.coordinate.longitude)
                        print(place.locality!)
                        print(place.administrativeArea!)
                        print(place.name!)
                        print(place.areasOfInterest![0])
                        print(place.country!)
                        
                        self.tempLocLocality = place.locality!
                        self.tempLocAOI = place.areasOfInterest![0]
                        self.tempLocName = place.name!
                        self.tempLocAdminArea = place.administrativeArea!
                    }
                    else
                    {
                        // Gagal Pinpoint location
                    }
                }
                self.locationUpdateCounter += 1
            }
            else
            {
                self.locationManager.stopUpdatingLocation()
                self.locationUpdateCounter = 0
            }
            
        }
    }
    
    func setLocationOnMap(userLocation: CLLocation){
        let span: MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
        let myLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(userLocation.coordinate.latitude, userLocation.coordinate.longitude)
        let region: MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
        self.myMapView.setRegion(region, animated: true)
        self.myMapView.showsUserLocation = true
    }
}







