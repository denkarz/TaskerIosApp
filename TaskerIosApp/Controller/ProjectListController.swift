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
        fetch_data()
        self.navigationController!.navigationBar.tintColor = UIColor.white
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "OpenSans", size: 20)!,NSAttributedString.Key.foregroundColor:UIColor.white]
        self.tableView.backgroundColor = UIColor(red:0.97, green:0.97, blue:0.97, alpha:1.0)
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 200
    }
    
    override func viewWillAppear(_ animated: Bool){
        fetch_data()
    }
    
    public func fetch_data() -> Void {
        var tempProjects:[Project]=[]
        Alamofire.request("https://limitless-dawn-57124.herokuapp.com/custom_controller/index.json").responseJSON { (responseData) -> Void in
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
                        tmpTodo.is_completed = jtodos[j]["is_completed"].boolValue
                        tmpProject.todos.append(tmpTodo)
                    }
                    tempProjects.append(tmpProject)
                    self.projects = tempProjects
                    if (self.projects.count == 3) {
                        self.tableView.reloadData()
                    }
                }
            }
        }
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
        cell.todo = projects[indexPath.section].todos[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nav = segue.destination as! UINavigationController
        let svc = nav.topViewController as! AddTodoListScreen
        svc.projects = projects
        svc.instanceOfMain = self
    }
}
