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
        self.view.backgroundColor = UIColor.black
        
        let safeOffset = UIApplication.shared.keyWindow?.safeAreaInsets.top ?? 0
        let navOffset = self.navigationController?.navigationBar.frame.size.height ?? 0
        
        
        let container = UIView()
        self.view.addSubview(container)
        container.translatesAutoresizingMaskIntoConstraints = false
        container.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15).isActive = true
        container.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15).isActive = true
        container.topAnchor.constraint(equalTo: self.view.topAnchor, constant: safeOffset + navOffset).isActive = true
        container.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 15).isActive = true
        
        let classLabel = UILabel()
        self.view.addSubview(classLabel)
        classLabel.translatesAutoresizingMaskIntoConstraints = false
        classLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        classLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
        classLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
        classLabel.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
        if let className = assignment?.schoolClass?.name {
            classLabel.text = className
        }
        classLabel.textColor = .white
        
        let assignmentLabel = UILabel()
        self.view.addSubview(assignmentLabel)
        assignmentLabel.translatesAutoresizingMaskIntoConstraints = false
        assignmentLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        assignmentLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
        assignmentLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
        assignmentLabel.topAnchor.constraint(equalTo:classLabel.bottomAnchor).isActive = true
        if let assignment = assignment {
            assignmentLabel.text = assignment.name
        }
        assignmentLabel.textColor = .white
        
        let dateLabel = UILabel()
        self.view.addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
        dateLabel.topAnchor.constraint(equalTo: assignmentLabel.bottomAnchor).isActive = true
        if let assignment = assignment {
            dateLabel.text = "Due on " + assignment.getDateString()
        }
        dateLabel.textColor = .white
        
        let noteLabel = UILabel()
        self.view.addSubview(noteLabel)
        noteLabel.translatesAutoresizingMaskIntoConstraints = false
        noteLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor).isActive = true
        noteLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 30).isActive = true
        noteLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
        noteLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
        noteLabel.numberOfLines = 0
        if let note = assignment?.notes {
            noteLabel.text = note
        }
        noteLabel.textColor = .white
        
        let completeButton = UIButton()
        self.view.addSubview(completeButton)
        completeButton.translatesAutoresizingMaskIntoConstraints = false
        completeButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        completeButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
        completeButton.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        completeButton.topAnchor.constraint(equalTo: noteLabel.bottomAnchor, constant: 25).isActive = true
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
//        let buttonColor = UIColor(red: 0/255, green: 200/255, blue: 136/255, alpha: 1)
        let buttonColor = AppStyle().greenColor
        completeButton.setTitle(title, for: .normal)
        completeButton.setTitleColor(buttonColor, for: .normal)
        completeButton.layer.borderWidth = 1
        completeButton.layer.borderColor = buttonColor.cgColor
        completeButton.addTarget(self, action: #selector(handleComplete(_:)), for: .touchUpInside)
    }
    
    @objc private func editAssignment(_ sender:UIBarButtonItem!) {
        let viewController = EditAssignmentViewController()
        viewController.fetchClasses()
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
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.saveContext()
        navigationController?.popViewController(animated: false)
    }
    

}
