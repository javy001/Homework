//
//  ViewAssignmentViewController.swift
//  Homework
//
//  Created by Javier Quintero on 5/23/19.
//  Copyright © 2019 Javier Quintero. All rights reserved.
//

import UIKit

class ViewAssignmentViewController: UIViewController {
    
    var assignment: Assignment?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editAssignment(_:))), animated: true)
        
        setuUpView()

    }
    
    func setuUpView(){
        self.view.backgroundColor = UIColor.white
        
        let classLabel = UILabel()
        self.view.addSubview(classLabel)
        classLabel.translatesAutoresizingMaskIntoConstraints = false
        classLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        classLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        classLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        classLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100).isActive = true
        if let className = assignment?.schoolClass?.name {
            classLabel.text = className
        }
        
        let assignmentLabel = UILabel()
        self.view.addSubview(assignmentLabel)
        assignmentLabel.translatesAutoresizingMaskIntoConstraints = false
        assignmentLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        assignmentLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        assignmentLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        assignmentLabel.topAnchor.constraint(equalTo:classLabel.bottomAnchor).isActive = true
        if let assignment = assignment {
            assignmentLabel.text = assignment.name
        }
        
        let dateLabel = UILabel()
        self.view.addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        dateLabel.topAnchor.constraint(equalTo: assignmentLabel.bottomAnchor).isActive = true
        if let assignment = assignment {
            dateLabel.text = "Due on " + assignment.getDateString()
        }
        
        let completeButton = UIButton()
        self.view.addSubview(completeButton)
        completeButton.translatesAutoresizingMaskIntoConstraints = false
        completeButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        completeButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
        completeButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        completeButton.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 25).isActive = true
        var title: String
        if let assignment = assignment {
            if assignment.isComplete {
                title = "Mark Pending"
            }
            else {
               title = "Complete"
            }
        }
        else {
            title = "Complete"
        }
        completeButton.setTitle(title, for: .normal)
        completeButton.setTitleColor(UIColor.black, for: .normal)
        completeButton.layer.borderWidth = 1
        completeButton.layer.borderColor = UIColor.black.cgColor
        completeButton.addTarget(self, action: #selector(handleComplete(_:)), for: .touchUpInside)
    }
    
    @objc private func editAssignment(_ sender:UIBarButtonItem!) {
        let viewController = EditAssignmentViewController()
        if let assignment = assignment {
            viewController.assignment = assignment
        }
        navigationController?.pushViewController(viewController, animated: false)
    }
        
    
    @objc private func handleComplete(_ sender:UIButton!) {
        if let assignment = assignment {
            if assignment.isComplete {
                assignment.isComplete = false
            } else {
                assignment.isComplete = true
            }
        }
        navigationController?.popViewController(animated: false)
    }
    

}
