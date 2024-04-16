//
//  Product+CoreDataProperties.swift
//  WishList
//
//  Created by 정유진 on 2024/04/16.
//
//

import Foundation
import CoreData


extension Product {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product")
    }

    @NSManaged public var id: Int64
    @NSManaged public var price: Double
    @NSManaged public var title: String?

}

extension Product : Identifiable {

}
