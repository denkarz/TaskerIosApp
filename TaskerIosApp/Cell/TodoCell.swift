//
//  TodoCell.swift
//  TaskerIosApp
//
//  Created by Денис on 24.09.2018.
//  Copyright © 2018 Денис. All rights reserved.
//

import Foundation
import UIKit
import M13Checkbox

class TodoCell: UITableViewCell {
    var todoText: String?
    var label = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let checkbox = M13Checkbox(frame: CGRect(x: 10, y: 0.0, width: 30.0, height: 30.0))
        checkbox.boxType = .square
        checkbox.stateChangeAnimation = .fill
        checkbox.tintColor = UIColor(red:0.23, green:0.69, blue:0.85, alpha:1.0)
        label.frame = CGRect (x: 50, y: 0, width: 100, height: 35)
        label.font = UIFont(name: "OpenSans", size: 15)
        self.addSubview(checkbox)
        self.addSubview(label)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        self.selectionStyle = .none
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        if let todoText = todoText {
            label.text = todoText
        }
    }
}
