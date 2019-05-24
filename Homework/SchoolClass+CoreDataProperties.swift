//
//  SchoolClass+CoreDataProperties.swift
//  Homework
//
//  Created by Javier Quintero on 5/21/19.
//  Copyright © 2019 Javier Quintero. All rights reserved.
//
//

import Foundation
import CoreData


extension SchoolClass {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SchoolClass> {
        return NSFetchRequest<SchoolClass>(entityName: "SchoolClass")
    }

    @NSManaged public var name: String?
    @NSManaged public var assignment: NSSet?

}

// MARK: Generated accessors for assignment
extension SchoolClass {

    @objc(addAssignmentObject:)
    @NSManaged public func addToAssignment(_ value: Assignment)

    @objc(removeAssignmentObject:)
    @NSManaged public func removeFromAssignment(_ value: Assignment)

    @objc(addAssignment:)
    @NSManaged public func addToAssignment(_ values: NSSet)

    @objc(removeAssignment:)
    @NSManaged public func removeFromAssignment(_ values: NSSet)

}
