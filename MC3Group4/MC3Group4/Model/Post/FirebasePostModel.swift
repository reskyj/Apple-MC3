//
//  FirebasePostModel.swift
//  MC3Group4
//
//  Created by Steven Muliamin on 27/08/18.
//  Copyright © 2018 Resky Javieri. All rights reserved.
//

import Foundation

class FirebasePostModel{
    
    var dataModel: [String:Any] = [:]
    
    var schoolName: String = ""
    var about: String = ""
    var needs: String = ""
    var access: String = ""
    var address: String = ""
    var notes: String = ""
    
    var schoolImages: [String:String] = [:]
    var roadImages: [String:String] = [:]
    
    var locationName: String = ""
    var locationAdminArea: String = ""
    var locationLocality: String = ""
    var locationAOI: String = ""
    var locationLatitude: Double = 0
    var locationLongitude: Double = 0
    
    var postUUID: String = ""
    var posterID: String = ""
    
    init(schoolName: String, about: String, needs: String, access: String, address: String, notes: String, schoolImages: [String:String], roadImages: [String:String], locationName: String, locationAdminArea: String, locationLocality: String, locationAOI: String, locationLatitude: Double, locationLongitude: Double, postUUID: String, posterID: String) {
        
        self.dataModel["schoolName"] = schoolName
        self.dataModel["about"] = about
        self.dataModel["needs"] = needs
        self.dataModel["access"] = access
        self.dataModel["address"] = address
        self.dataModel["notes"] = notes
        
        self.dataModel["locationName"] = locationName
        self.dataModel["locationAdminArea"] = locationAdminArea
        self.dataModel["locationLocality"] = locationLocality
        self.dataModel["locationAOI"] = locationAOI
        self.dataModel["locationLatitude"] = locationLatitude
        self.dataModel["locationLongitude"] = locationLongitude
        self.dataModel["posterID"] = posterID
        
        self.dataModel["schoolImages"] = schoolImages
        self.dataModel["roadImages"] = roadImages
    }
    
    
}
