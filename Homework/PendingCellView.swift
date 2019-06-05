//
//  PendingCellView.swift
//  Homework
//
//  Created by Javier Quintero on 5/22/19.
//  Copyright © 2019 Javier Quintero. All rights reserved.
//

import UIKit

class PendingCellView: UITableViewCell {
    
    var className: String?
    var assignmentName: String?
    var dueDate: Date?
    var daysLeft: Double?
    var cellColor = UIColor.gray
    var textMainColor = UIColor.white
    let style = AppStyle()
    
    var classNameView: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont(name: "Avenir-Heavy", size: 17)
        return view
    }()
    
    var assignmentNameView: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont(name: "Avenir-Book", size: 15)
        view.textColor = .white
        return view
    }()
    
    var dueDateView: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont(name: "Avenir-Light", size: 15)
        view.textColor = .white
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func genColors() {
        if let daysLeft = daysLeft {
            if daysLeft <= 0 {
                cellColor = style.genRedColor(alpha: 0.5)
                textMainColor = style.genRedColor(alpha: 1)
            }
            else if daysLeft <= 2 {
                cellColor = style.genOrangeColor(alpha: 0.5)
                textMainColor = style.genOrangeColor(alpha: 1)
            }
            else {
                cellColor = style.genGreenColor(alpha: 0.5)
                textMainColor = style.genGreenColor(alpha: 1)
            }
        }
        classNameView.textColor = textMainColor
        assignmentNameView.textColor = textMainColor
        dueDateView.textColor = textMainColor
        self.backgroundColor = cellColor
    }
    
    func setUp() {
        self.layer.borderWidth = 3
//        self.layer.borderColor = UIColor(red: 91/255, green: 91/255, blue: 91/255, alpha: 1).cgColor
        self.layer.borderColor = UIColor.black.cgColor
        self.addSubview(classNameView)
        
        classNameView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        classNameView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        classNameView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        classNameView.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        self.addSubview(assignmentNameView)
        
        assignmentNameView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        assignmentNameView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        assignmentNameView.topAnchor.constraint(equalTo: classNameView.bottomAnchor).isActive = true
        assignmentNameView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -7).isActive = true
        
        self.addSubview(dueDateView)
        
        dueDateView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        dueDateView.leadingAnchor.constraint(equalTo: classNameView.trailingAnchor, constant: 10).isActive = true
        dueDateView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        dueDateView.bottomAnchor.constraint(equalTo: assignmentNameView.topAnchor).isActive = true
        dueDateView.textAlignment = .right
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if let className = className {
            classNameView.text = className
        }
        
        if let assignmentName = assignmentName {
            assignmentNameView.text = assignmentName
        }
        
        if let dueDate = dueDate {
            let formatter = DateFormatter()
            formatter.dateFormat = "E, MMM-dd"
            let dateString = formatter.string(from: dueDate)
            dueDateView.text = dateString
        }
    }
}
