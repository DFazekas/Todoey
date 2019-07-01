//
//  Category.swift
//  Todoey
//
//  Created by Devon Fazekas on 2019-06-30.
//  Copyright © 2019 Devon Fazekas. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()
}
