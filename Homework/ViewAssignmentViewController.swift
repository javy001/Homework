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
    var persistantData: PersistantData?
    var exam: Exam?
    var viewType: String?
    let style = AppStyle()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editAssignment(_:))), animated: true)
        
        navigationItem.title = "\(viewType!) Details"
        setuUpView()

    }
    
    func setuUpView(){
        self.view.backgroundColor = UIColor.white
        
        let safeOffset = UIApplication.shared.keyWindow?.safeAreaInsets.top ?? 0
        let navOffset = self.navigationController?.navigationBar.frame.size.height ?? 0
        
        let container = UIScrollView()
        
        self.view.addSubview(container)
        container.translatesAutoresizingMaskIntoConstraints = false
        container.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15).isActive = true
        container.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15).isActive = true
        container.topAnchor.constraint(equalTo: self.view.topAnchor, constant: safeOffset + navOffset).isActive = true
        container.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
//        let viewTitle = UILabel()
//        container.addSubview(viewTitle)
//        viewTitle.translatesAutoresizingMaskIntoConstraints = false
//        viewTitle.heightAnchor.constraint(equalToConstant: 28).isActive = true
//        viewTitle.topAnchor.constraint(equalTo: container.topAnchor,constant: 15).isActive = true
//        viewTitle.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
//        viewTitle.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
//        viewTitle.text = "\(viewType!) Details"
//        viewTitle.font = UIFont(name: "Avenir-Heavy", size: 24)
        
        let classColor = UIButton()
        container.addSubview(classColor)
        classColor.translatesAutoresizingMaskIntoConstraints = false
        
        classColor.topAnchor.constraint(equalTo: container.topAnchor, constant: 15).isActive = true
        classColor.heightAnchor.constraint(equalToConstant: 24).isActive = true
        classColor.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
        classColor.widthAnchor.constraint(equalToConstant: 24).isActive = true
        
        classColor.backgroundColor = style.backgroundColors[Int(assignment!.schoolClass!.color)]
        classColor.layer.cornerRadius = 12

        
        let classButton = UIButton(type: .system)
        container.addSubview(classButton)
        classButton.translatesAutoresizingMaskIntoConstraints = false
        classButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 30).isActive = true
        classButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 50).isActive = true
        classButton.leadingAnchor.constraint(equalTo: classColor.trailingAnchor, constant: 4).isActive = true
        classButton.centerYAnchor.constraint(equalTo: classColor.centerYAnchor).isActive = true
        if let className = assignment?.schoolClass?.name {
            classButton.setTitle(className, for: .normal)
        }
        if let exam = exam {
            classButton.setTitle(exam.schoolClass?.name, for: .normal)
        }

        classButton.titleLabel?.font = UIFont(name: "Avenir-Medium", size: 20)
        classButton.addTarget(self, action: #selector(goToClass(_:)), for: .touchUpInside)
        
        
        let assignmentLabel = UILabel()
        container.addSubview(assignmentLabel)
        assignmentLabel.translatesAutoresizingMaskIntoConstraints = false
        assignmentLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        assignmentLabel.trailingAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        assignmentLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
        assignmentLabel.topAnchor.constraint(equalTo:classButton.bottomAnchor).isActive = true
        assignmentLabel.numberOfLines = 0
        if let assignment = assignment {
            assignmentLabel.text = "Homework: \n\(assignment.name!) "
        }

        if let exam = exam {
            assignmentLabel.text = "Test: \n\(exam.name!)"
        }
        assignmentLabel.textColor = .black

        let dateLabel = UILabel()
        container.addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
        dateLabel.topAnchor.constraint(equalTo: assignmentLabel.bottomAnchor).isActive = true
        if let assignment = assignment {
            dateLabel.text = "Due on " + assignment.getDateString()
        }
        if let exam = exam {
            dateLabel.text = "Due on " + exam.getDateString()
        }
        dateLabel.textColor = .black

        let noteLabel = UILabel()
        container.addSubview(noteLabel)
        noteLabel.translatesAutoresizingMaskIntoConstraints = false
        noteLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor).isActive = true
        noteLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 0).isActive = true
        noteLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
        noteLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15).isActive = true
        noteLabel.numberOfLines = 0
        if let note = assignment?.notes {
            noteLabel.text = "Notes: \n\(note)"
        }
        if let note = exam?.notes {
            noteLabel.text = "Notes: \n\(note)"
        }
        noteLabel.textColor = .black

        let completeButton = UIButton()
        container.addSubview(completeButton)
        completeButton.translatesAutoresizingMaskIntoConstraints = false
        completeButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        completeButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 120).isActive = true
        completeButton.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        completeButton.topAnchor.constraint(equalTo: noteLabel.bottomAnchor, constant: 25).isActive = true
        var title: String
        var isComplete = false
        if viewType == "Homework" {
            isComplete = assignment!.isComplete
        }
        else {
            isComplete = exam!.isComplete
        }

        if isComplete {
            title = "Mark Pending"
        }
        else {
            title = "Complete"
        }

        let buttonColor = AppStyle().greenColor
        completeButton.setTitle(title, for: .normal)
        completeButton.setTitleColor(buttonColor, for: .normal)
        completeButton.layer.borderWidth = 1
        completeButton.layer.borderColor = buttonColor.cgColor
        completeButton.layer.cornerRadius = 7
        completeButton.addTarget(self, action: #selector(handleComplete(_:)), for: .touchUpInside)

        let bottomView = UIView()
        container.addSubview(bottomView)
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        
        bottomView.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
        bottomView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -10).isActive = true
        bottomView.bottomAnchor.constraint(equalTo: container.bottomAnchor).isActive = true
        bottomView.topAnchor.constraint(equalTo: completeButton.bottomAnchor).isActive = true
        bottomView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    
    @objc private func editAssignment(_ sender:UIBarButtonItem!) {
        let viewController = EditAssignmentViewController()
        viewController.persistantData = persistantData
        viewController.fetchClasses()
        if let assignment = assignment {
            viewController.assignment = assignment
            viewController.viewType = "Homework"
        }
        
        if let exam = exam {
            viewController.exam = exam
            viewController.viewType = "Test"
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
        
        if let exam = exam {
            if exam.isComplete {
                exam.isComplete = false
            } else {
                exam.isComplete = true
            }
        }
        
        persistantData!.appDelegate.saveContext()
        navigationController?.popViewController(animated: false)
    }
    
    @objc func goToClass(_ sender: UIButton) {
        let viewController = ClassAssignmentsViewController()
        if let schoolClass = assignment?.schoolClass {
            viewController.schoolClass = schoolClass
        }
        
        if let schoolClass = exam?.schoolClass {
            viewController.schoolClass = schoolClass
        }
        
        viewController.persistantData = persistantData
        navigationController?.pushViewController(viewController, animated: false)
    }
    

}
