//
//  Todo.swift
//  TaskerAppIos
//
//  Created by Денис on 23.09.2018.
//  Copyright © 2018 Денис. All rights reserved.
//
import Foundation

class Todo {
    var id:Int
    var text:String
    var is_completed:Bool
    
    init (json:[String:Any]) {
        self.id = json["id"] as? Int ?? -1
        self.text = json["text"] as? String ?? ""
        self.is_completed = json["is_completed"] as? Bool ?? false
    }
    
    init() {
        self.id = 0
        self.text = ""
        self.is_completed = false
    }
    
    init(id:Int,text:String,is_completed:Bool) {
        self.id = id
        self.text = text
        self.is_completed = is_completed
    }
}
