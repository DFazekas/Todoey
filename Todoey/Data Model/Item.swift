//
//  Item.swift
//  Todoey
//
//  Created by Devon Fazekas on 2019-04-21.
//  Copyright © 2019 Devon Fazekas. All rights reserved.
//

import Foundation

class Item {
    var title: String = ""
    var done: Bool = false
    
    init(_ title: String, _ done: Bool = false) {
        self.title = title
        self.done = done
    }
}
