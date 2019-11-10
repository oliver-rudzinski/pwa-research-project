//
//  ToDo+CoreDataProperties.swift
//  ios-todo-app
//
//  Created by Oliver Rudzinski on 09.11.19.
//  Copyright © 2019 Oliver Rudzinski. All rights reserved.
//
//

import Foundation
import CoreData


extension ToDo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDo> {
        return NSFetchRequest<ToDo>(entityName: "ToDo")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var text: String?
    @NSManaged public var done: Bool
    @NSManaged public var priority: Bool

}
