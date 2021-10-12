//
//  SavedBoredActivity+CoreDataProperties.swift
//  BoringApp
//
//  Created by Ivanov Viktor on 10.10.2021.
//
//

import Foundation
import CoreData


extension SavedBoredActivity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SavedBoredActivity> {
        return NSFetchRequest<SavedBoredActivity>(entityName: "SavedBoredActivity")
    }

    @NSManaged public var accessibility: Double
    @NSManaged public var activity: String?
    @NSManaged public var key: String?
    @NSManaged public var link: String?
    @NSManaged public var participants: Int64
    @NSManaged public var price: Double
    @NSManaged public var type: String?

}

extension SavedBoredActivity: Identifiable, BModel {

}
