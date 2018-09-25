//
//  ViewController.swift
//  TaskerAppIos
//
//  Created by Денис on 23.09.2018.
//  Copyright © 2018 Денис. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ProjectsListScreen: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var projects:[Project] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBar.tintColor = UIColor.white
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "OpenSans", size: 20)!,NSAttributedString.Key.foregroundColor:UIColor.white]
//        ["OpenSans-Semibold", "OpenSans"]
//        for family in UIFont.familyNames.sorted(){
//            let names = UIFont.fontNames(forFamilyName:family)
//            print("Family: \(family) Font names: \(names)")
//        }
        self.tableView.backgroundColor = UIColor(red:0.97, green:0.97, blue:0.97, alpha:1.0)
        projects = createArray()
//        fetch_data()
    }
    
    func fetch_data() -> Void {
        print("fetch")
        var tempProjects:[Project]=[]
        Alamofire.request("http://192.168.1.68:3000/custom_controller/index.json").responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                let json = JSON(responseData.result.value!)
                for i in 0 ..< json.count {
                    let tmpProject = Project()
                    tmpProject.id = json[i]["id"].intValue
                    tmpProject.title = json[i]["title"].stringValue
    
                    let jtodos = json[i]["todos"]
                    for j in 0 ..< jtodos.count {
                        let tmpTodo = Todo()
                        tmpTodo.id = jtodos[j]["id"].intValue
                        tmpTodo.text = jtodos[j]["text"].stringValue
                        tmpTodo.is_completed = jtodos["is_completed"].boolValue
                        tmpProject.todos.append(tmpTodo)
                    }
                    tempProjects.append(tmpProject)
                }
            }
        }
        projects = tempProjects
        tableView.reloadData()
    }
    
    func createArray() -> [Project] {
        var tempProjects:[Project]=[]
        var tempTodos1:[Todo]=[]
        var tempTodos2:[Todo]=[]
        var tempTodos3:[Todo]=[]
        
        var todo = Todo(id: 1, text: "todo1", is_completed: false)
        tempTodos1.append(todo)
        todo = Todo(id: 2, text: "todo2", is_completed: false)
        tempTodos1.append(todo)
        todo = Todo(id: 3, text: "todo3", is_completed: false)
        tempTodos1.append(todo)
        var project = Project(id:1,title: "TITLE1",todos: tempTodos1)
        tempProjects.append(project)
        
        todo = Todo(id: 4, text: "todo4", is_completed: false)
        tempTodos2.append(todo)
        todo = Todo(id: 5, text: "todo5", is_completed: false)
        tempTodos2.append(todo)
        todo = Todo(id: 6, text: "todo6", is_completed: false)
        tempTodos2.append(todo)
        project = Project(id:2,title: "TITLE2",todos: tempTodos2)
        tempProjects.append(project)
        
        todo = Todo(id: 7, text: "todo7", is_completed: false)
        tempTodos3.append(todo)
        todo = Todo(id: 8, text: "todo8", is_completed: false)
        tempTodos3.append(todo)
        todo = Todo(id: 9, text: "todo9", is_completed: false)
        tempTodos3.append(todo)
        project = Project(id:3,title: "TITLE3",todos: tempTodos3)
        tempProjects.append(project)
        
        return tempProjects
    }
}

extension ProjectsListScreen: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projects[section].todos.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor(red:0.97, green:0.97, blue:0.97, alpha:1.0)
        let label = UILabel()
        label.font = UIFont(name: "OpenSans-Semibold", size: 17)
        label.text = projects[section].title
        label.frame = CGRect (x: 45, y: 5, width: 100, height: 35)
        view.addSubview(label)
        return view
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return projects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "task") as! TodoCell
        cell.todoText = projects[indexPath.section].todos[indexPath.row].text
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}
