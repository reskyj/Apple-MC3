//
//  UserModel.swift
//  MC3Group4
//
//  Created by Steven Muliamin on 20/08/18.
//  Copyright © 2018 Resky Javieri. All rights reserved.
//

import Foundation

class UserModel{
    
    var email: String
    var fullName: String
    var phone: String
    var userUUID: String
    var posts: [String] = []
    
    init(email: String, fullName: String, phone: String, userUUID: String, posts: [String]) {
        self.email = email
        self.fullName = fullName
        self.phone = phone
        self.userUUID = userUUID
        self.posts = posts
    }
}
