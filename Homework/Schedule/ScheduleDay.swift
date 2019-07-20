//
//  ScheduleDay.swift
//  Homework
//
//  Created by Javier Quintero on 7/19/19.
//  Copyright © 2019 Javier Quintero. All rights reserved.
//

import UIKit

protocol ScheduleDayDelegate: class {
    func selectDate(sender: ScheduleDay)
}

class ScheduleDay: UIView {
    
    weak var delegate:ScheduleDayDelegate?
    var assignments: [Assignment] = []
    var exams: [Exam] = []
    var day: Int?
    var date: Date?
    var willShow = false
    var hasData = false
    let dateButton = UIButton()
    let indicator = UIButton()
    
    func setUp() {
        
        self.backgroundColor = .white
        
        self.addSubview(dateButton)
        dateButton.translatesAutoresizingMaskIntoConstraints = false
        dateButton.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        dateButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        dateButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        dateButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        dateButton.layer.cornerRadius = 15
        dateButton.addTarget(self, action: #selector(handleTap(_:)), for: .touchUpInside)
        
        self.addSubview(indicator)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.topAnchor.constraint(equalTo: dateButton.bottomAnchor, constant: 1).isActive = true
        indicator.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        indicator.heightAnchor.constraint(equalToConstant: 5).isActive = true
        indicator.widthAnchor.constraint(equalToConstant: 5).isActive = true
        indicator.layer.cornerRadius = 2.5
        
        update()
        
    }
    
    func update() {
        if hasData {
            indicator.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        }
        else {
            indicator.backgroundColor = .white
        }
        
        if willShow {
            dateButton.setTitle("\(day!)", for: .normal)
        }
        else {
            dateButton.setTitle(" ", for: .normal)
        }
    }
    
    @objc func handleTap(_ sender: UIButton) {
        delegate?.selectDate(sender: self)
    }
}
