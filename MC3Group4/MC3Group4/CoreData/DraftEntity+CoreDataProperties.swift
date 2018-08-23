//
//  DraftEntity+CoreDataProperties.swift
//  
//
//  Created by Steven Muliamin on 23/08/18.
//
//

import Foundation
import CoreData


extension DraftEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DraftEntity> {
        return NSFetchRequest<DraftEntity>(entityName: "DraftEntity")
    }

    @NSManaged public var aboutPost: String?
    @NSManaged public var accessPost: String?
    @NSManaged public var addressPost: String?
    @NSManaged public var locationAdminArea: String?
    @NSManaged public var locationAOI: String?
    @NSManaged public var locationLatitude: Double
    @NSManaged public var locationLocality: String?
    @NSManaged public var locationLongitude: Double
    @NSManaged public var locationName: String?
    @NSManaged public var needsPost: String?
    @NSManaged public var notesPost: String?
    @NSManaged public var roadImages: NSData?
    @NSManaged public var schoolImages: NSData?
    @NSManaged public var schoolName: String?
    @NSManaged public var postUUID: String?

}
