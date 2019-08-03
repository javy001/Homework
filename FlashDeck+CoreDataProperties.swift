//
//  FlashDeck+CoreDataProperties.swift
//  Homework
//
//  Created by Javier Quintero on 8/3/19.
//  Copyright © 2019 Javier Quintero. All rights reserved.
//
//

import Foundation
import CoreData


extension FlashDeck {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FlashDeck> {
        return NSFetchRequest<FlashDeck>(entityName: "FlashDeck")
    }

    @NSManaged public var name: String?
    @NSManaged public var schoolClass: SchoolClass?
    @NSManaged public var flashCard: NSSet?

}

// MARK: Generated accessors for flashCard
extension FlashDeck {

    @objc(addFlashCardObject:)
    @NSManaged public func addToFlashCard(_ value: FlashCard)

    @objc(removeFlashCardObject:)
    @NSManaged public func removeFromFlashCard(_ value: FlashCard)

    @objc(addFlashCard:)
    @NSManaged public func addToFlashCard(_ values: NSSet)

    @objc(removeFlashCard:)
    @NSManaged public func removeFromFlashCard(_ values: NSSet)

}
