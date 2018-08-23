//
//  PostModel.swift
//  MC3Group4
//
//  Created by Steven Muliamin on 23/08/18.
//  Copyright © 2018 Resky Javieri. All rights reserved.
//

import Foundation
import UIKit

class PostModel {
    
    var schoolImages: [UIImage] = []
    var roadImages: [UIImage] = []
    var schoolName: String = ""
    var aboutPost: String = ""
    var needsPost: String = ""
    var addressPost: String = ""
    var accessPost: String = ""
    var notesPost: String = ""
    var locationName: String = ""
    var locationAdminArea: String = ""
    var locationLocality: String = ""
    var locationAOI: String = ""
    var locationLatitude: Double?
    var locationLongitude: Double?
    
    init(schoolImages: [UIImage], roadImages: [UIImage], schoolName: String, aboutPost: String, needsPost: String, addressPost: String, accessPost: String, notesPost: String, locationName: String, locationAdminArea: String, locationLocality: String, locationAOI: String, locationLatitude: Double, locationLongitude: Double) {
        
        self.schoolImages = schoolImages
        self.roadImages = roadImages
        self.schoolName = schoolName
        self.aboutPost = aboutPost
        self.needsPost = needsPost
        self.addressPost = addressPost
        self.accessPost = accessPost
        self.notesPost = notesPost
        self.locationName = locationName
        self.locationAdminArea = locationAdminArea
        self.locationLocality = locationLocality
        self.locationAOI = locationAOI
        self.locationLatitude = locationLatitude
        self.locationLongitude = locationLongitude
    }
}
