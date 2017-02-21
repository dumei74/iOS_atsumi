//
//  Index+CoreDataProperties.swift
//  memo_ca
//
//  Created by 石井篤美 on 2017/02/21.
//  Copyright © 2017年 石井篤美. All rights reserved.
//

import Foundation
import CoreData


extension Index {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Index> {
        return NSFetchRequest<Index>(entityName: "Index");
    }

    @NSManaged public var back: String?
    @NSManaged public var backP: String?
    @NSManaged public var cardNo: Int16
    @NSManaged public var check: Bool
    @NSManaged public var fileName: String?
    @NSManaged public var front: String?
    @NSManaged public var frontP: String?

}
