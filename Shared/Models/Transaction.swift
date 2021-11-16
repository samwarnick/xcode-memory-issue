//
//  Transaction+CoreDataProperties.swift
//  Savings Tracker
//
//  Created by Sam Warnick on 11/14/21.
//
//

import Foundation
import CoreData

@objc(Transaction)
public class Transaction: NSManagedObject {

}

extension Transaction: Identifiable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Transaction> {
        return NSFetchRequest<Transaction>(entityName: "Transaction")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var date: Date?
    @NSManaged public var amount: NSDecimalNumber?
    @NSManaged public var bucket: Bucket?

}
