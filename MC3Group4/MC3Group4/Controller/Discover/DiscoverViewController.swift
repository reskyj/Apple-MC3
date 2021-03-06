//
//  DiscoverViewController.swift
//  MC3Group4
//
//  Created by Steven Muliamin on 19/08/18.
//  Copyright © 2018 Resky Javieri. All rights reserved.
//


struct FirebaseReferences {
    static let databaseRef: DatabaseReference = Database.database().reference()
    static let storageRef: StorageReference = Storage.storage().reference()
}

struct LoggedInUser {
    static var isLoggedIn: Bool = false
    static var user: UserModel!
}

struct UserDefaultReference {
    static let udRef = UserDefaults.standard
}

import UIKit
import Firebase
import CoreData
import UserNotifications

class DiscoverViewController: UIViewController {
    
    @IBOutlet weak var postTableView: UITableView!
    @IBOutlet weak var newPostButton: UIButton!
    @IBOutlet weak var myShimmerView: UIView!
    
    var postArray: [PostModel] = []
    var lastKey: String = ""
    var getLast: Int = 0
    
    var selectedPostIndex: Int!
    
    var initialChildrenCount: Int = 0
    
    var seenPostDict: [String:Bool] = [:]
    var unseenPostNo: Int = 0{
        didSet{
            if (self.unseenPostNo != 0){
                if let tabItems = self.tabBarController?.tabBar.items as NSArray!
                {
                    // In this case we want to modify the badge number of the third tab:
                    let tabItem = tabItems[0] as! UITabBarItem
                    tabItem.badgeValue = "\(self.unseenPostNo)"
                }
                let application = UIApplication.shared
                let center = UNUserNotificationCenter.current()
                center.requestAuthorization(options:[.badge, .alert, .sound]) { (granted, error) in
                    // Enable or disable features based on authorization.
                }
                application.registerForRemoteNotifications()
                application.applicationIconBadgeNumber = self.unseenPostNo
            }
            else{
                if let tabItems = self.tabBarController?.tabBar.items as NSArray!
                {
                    // In this case we want to modify the badge number of the third tab:
                    let tabItem = tabItems[0] as! UITabBarItem
                    tabItem.badgeValue = nil
                    
                }
                let application = UIApplication.shared
                let center = UNUserNotificationCenter.current()
                center.requestAuthorization(options:[.badge, .alert, .sound]) { (granted, error) in
                    // Enable or disable features based on authorization.
                }
                application.registerForRemoteNotifications()
                application.applicationIconBadgeNumber = 0
            }
            
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.newPostButton.buttonDesignOne()
        self.newPostButton.layer.shadowColor = UIColor.black.cgColor
        self.newPostButton.layer.shadowOpacity = 0.3
        self.newPostButton.layer.shadowRadius = 5
        self.newPostButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        self.postTableView.delegate = self
        self.postTableView.dataSource = self
        
        self.getSeenPostFromCoreData()
        
        self.checkIsLoggedIn()
        self.getInitialChildrenNo()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.unseenPostNo = 0
        self.postTableView.reloadData()
    }
    
    func setAnimation()
    {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.clear.cgColor, UIColor.clear.cgColor,
            UIColor.lightGray.cgColor, UIColor.lightGray.cgColor,
            UIColor.clear.cgColor, UIColor.clear.cgColor
        ]
        
        gradientLayer.locations = [0, 0.2, 0.4, 0.6, 0.8, 1]
        
        let angle = -60 * CGFloat.pi / 180
        let rotationTransform = CATransform3DMakeRotation(angle, 0, 0, 1)
        gradientLayer.transform = rotationTransform
        view.layer.addSublayer(gradientLayer)
        gradientLayer.frame = self.myShimmerView.frame
        
        self.myShimmerView.layer.mask = gradientLayer
        
        gradientLayer.transform = CATransform3DConcat(gradientLayer.transform, CATransform3DMakeScale(3, 3, 0))
        
        let animation = CABasicAnimation(keyPath: "transform.translation.x")
        animation.duration = 3
        animation.repeatCount = Float.infinity
        animation.autoreverses = false
        animation.fromValue = -3.0 * view.frame.width
        animation.toValue = 3.0 * view.frame.width
        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        gradientLayer.add(animation, forKey: "")
    }
    
    func getSeenPostFromCoreData(){
        let fetchRequest: NSFetchRequest<SeenPost> = SeenPost.fetchRequest()
        do{
            let fetchData = try LocalServices.context.fetch(fetchRequest)
            let tempResult = fetchData
            
            // x as each row in entity
            for x in tempResult{
                self.seenPostDict[x.postUUID!] = true
            }
            print("fetch successful")
        } catch {}
    }
    
    @IBAction func newPostButtonClicked(_ sender: Any) {
        
        self.newPostButton.isHidden = true
        
        let newPostAlert = UIAlertController(title: "Mohon tunggu", message: "Sedang memuat konten", preferredStyle: .alert)
        self.present(newPostAlert, animated: true, completion: nil)
        FirebaseReferences.databaseRef.child("Posts").queryOrderedByKey().queryStarting(atValue: self.lastKey).observeSingleEvent(of: .value, with: { (snap) in
            
            for x in snap.children{
                let data = x as! DataSnapshot
                let key: String = data.key
                let singlePost = data.value as! [String:AnyObject]
                
                if (self.lastKey != key){
                    print("current key: \(key)")
                    self.lastKey = key
                    
                    var tempSchoolImages: [UIImage] = []
                    var tempRoadImages: [UIImage] = []
                    
                    let schoolImages = singlePost["schoolImages"] as! [String:String]
                    for (_, schoolURL) in schoolImages{
                        let url = URL(string: schoolURL)
                        let data = try? Data(contentsOf: url!)
                        
                        if let imageData = data {
                            let image = UIImage(data: imageData)
                            tempSchoolImages.append(image!)
                        }
                    }
                    
                    let roadImages = singlePost["roadImages"] as! [String:String]
                    for (_, roadURL) in roadImages{
                        let url = URL(string: roadURL)
                        let data = try? Data(contentsOf: url!)
                        
                        if let imageData = data {
                            let image = UIImage(data: imageData)
                            tempRoadImages.append(image!)
                        }
                    }
                    
                    let schoolName: String = singlePost["schoolName"] as! String
                    let about: String = singlePost["about"] as! String
                    let needs: String = singlePost["needs"] as! String
                    let access: String = singlePost["access"] as! String
                    let address: String = singlePost["address"] as! String
                    let notes: String = singlePost["notes"] as! String
                    let locationLongitude: Double = singlePost["locationLongitude"] as! Double
                    let locationLatitude: Double = singlePost["locationLatitude"] as! Double
                    let locationAOI: String = singlePost["locationAOI"] as! String
                    let locationLocality: String = singlePost["locationLocality"] as! String
                    let locationName: String = singlePost["locationName"] as! String
                    let locationAdminArea: String = singlePost["locationAdminArea"] as! String
                    let postUUID: String = key
                    let posterID: String = singlePost["posterID"] as! String
                    let timeStamp: String = singlePost["timeStamp"] as! String
                    
                    self.postArray.insert(PostModel(schoolImages: tempSchoolImages, roadImages: tempRoadImages, schoolName: schoolName, aboutPost: about, needsPost: needs, addressPost: address, accessPost: access, notesPost: notes, locationName: locationName, locationAdminArea: locationAdminArea, locationLocality: locationLocality, locationAOI: locationAOI, locationLatitude: locationLatitude, locationLongitude: locationLongitude, postUUID: postUUID), at: 0)
                    self.postArray[0].posterID = posterID
                    self.postArray[0].timeStamp = timeStamp
                    self.unseenPostNo = 0
                    newPostAlert.dismiss(animated: true, completion: {
                        
                    })
                    self.postTableView.reloadData()
                    self.totalLoadedData = self.totalLoadedData + 1
                }
            }
        })
    
    }
    
    func checkIsLoggedIn(){
        let udLoggedIn: Bool = UserDefaultReference.udRef.bool(forKey: "udLoggedIn")
        print("Logged in: \(udLoggedIn)")
        if (udLoggedIn){
            let udEmail: String = UserDefaultReference.udRef.string(forKey: "udEmail")!
            let udHashedPassword: String = UserDefaultReference.udRef.string(forKey: "udHashedPassword")!
            let udUserUUID: String = UserDefaultReference.udRef.string(forKey: "udUserUUID")!
            
            FirebaseReferences.databaseRef.child("Users/\(udUserUUID)").observeSingleEvent(of: .value) { (snap) in
                let tempUser = snap.value as! [String:AnyObject]
                let tempUserEmail: String = tempUser["email"] as! String
                let tempUserPassword: String = tempUser["password"] as! String
                
                if (udEmail == tempUserEmail && udHashedPassword == tempUserPassword){
                    let tempUserFullName: String = tempUser["fullName"] as! String
                    let tempUserPhone: String = tempUser["phone"] as! String
                    var tempUserPosts: [String] = []
                    if let tempGetPosts: [String:String] = tempUser["posts"] as? [String:String]{
                        for (tempKey, _) in tempGetPosts{
                            tempUserPosts.append(tempKey)
                        }
                    }
                    
                    LoggedInUser.user = UserModel(email: tempUserEmail, fullName: tempUserFullName, phone: tempUserPhone, userUUID: udUserUUID, posts: tempUserPosts)
                    
//                    print(tempUserPosts)
                    LoggedInUser.isLoggedIn = true
                }
            }
        }
    }
    
    func getInitialChildrenNo(){
        FirebaseReferences.databaseRef.child("Posts").observeSingleEvent(of: .value) { (snap) in
            
            if (snap.hasChildren() == false){
                self.initialChildrenCount = 0
                self.startObservingFirebase()
                return
            }
            else{
                self.postTableView.isHidden = true
                self.myShimmerView.isHidden = false
                self.setAnimation()
                print("has set animation")
                self.initialChildrenCount = Int(snap.childrenCount)
                self.fetchFromFirebase()
            }
            print(self.initialChildrenCount)
        }
    }
    
    func startObservingFirebase(){
        FirebaseReferences.databaseRef.child("Posts").queryOrderedByKey().queryStarting(atValue: self.lastKey).observe(.childAdded) { (snap) in
            
            if (snap.key != self.lastKey){
                self.newPostButton.isHidden = false
                print("masuk new post")
                if let tabItems = self.tabBarController?.tabBar.items as NSArray!
                {
                    // In this case we want to modify the badge number of the third tab:
                    let tabItem = tabItems[0] as! UITabBarItem
                    tabItem.badgeValue = "baru"
                    
                }
            }
        }
    }

    var totalLoadedData: Int = 0{
        didSet{
            if (self.totalLoadedData == self.initialChildrenCount){
                print("has loaded all initial posts")
                self.myShimmerView.removeFromSuperview()
                self.postTableView.isHidden = false
                self.startObservingFirebase()
            }
        }
    }
    
    func fetchFromFirebase(){
        FirebaseReferences.databaseRef.child("Posts").queryOrderedByKey().queryLimited(toFirst: UInt(self.initialChildrenCount)).observeSingleEvent(of: .value, with: { (snap) in
            
            for x in snap.children{
                let data = x as! DataSnapshot
                let key: String = data.key
                let singlePost = data.value as! [String:AnyObject]
            
                print("current key: \(key)")
                self.lastKey = key
                
                var tempSchoolImages: [UIImage] = []
                var tempRoadImages: [UIImage] = []
                
                let schoolImages = singlePost["schoolImages"] as! [String:String]
                for (_, schoolURL) in schoolImages{
                    let url = URL(string: schoolURL)
                    let data = try? Data(contentsOf: url!)
                    
                    if let imageData = data {
                        let image = UIImage(data: imageData)
                        tempSchoolImages.append(image!)
                    }
                }
                
                let roadImages = singlePost["roadImages"] as! [String:String]
                for (_, roadURL) in roadImages{
                    let url = URL(string: roadURL)
                    let data = try? Data(contentsOf: url!)
                    
                    if let imageData = data {
                        let image = UIImage(data: imageData)
                        tempRoadImages.append(image!)
                    }
                }
                
                let schoolName: String = singlePost["schoolName"] as! String
                let about: String = singlePost["about"] as! String
                let needs: String = singlePost["needs"] as! String
                let access: String = singlePost["access"] as! String
                let address: String = singlePost["address"] as! String
                let notes: String = singlePost["notes"] as! String
                let locationLongitude: Double = singlePost["locationLongitude"] as! Double
                let locationLatitude: Double = singlePost["locationLatitude"] as! Double
                let locationAOI: String = singlePost["locationAOI"] as! String
                let locationLocality: String = singlePost["locationLocality"] as! String
                let locationName: String = singlePost["locationName"] as! String
                let locationAdminArea: String = singlePost["locationAdminArea"] as! String
                let postUUID: String = key
                let posterID: String = singlePost["posterID"] as! String
                let timeStamp: String = singlePost["timeStamp"] as! String
                
                self.postArray.insert(PostModel(schoolImages: tempSchoolImages, roadImages: tempRoadImages, schoolName: schoolName, aboutPost: about, needsPost: needs, addressPost: address, accessPost: access, notesPost: notes, locationName: locationName, locationAdminArea: locationAdminArea, locationLocality: locationLocality, locationAOI: locationAOI, locationLatitude: locationLatitude, locationLongitude: locationLongitude, postUUID: postUUID), at: 0)
                self.postArray[0].posterID = posterID
                self.postArray[0].timeStamp = timeStamp
                
                self.postTableView.reloadData()
                self.totalLoadedData = self.totalLoadedData + 1
            }
        })
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "discoverToDiscoverDetail"{
            let destination = segue.destination as! DiscoverDetailViewController
            destination.currentPost = self.postArray[self.selectedPostIndex]
        }
    }
    
    func saveSeenPostToCoreData(){
        let tempSeenPost = SeenPost(context: LocalServices.context)
        tempSeenPost.postUUID = self.postArray[self.selectedPostIndex].postUUID
        LocalServices.saveContext()
    }
    
}


extension DiscoverViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.postArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.postTableView.dequeueReusableCell(withIdentifier: "postCell") as! PostCell
        
        cell.fillCell(schoolName: self.postArray[indexPath.row].schoolName, about: self.postArray[indexPath.row].aboutPost)
        cell.fillLocation(desc: "\(self.postArray[indexPath.row].locationLocality), \(self.postArray[indexPath.row].locationAdminArea)")
        cell.fillThumbnail(thumbnail: self.postArray[indexPath.row].schoolImages[0])
        cell.selectionStyle = .none
        
        if (self.seenPostDict[self.postArray[indexPath.row].postUUID] == nil){
            cell.setUnseenIcon(isSeen: false)
            self.unseenPostNo = self.unseenPostNo + 1
            print("unseen: \(self.postArray[indexPath.row].schoolName) \(self.postArray[indexPath.row].needsPost)")
        }
        else{
            cell.setUnseenIcon(isSeen: true)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedPostIndex = indexPath.row
        self.saveSeenPostToCoreData()
        
        if (self.seenPostDict[self.postArray[indexPath.row].postUUID] == nil){
            self.unseenPostNo = self.unseenPostNo - 1
            print("clicked on unseen post")
            self.seenPostDict[self.postArray[indexPath.row].postUUID] = true
        }
        
        performSegue(withIdentifier: "discoverToDiscoverDetail", sender: self)
    }
    
    
}













