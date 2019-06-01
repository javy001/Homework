//
//  Assignment+CoreDataProperties.swift
//  Homework
//
//  Created by Javier Quintero on 5/22/19.
//  Copyright © 2019 Javier Quintero. All rights reserved.
//
//

import Foundation
import CoreData


extension Assignment {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Assignment> {
        return NSFetchRequest<Assignment>(entityName: "Assignment")
    }

    @NSManaged public var dueDate: NSDate?
    @NSManaged public var name: String?
    @NSManaged public var isComplete: Bool
    @NSManaged public var schoolClass: SchoolClass?
    @NSManaged public var notes: String?

}
