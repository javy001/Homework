//
//  SchoolClass+CoreDataClass.swift
//  Homework
//
//  Created by Javier Quintero on 7/5/19.
//  Copyright © 2019 Javier Quintero. All rights reserved.
//
//

import Foundation
import CoreData


public class SchoolClass: NSManagedObject {
    @nonobjc public class func schoolClassFetchRequest() -> NSFetchRequest<SchoolClass> {
        return NSFetchRequest<SchoolClass>(entityName: "SchoolClass")
    }
}
