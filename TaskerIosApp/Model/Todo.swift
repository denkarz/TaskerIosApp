//
//  Todo.swift
//  TaskerAppIos
//
//  Created by Денис on 23.09.2018.
//  Copyright © 2018 Денис. All rights reserved.
//
import Foundation
import UIKit

class Todo {
    var id:integer_t
    var text:String
    var is_completed:Bool
    
    init(id:integer_t,text:String,is_completed:Bool) {
        self.id = id
        self.text = text
        self.is_completed = is_completed
    }
}
