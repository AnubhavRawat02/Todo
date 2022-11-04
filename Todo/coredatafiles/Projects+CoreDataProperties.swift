//
//  Projects+CoreDataProperties.swift
//  Todo
//
//  Created by Anubhav Rawat on 09/10/22.
//
//

import Foundation
import CoreData


extension Projects {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Projects> {
        return NSFetchRequest<Projects>(entityName: "Projects")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var totalTasks: Int32
    @NSManaged public var completed: Int32
    @NSManaged public var archived: Bool
    @NSManaged public var dateCreated: Date?
    @NSManaged public var desc: String?
    @NSManaged public var deadline: Date?
    @NSManaged public var tasks: Set<PTasks>?
    
    public var taskslist: [PTasks]{
        let set = tasks
        return set!.sorted{
            $0.title! < $1.title!
        }
    }

}

// MARK: Generated accessors for tasks
extension Projects {

    @objc(addTasksObject:)
    @NSManaged public func addToTasks(_ value: PTasks)

    @objc(removeTasksObject:)
    @NSManaged public func removeFromTasks(_ value: PTasks)

    @objc(addTasks:)
    @NSManaged public func addToTasks(_ values: NSSet)

    @objc(removeTasks:)
    @NSManaged public func removeFromTasks(_ values: NSSet)

}

extension Projects : Identifiable {

}
