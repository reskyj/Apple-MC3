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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.checkIsLoggedIn()
    }
    
    func checkIsLoggedIn(){
        let udLoggedIn = UserDefaultReference.udRef.bool(forKey: "udLoggedIn")
        if (udLoggedIn){
            let udEmail = UserDefaultReference.udRef.string(forKey: "udEmail")
            let udHashedPassword = UserDefaultReference.udRef.string(forKey: "udHashedPassword")
            let udUserUUID = UserDefaultReference.udRef.string(forKey: "udUserUUID")
            
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
                    
                    LoggedInUser.user = UserModel(email: tempUserEmail, fullName: tempUserFullName, phone: tempUserPhone, userUUID: udUserUUID!, posts: tempUserPosts)
                    
                    print(tempUserPosts)
                    LoggedInUser.isLoggedIn = true
                }
            }
        }
    }


}
