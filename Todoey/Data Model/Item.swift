//
//  Item.swift
//  Todoey
//
//  Created by Devon Fazekas on 2019-06-30.
//  Copyright © 2019 Devon Fazekas. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
