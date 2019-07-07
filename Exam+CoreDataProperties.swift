//
//  Exam+CoreDataProperties.swift
//  Homework
//
//  Created by Javier Quintero on 7/5/19.
//  Copyright © 2019 Javier Quintero. All rights reserved.
//
//

import Foundation
import CoreData


extension Exam {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Exam> {
        return NSFetchRequest<Exam>(entityName: "Exam")
    }

    @NSManaged public var dueDate: NSDate?
    @NSManaged public var isComplete: Bool
    @NSManaged public var name: String?
    @NSManaged public var notes: String?
    @NSManaged public var schoolClass: SchoolClass?

}
