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

class DiscoverViewController: UIViewController {
    
    @IBOutlet weak var postTableView: UITableView!
    @IBOutlet weak var newPostButton: UIButton!
    
    var postArray: [PostModel] = []
    var lastKey: String = ""
    var getLast: Int = 0
    
    var initialChildrenCount: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.postTableView.delegate = self
        self.postTableView.dataSource = self
        
        self.checkIsLoggedIn()
        self.getInitialChildrenNo()
    }
    
    @IBAction func newPostButtonClicked(_ sender: Any) {
        
        self.newPostButton.isHidden = true
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
                    
                    print(tempUserPosts)
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
            }
        }
    }

    var totalLoadedData: Int = 0{
        didSet{
            if (self.totalLoadedData == self.initialChildrenCount){
                print("has loaded all initial posts")
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
        
        return cell
    }
    
    
}













