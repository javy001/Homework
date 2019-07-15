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
        
        let classColor = UIButton()
        container.addSubview(classColor)
        classColor.translatesAutoresizingMaskIntoConstraints = false
        
        classColor.topAnchor.constraint(equalTo: container.topAnchor, constant: 15).isActive = true
        classColor.heightAnchor.constraint(equalToConstant: 24).isActive = true
        classColor.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
        classColor.widthAnchor.constraint(equalToConstant: 24).isActive = true
        
        if let viewType = viewType {
            if viewType == "Homework" {
                classColor.backgroundColor = style.backgroundColors[Int(assignment!.schoolClass!.color)]
            }
            else if viewType == "Test" {
                classColor.backgroundColor = style.backgroundColors[Int(exam!.schoolClass!.color)]
            }
            classColor.layer.cornerRadius = 12
        }
        
        
        

        
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
        
        
        let assignmentLabel = genLabelLayout(container: container, topAnchor: classButton.bottomAnchor, topMargin: 10)
        assignmentLabel.numberOfLines = 0
        if let assignment = assignment {
            assignmentLabel.text = "Homework: \n\(assignment.name!) "
        }

        if let exam = exam {
            assignmentLabel.text = "Test: \n\(exam.name!)"
        }
        assignmentLabel.textColor = .black
        
        let separator1 = genHLine(topAnchor: assignmentLabel.bottomAnchor, container: container, topMargin: 10)
        
        let dateLabel = genLabelLayout(container: container, topAnchor: separator1.bottomAnchor, topMargin: 10)

        if let assignment = assignment {
            dateLabel.text = "Due on " + assignment.getDateString()
        }
        if let exam = exam {
            dateLabel.text = "Due on " + exam.getDateString()
        }
        dateLabel.textColor = .black
        
        
        let noteTitle = genLabelLayout(container: container, topAnchor: dateLabel.bottomAnchor, topMargin: 10)
        noteTitle.text = "Notes:"
        
        let separator3 = genHLine(topAnchor: noteTitle.bottomAnchor, container: container, topMargin: 5)
        
        let noteLabel = genLabelLayout(container: container, topAnchor: separator3.bottomAnchor, topMargin: 10)
        noteLabel.numberOfLines = 0
        if let note = assignment?.notes {
            noteLabel.text = note
        }
        if let note = exam?.notes {
            noteLabel.text = note
        }
        noteLabel.textColor = .black
        
        let separator2 = genHLine(topAnchor: noteLabel.bottomAnchor, container: container, topMargin: 10)
        

        let completeButton = UIButton()
        container.addSubview(completeButton)
        completeButton.translatesAutoresizingMaskIntoConstraints = false
        completeButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        completeButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 120).isActive = true
        completeButton.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        completeButton.topAnchor.constraint(equalTo: separator2.bottomAnchor, constant: 25).isActive = true
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
    
    func genHLine(topAnchor: NSLayoutYAxisAnchor, container: UIView, topMargin: CGFloat) -> UIView {
        let view = UIView()
        container.addSubview(view)
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.15)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.topAnchor.constraint(equalTo: topAnchor, constant: topMargin).isActive = true
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        return view
    }
    
    func genLabelLayout(container: UIView, topAnchor: NSLayoutYAxisAnchor, topMargin: CGFloat) -> UILabel {
        let label = UILabel()
        container.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.heightAnchor.constraint(greaterThanOrEqualToConstant: 10).isActive = true
        label.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15).isActive = true
        label.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
        label.topAnchor.constraint(equalTo: topAnchor, constant: topMargin).isActive = true
        
        return label
    }

}
