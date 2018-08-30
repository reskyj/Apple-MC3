
import UIKit
import ImageSlideshow
import MapKit
import GoogleMaps

class DiscoverDetailViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var imageSlider: ImageSlideshow!
    
    @IBOutlet weak var aboutLabel: UILabel!
    @IBOutlet weak var needsLabel: UILabel!
    @IBOutlet weak var accessLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var notesLabel: UILabel!
    
    @IBOutlet weak var myMapView: MKMapView!
    
    @IBOutlet weak var openMapsButton: UIButton!
    
    var currentPost: PostModel!
    var slideShowImages: [ImageSource] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.openMapsButton.buttonDesignTwo()
        self.fillDetails()
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.didTap))
        self.imageSlider.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func didTap() {
        self.imageSlider.presentFullScreenController(from: self)
    }
    
    func fillDetails(){
        self.aboutLabel.text = self.currentPost.aboutPost
        self.needsLabel.text = self.currentPost.needsPost
        self.accessLabel.text = self.currentPost.accessPost
        self.addressLabel.text = self.currentPost.addressPost
        self.notesLabel.text = self.currentPost.notesPost
        
        for x in self.currentPost.schoolImages{
            self.slideShowImages.append(ImageSource(image: x))
        }
        for x in self.currentPost.roadImages{
            self.slideShowImages.append(ImageSource(image: x))
        }
        
        self.imageSlider.slideshowInterval = 0
        self.imageSlider.circular = false
        self.imageSlider.zoomEnabled = true
        self.imageSlider.pageIndicatorPosition = .init(horizontal: .center, vertical: .under)
        self.imageSlider.contentScaleMode = UIViewContentMode.scaleAspectFill
        
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = UIColor.black
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        
        self.imageSlider.pageIndicator = pageControl
        self.imageSlider.setImageInputs(self.slideShowImages)
        
        let tempLoc = CLLocation(latitude: self.currentPost.locationLatitude, longitude: self.currentPost.locationLongitude)
        self.setLocationOnMap(userLocation: tempLoc)
    }
    
    
    func setLocationOnMap(userLocation: CLLocation){
        let span: MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
        let myLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(userLocation.coordinate.latitude, userLocation.coordinate.longitude)
        let region: MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
        self.myMapView.setRegion(region, animated: true)
        self.myMapView.showsUserLocation = true
    }
    
    @IBAction func openMapsButtonClicked(_ sender: Any) {
        let url = "http://maps.apple.com/maps?saddr=&daddr=\(self.currentPost.locationLatitude),\(self.currentPost.locationLongitude)"
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

























