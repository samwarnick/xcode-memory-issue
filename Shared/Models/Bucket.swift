//
//  Bucket+CoreDataProperties.swift
//  Savings Tracker
//
//  Created by Sam Warnick on 11/14/21.
//
//

import Foundation
import CoreData

@objc(Bucket)
public class Bucket: NSManagedObject {

}

extension Bucket: Identifiable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Bucket> {
        return NSFetchRequest<Bucket>(entityName: "Bucket")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var balance: NSDecimalNumber?
    @NSManaged public var goal: NSDecimalNumber?
    @NSManaged public var target: Date?
    @NSManaged public var transactions: Transaction?

}

extension Bucket {
    var percentCompleted: Double {
        get {
            min(balance!.dividing(by: goal!).doubleValue, 1)
        }
    }
}
