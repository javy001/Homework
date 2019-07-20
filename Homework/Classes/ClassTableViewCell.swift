//
//  ClassTableViewCell.swift
//  Homework
//
//  Created by Javier Quintero on 7/6/19.
//  Copyright © 2019 Javier Quintero. All rights reserved.
//

import UIKit

class ClassTableViewCell: UITableViewCell {

    let style = AppStyle()
    var name: String?
    var colorIndex = 0
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp() {
        
        self.backgroundColor = style.backgroundColors[colorIndex]
        self.textLabel?.textColor = style.textColors[colorIndex]
        
        self.layer.borderWidth = 3
        self.layer.borderColor = UIColor.white.cgColor
        self.textLabel?.font = UIFont(name: "Avenir-Heavy", size: 18)
        
    }


}
