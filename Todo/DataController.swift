//
//  DataController.swift
//  Todo
//
//  Created by Anubhav Rawat on 09/10/22.
//

import Foundation
import CoreData

class DataController: ObservableObject{
    
    static let shared = DataController()
    
    let container: NSPersistentContainer
    init(){
        container = NSPersistentContainer(name: "DataModels")
        
        let storeURL = URL.storeURL(for: "group.anubhavRawat.myapp", databaseName: "todo")
        let storedescription = NSPersistentStoreDescription(url: storeURL)
        container.persistentStoreDescriptions = [storedescription]
        
        container.loadPersistentStores { description, error in
            if let error = error{
                print(error.localizedDescription)
            }
            
            self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        }
    }
}


//MARK: - url extension
public extension URL {

    /// Returns a URL for the given app group and database pointing to the sqlite database.
    static func storeURL(for appGroup: String, databaseName: String) -> URL {
        guard let fileContainer = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: appGroup) else {
            fatalError("Shared file container could not be created.")
        }

        return fileContainer.appendingPathComponent("\(databaseName).sqlite")
    }
}
