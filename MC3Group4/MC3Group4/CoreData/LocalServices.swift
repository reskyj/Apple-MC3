//
//  LocalServices.swift
//
//
//  Created by Steven Muliamin on 12/05/18.
//  Copyright © 2018 Steven Muliamin. All rights reserved.
//

import Foundation
import CoreData

class LocalServices{
    private init(){}
    
    static var context: NSManagedObjectContext{
        return persistentContainer.viewContext
    }
    
    static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "LocalModel")
        container.loadPersistentStores(completionHandler: {(storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("error has occured")
                
            }
            
        })
        
        return container
        
    }()
    
    static func saveContext () {
        
        let context = persistentContainer.viewContext
        if context.hasChanges{
            do{
                try context.save()
                print("save success")
            }
            catch{
                let nserror = error as NSError
                fatalError("Error has occured: \(nserror)")
            }
        }
        
    }
}
