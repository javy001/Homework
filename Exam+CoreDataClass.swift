//
//  Exam+CoreDataClass.swift
//  Homework
//
//  Created by Javier Quintero on 7/5/19.
//  Copyright © 2019 Javier Quintero. All rights reserved.
//
//

import Foundation
import CoreData


public class Exam: NSManagedObject {
    
    func getDateString() -> String {
        var dateString = ""
        if let dueDate = dueDate {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEEE MMM d"
            dateString = formatter.string(from: dueDate as Date)
        }
        return dateString
    }
    
    @nonobjc public class func examFetchRequest() -> NSFetchRequest<Exam> {
        return NSFetchRequest<Exam>(entityName: "Exam")
    }

}
