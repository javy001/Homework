//
//  Assignment+CoreDataClass.swift
//  Homework
//
//  Created by Javier Quintero on 5/22/19.
//  Copyright © 2019 Javier Quintero. All rights reserved.
//
//

import Foundation
import CoreData


public class Assignment: NSManagedObject {
    func getDateString() -> String {
        var dateString = ""
        if let dueDate = dueDate {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            dateString = formatter.string(from: dueDate as Date)
        }
        return dateString
    }
}
