//
//  SchoolClass+CoreDataProperties.swift
//  Homework
//
//  Created by Javier Quintero on 8/2/19.
//  Copyright © 2019 Javier Quintero. All rights reserved.
//
//

import Foundation
import CoreData


extension SchoolClass {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SchoolClass> {
        return NSFetchRequest<SchoolClass>(entityName: "SchoolClass")
    }

    @NSManaged public var color: Int16
    @NSManaged public var emailAddress: String?
    @NSManaged public var location: String?
    @NSManaged public var name: String?
    @NSManaged public var teacherName: String?
    @NSManaged public var assignment: NSSet?
    @NSManaged public var exam: NSSet?
    @NSManaged public var flashDeck: NSSet?

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

// MARK: Generated accessors for exam
extension SchoolClass {

    @objc(addExamObject:)
    @NSManaged public func addToExam(_ value: Exam)

    @objc(removeExamObject:)
    @NSManaged public func removeFromExam(_ value: Exam)

    @objc(addExam:)
    @NSManaged public func addToExam(_ values: NSSet)

    @objc(removeExam:)
    @NSManaged public func removeFromExam(_ values: NSSet)

}

// MARK: Generated accessors for flashDeck
extension SchoolClass {

    @objc(addFlashDeckObject:)
    @NSManaged public func addToFlashDeck(_ value: FlashDeck)

    @objc(removeFlashDeckObject:)
    @NSManaged public func removeFromFlashDeck(_ value: FlashDeck)

    @objc(addFlashDeck:)
    @NSManaged public func addToFlashDeck(_ values: NSSet)

    @objc(removeFlashDeck:)
    @NSManaged public func removeFromFlashDeck(_ values: NSSet)

}
