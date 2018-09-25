//
//  Project.swift
//  TaskerAppIos
//
//  Created by Денис on 23.09.2018.
//  Copyright © 2018 Денис. All rights reserved.
//

import Foundation

class Project {
    var id:Int
    var title:String
    var todos:[Todo]
    
    init() {
        self.id = -1
        self.title = ""
        self.todos = []
    }
    
    init (json:[String:Any]) {
        self.id = json["id"] as? Int ?? -1
        self.title = json["title"] as? String ?? ""
        self.todos = [Todo(json: json["todos"] as! [String : Any])]
    }
        
    init(id:Int, title:String, todos:[Todo]) {
        self.id = id
        self.title = title
        self.todos = todos
    }
}
