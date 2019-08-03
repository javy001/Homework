//
//  FlashDeck+CoreDataClass.swift
//  Homework
//
//  Created by Javier Quintero on 8/2/19.
//  Copyright © 2019 Javier Quintero. All rights reserved.
//
//

import Foundation
import CoreData


public class FlashDeck: NSManagedObject {
    @nonobjc public class func flashDeckFetchRequest() -> NSFetchRequest<FlashDeck> {
        return NSFetchRequest<FlashDeck>(entityName: "FlashDeck")
    }
}
