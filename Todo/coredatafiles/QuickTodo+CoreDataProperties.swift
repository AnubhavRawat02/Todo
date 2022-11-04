//
//  QuickTodo+CoreDataProperties.swift
//  Todo
//
//  Created by Anubhav Rawat on 09/10/22.
//
//

import Foundation
import CoreData


extension QuickTodo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<QuickTodo> {
        return NSFetchRequest<QuickTodo>(entityName: "QuickTodo")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var totalTasks: Int32
    @NSManaged public var completed: Int32
    @NSManaged public var dateCreated: Date?
    @NSManaged public var archived: Bool
    @NSManaged public var tasks: Set<LTasks>?
    
    public var taskslist:[LTasks]{
        let set = tasks
        return set!.sorted{
            $0.title! < $1.title!
        }
    }

}

// MARK: Generated accessors for tasks
extension QuickTodo {

    @objc(addTasksObject:)
    @NSManaged public func addToTasks(_ value: LTasks)

    @objc(removeTasksObject:)
    @NSManaged public func removeFromTasks(_ value: LTasks)

    @objc(addTasks:)
    @NSManaged public func addToTasks(_ values: NSSet)

    @objc(removeTasks:)
    @NSManaged public func removeFromTasks(_ values: NSSet)

}

extension QuickTodo : Identifiable {

}
