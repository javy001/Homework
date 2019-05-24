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
    
    var classNameView: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var assignmentNameView: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var dueDateView: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp() {
        self.addSubview(classNameView)
        
        classNameView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        classNameView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        classNameView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        classNameView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        self.addSubview(assignmentNameView)
        
        assignmentNameView.leadingAnchor.constraint(equalTo: classNameView.trailingAnchor).isActive = true
        assignmentNameView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        assignmentNameView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        assignmentNameView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        self.addSubview(dueDateView)
        
        dueDateView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        dueDateView.leadingAnchor.constraint(equalTo: assignmentNameView.trailingAnchor).isActive = true
        dueDateView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        dueDateView.heightAnchor.constraint(equalToConstant: 40).isActive = true
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
            formatter.dateFormat = "yyyy-MM-dd"
            let dateString = formatter.string(from: dueDate)
            dueDateView.text = dateString
        }
    }
}
