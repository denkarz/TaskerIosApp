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
    var todo: Todo?
    var label = UITextView()
    var checkbox = M13Checkbox(frame: CGRect(x: 10, y: 0.0, width: 30.0, height: 30.0))
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addSubview(checkbox)
        self.addSubview(label)
        checkbox.boxType = .square
        checkbox.stateChangeAnimation = .fill
        checkbox.tintColor = UIColor(red:0.23, green:0.69, blue:0.85, alpha:1.0)
        label.frame = CGRect (x: 50, y: 0, width: 300, height: 35)
        label.font = UIFont(name: "OpenSans", size: 15)
        label.isScrollEnabled = false
        checkbox.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        checkbox.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        checkbox.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        checkbox.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        
        label.leftAnchor.constraint(equalTo: checkbox.rightAnchor).isActive = true
        label.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        label.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        label.text = todo!.text
        if (todo?.is_completed == true) {
            checkbox.setCheckState(.checked, animated: true)
        } else {
            checkbox.setCheckState(.unchecked, animated: true)
        }
    }
}
