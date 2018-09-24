//
//  Project.swift
//  TaskerAppIos
//
//  Created by Денис on 23.09.2018.
//  Copyright © 2018 Денис. All rights reserved.
//

import Foundation
import UIKit

class Project {
    var id:integer_t
    var title:String
    var todos:[Todo]
    
    init(id:integer_t, title:String, todos:[Todo]) {
        self.id = id
        self.title = title
        self.todos = todos
    }
    func getTodos() -> [Todo] {
        return self.todos
    }
}
