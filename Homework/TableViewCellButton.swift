//
//  TableViewCellButton.swift
//  Homework
//
//  Created by Javier Quintero on 7/2/19.
//  Copyright © 2019 Javier Quintero. All rights reserved.
//

import UIKit

class TableViewCellButton: UITableViewCell {
    
    let style = AppStyle()
    var name: String?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp() {
        if self.textLabel?.text == "Homework" {
            self.backgroundColor = UIColor(red: 113/255, green: 34/255, blue: 250/255, alpha: 0.3)
            self.textLabel?.textColor = UIColor(red: 113/255, green: 34/255, blue: 250/255, alpha: 1)
        }
        else if self.textLabel?.text == "Test" {
            self.backgroundColor = UIColor(red: 255/255, green: 34/255, blue: 129/255, alpha: 0.3)
            self.textLabel?.textColor = UIColor(red: 255/255, green: 34/255, blue: 129/255, alpha: 1)
        }
        else {
            self.backgroundColor = UIColor(red: 241/255, green: 72/255, blue: 251/255, alpha: 0.3)
            self.textLabel?.textColor = UIColor(red: 241/255, green: 72/255, blue: 251/255, alpha: 1)
        }
        
        self.layer.borderWidth = 3
        self.layer.borderColor = UIColor.white.cgColor
        self.textLabel?.font = UIFont(name: "Avenir-Heavy", size: 18)

    }

}
