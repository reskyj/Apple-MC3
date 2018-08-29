//
//  DiscoverDetailViewController.swift
//  MC3Group4
//
//  Created by Resky Javieri on 23/08/18.
//  Copyright © 2018 Resky Javieri. All rights reserved.
//

//    @IBOutlet weak var pageControl: UIPageControl!
//    @IBOutlet weak var scrollView: UIScrollView!
//
//    var images: [String] = ["Gambar-1", "Gambar-2"]
//    var frame = CGRect(x: 0, y: 0, width: 0, height: 0)
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        pageControl.numberOfPages = images.count
//        for index in 0..<images.count {
//            frame.origin.x = scrollView.frame.size.width * CGFloat(index)
//            frame.size = scrollView.frame.size
//
//            let imageView = UIImageView(frame: frame)
//            imageView.image = UIImage(named: images[index])
//            self.scrollView.addSubview(imageView)
//        }
//        scrollView.contentSize = CGSize(width: scrollView.frame.size.width * CGFloat(images.count), height: scrollView.frame.size.height)
//        scrollView.delegate = self
//
//
//    }
//
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        var pageNumber = scrollView.contentOffset.x / scrollView.frame.size.width
//        pageControl.currentPage = Int(pageNumber)
//    }
//

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
    
    
    var currentPost: PostModel!
    var slideShowImages: [ImageSource] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.fillDetails()
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
    
    
}

























