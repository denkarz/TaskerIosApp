//
//  AddTodoScreen.swift
//  TaskerIosApp
//
//  Created by Денис on 24.09.2018.
//  Copyright © 2018 Денис. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class AddTodoListScreen: UIViewController {
    
    @IBOutlet weak var newTaskTableView: UITableView!
    var projects:[Project] = []
    var projectId = -1
    var instanceOfMain: ProjectsListScreen!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBar.tintColor = UIColor.white
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "OpenSans", size: 20)!,NSAttributedString.Key.foregroundColor:UIColor.white]
        self.newTaskTableView.backgroundColor = UIColor(red:0.97, green:0.97, blue:0.97, alpha:1.0)
    }
    
    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func done(_ sender: Any) {
        let cell: TodoTextCell = self.newTaskTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! TodoTextCell
        let text = cell.textField.text!
//        let url = "http://192.168.1.68:3000/custom_controller/create"
        let url = "https://limitless-dawn-57124.herokuapp.com/custom_controller/create"
        if (projectId != -1 || text != "") {
            let parameters: Parameters = ["todo": ["text": text, "project_id":projectId]]
             Alamofire.request(url, method: .post, parameters: parameters)
            instanceOfMain.fetch_data()
        }
        self.dismiss(animated: true, completion: nil)
    }
}

extension AddTodoListScreen : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return projects.count
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor(red:0.97, green:0.97, blue:0.97, alpha:1.0)
        let label = UILabel()
        label.font = UIFont(name: "OpenSans-Semibold", size: 17)
        if section == 0 {
            label.text = "Задача"
        } else {
            label.text = "Категория"
        }
        label.frame = CGRect (x: 45, y: 5, width: 100, height: 35)
        view.addSubview(label)
        return view
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = newTaskTableView.dequeueReusableCell(withIdentifier: "new_task") as! TodoTextCell
            return cell
        } else {
            let cell = newTaskTableView.dequeueReusableCell(withIdentifier: "category") as! UITableViewCell
            cell.textLabel?.font = UIFont(name: "OpenSans", size: 15)
            cell.textLabel?.text = projects[indexPath.row].title
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .none
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .checkmark
            projectId = projects[indexPath.row].id
        }
    }
}
