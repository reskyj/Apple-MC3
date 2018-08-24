import UIKit
import MapKit
import CoreLocation

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
    // temp variables for PostModel
//    var schoolName: String!
//    var about: String!
//    var needs: String!
//    var access: String!
//    var address: String!
//    var notes: String!
    
    
    // -----------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func setUpMap(){
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }
    
    @IBAction func editButtonClicked(_ sender: Any) {
        var textViewBG: UIColor!
        if (self.isCurrentlyEditing == false){
            textViewBG = UIColor(cgColor: #colorLiteral(red: 0.9537883997, green: 0.9537883997, blue: 0.9537883997, alpha: 1))
            self.isCurrentlyEditing = true
            self.tapToShareButton.isHidden = false
            self.detailDraftNavBar.rightBarButtonItem?.title = "Save"
        }
        else{
            textViewBG = UIColor.white
            self.isCurrentlyEditing = false
            self.tapToShareButton.isHidden = true
            self.detailDraftNavBar.rightBarButtonItem?.title = "Edit"
            
            if (self.isNewDraft == true){
                self.isNewDraft = false
                
                // save new draft to core data
            }
            else{
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
    }

    @IBAction func roadAddButtonClicked(_ sender: Any) {
        self.isPickingRoad = true
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func tapToShareButtonClicked(_ sender: Any) {
        self.setUpMap()
    }
}



extension DraftDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == self.schoolCollectionView){
            return self.currentDraft.schoolImages.count
        }
        return self.currentDraft.roadImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (collectionView == self.schoolCollectionView){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "schoolCell", for: indexPath) as! imagesCollectionCell
            cell.setCell(image: self.currentDraft.schoolImages[indexPath.row])
            
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "roadCell", for: indexPath) as! imagesCollectionCell
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
            }
        }
    }
}


extension DraftDetailViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation = locations[0]
        let span: MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
        let myLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(userLocation.coordinate.latitude, userLocation.coordinate.longitude)
        let region: MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
        self.myMapView.setRegion(region, animated: true)
        self.myMapView.showsUserLocation = true
        
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
            }
            
        }
    }
}







