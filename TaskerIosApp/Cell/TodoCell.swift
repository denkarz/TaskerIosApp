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
import Alamofire


class TodoCell: UITableViewCell {
    var todo: Todo!
    var label = UITextView()
    var checkbox = M13Checkbox(frame: CGRect(x: 10, y: 0.0, width: 30.0, height: 30.0))
    var defa = [NSAttributedString.Key.font : UIFont(name: "OpenSans", size: 15)]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addSubview(checkbox)
        self.addSubview(label)
        checkbox.boxType = .square
        checkbox.stateChangeAnimation = .fill
        checkbox.tintColor = UIColor(red:0.23, green:0.69, blue:0.85, alpha:1.0)
        checkbox.addTarget(self, action: #selector(onChangeMe(paramTarget:)), for: UIControl.Event.valueChanged)
        
        label.frame = CGRect (x: 50, y: 0, width: 300, height: 35)
        label.font = UIFont(name: "OpenSans", size: 15)
        label.isScrollEnabled = false
        checkbox.leftAnchor.constraint(equalTo: self.leftAnchor).isActive  = true
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
        let attributedString = NSMutableAttributedString(string: todo!.text)
        if (todo?.is_completed == true) {
            checkbox.setCheckState(.checked, animated: true)
            attributedString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributedString.length))
            attributedString.addAttributes(defa as [NSAttributedString.Key : Any], range:  NSMakeRange(0, attributedString.length))
            label.attributedText = attributedString
        } else {
            checkbox.setCheckState(.unchecked, animated: true)
            attributedString.addAttributes(defa as [NSAttributedString.Key : Any], range:  NSMakeRange(0, attributedString.length))
            label.attributedText = attributedString
        }
    }
    @objc func onChangeMe(paramTarget: M13Checkbox)  {
//        let url = "http://192.168.1.68:3000/custom_controller/update"
        let url = "https://limitless-dawn-57124.herokuapp.com/custom_controller/update"
        let attributedString = NSMutableAttributedString(string: self.label.text)
        if (checkbox.checkState == .checked) {
            attributedString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributedString.length))
            attributedString.addAttributes(defa as [NSAttributedString.Key : Any], range:  NSMakeRange(0, attributedString.length))
            label.attributedText = attributedString
        } else {
            attributedString.addAttributes(defa as [NSAttributedString.Key : Any], range:  NSMakeRange(0, attributedString.length))
            label.attributedText = attributedString
        }
        let parameters: Parameters = ["todo": ["id": todo.id]]
        Alamofire.request(url, method: .put, parameters: parameters)
    }
}
