//
//  PTasks+CoreDataProperties.swift
//  Todo
//
//  Created by Anubhav Rawat on 09/10/22.
//
//

import Foundation
import CoreData


extension PTasks {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PTasks> {
        return NSFetchRequest<PTasks>(entityName: "PTasks")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var desc: String?
    @NSManaged public var noSubtasks: Int32
    @NSManaged public var priority: Int32
    @NSManaged public var isDone: Bool
    @NSManaged public var dateCreated: Date?
    @NSManaged public var deadline: Date?
    @NSManaged public var subtask: Set<SubTask>?
    @NSManaged public var project: Projects?
    
    public var subtaskslist: [SubTask]{
        let set = subtask
        return set!.sorted{
            $0.title! < $1.title!
        }
    }

}

// MARK: Generated accessors for subtask
extension PTasks {

    @objc(addSubtaskObject:)
    @NSManaged public func addToSubtask(_ value: SubTask)

    @objc(removeSubtaskObject:)
    @NSManaged public func removeFromSubtask(_ value: SubTask)

    @objc(addSubtask:)
    @NSManaged public func addToSubtask(_ values: NSSet)

    @objc(removeSubtask:)
    @NSManaged public func removeFromSubtask(_ values: NSSet)

}

extension PTasks : Identifiable {

}
