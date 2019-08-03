//
//  FlashCard+CoreDataClass.swift
//  Homework
//
//  Created by Javier Quintero on 8/2/19.
//  Copyright © 2019 Javier Quintero. All rights reserved.
//
//

import Foundation
import CoreData


public class FlashCard: NSManagedObject {
    @nonobjc public class func flashCardFetchRequest() -> NSFetchRequest<FlashCard> {
        return NSFetchRequest<FlashCard>(entityName: "FlashCard")
    }
}
