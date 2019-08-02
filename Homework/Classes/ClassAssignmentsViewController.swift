//
//  ViewClassViewController.swift
//  Homework
//
//  Created by Javier Quintero on 5/24/19.
//  Copyright © 2019 Javier Quintero. All rights reserved.
//

import UIKit
import MessageUI

class ClassAssignmentsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MFMailComposeViewControllerDelegate, UINavigationControllerDelegate {

    var schoolClass: SchoolClass?
    var cellID = "cellID"
    var assignments: [Assignment] = []
    var exams: [Exam] = []
    var rows: [[AnyObject]] = [[]]
    var sectionCount = 0
    var sections: [String] = []
    let style = AppStyle()
    var persistantData: PersistantData?
    let tableView = UITableView()
    var tableOffset = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        setInitialConditions()
        tableView.reloadData()
        
        if let name = schoolClass?.name {
            self.navigationItem.title = name
        }
        
        tableView.register(PendingCellView.self, forCellReuseIdentifier: cellID)
        self.navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editClass(_:))), animated: true)
        
        setUpView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! PendingCellView
        let item = rows[indexPath.section][indexPath.row]
        cell.className = item.schoolClass?.name
        cell.isComplete = item.isComplete
        cell.assignmentName = item.name
        cell.dueDate = item.dueDate as Date?
        if let color = item.schoolClass?.color {
            cell.colorIndex = Int(color)
        }
        if let daysLeft = cell.dueDate?.timeIntervalSinceNow {
            cell.daysLeft = daysLeft/3600/24
        }
        cell.genColors()
        cell.layoutSubviews()
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .white
        let label = UILabel()
        view.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        label.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        label.text = sections[section]
        label.font = UIFont(name: "Avenir-Heavy", size: 22)
        
        return view
    }
    
    func setUpView(){
        if let assignmentSet = schoolClass?.assignment {
            let tempAssignments = assignmentSet.allObjects as! [Assignment]
            let sortedAssignments = tempAssignments.sorted(by: { $0.dueDate?.timeIntervalSinceNow ?? 0 > $1.dueDate?.timeIntervalSinceNow ?? 0 })
            assignments = sortedAssignments
            if assignments.count > 0 {
                rows[0] = assignments
                sectionCount += 1
                sections.insert("Homework", at: 0)
            }
            
        }
        
        if let tests = schoolClass?.exam {
            let tempExams = tests.allObjects as! [Exam]
            if tempExams.count > 0 {
                let sortedExams = tempExams.sorted(by: { $0.dueDate?.timeIntervalSinceNow ?? 0 > $1.dueDate?.timeIntervalSinceNow ?? 0 })
                exams = sortedExams
                rows.insert(exams, at: 0)
                sections.insert("Tests", at: 0)
                sectionCount += 2
            }
        }
        self.view.backgroundColor = style.backgroundColor
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        let teacherName = UILabel()
        self.view.addSubview(teacherName)
        teacherName.translatesAutoresizingMaskIntoConstraints = false
        teacherName.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        teacherName.leadingAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        teacherName.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15).isActive = true
        teacherName.heightAnchor.constraint(equalToConstant: 25).isActive = true
        teacherName.text = schoolClass?.teacherName
        teacherName.textAlignment = .right
        if schoolClass?.teacherName?.count ?? 0 > 0 {
            tableOffset = 30
        }
        
        let location = UILabel()
        self.view.addSubview(location)
        location.translatesAutoresizingMaskIntoConstraints = false
        location.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        location.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15).isActive = true
        location.trailingAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        location.heightAnchor.constraint(greaterThanOrEqualToConstant: 25).isActive = true
        location.numberOfLines = 0
        location.text = schoolClass?.location
        if schoolClass?.location?.count ?? 0 > 0 {
            tableOffset = 30
        }
        
        let email = UILabel()
        self.view.addSubview(email)
        email.translatesAutoresizingMaskIntoConstraints = false
        email.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: CGFloat(tableOffset)).isActive = true
        email.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15).isActive = true
        email.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15).isActive = true
        email.heightAnchor.constraint(equalToConstant: 25).isActive = true
        email.text = schoolClass?.emailAddress
        email.textColor = .blue
        email.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(emailTap(_:)))
        email.addGestureRecognizer(tap)
        if schoolClass?.emailAddress?.count ?? 0 > 0 {
            tableOffset += 30
        }
        
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: CGFloat(10 + tableOffset)).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newView = ViewAssignmentViewController()
        if sections[indexPath.section] == "Homework" {
            newView.assignment = assignments[indexPath.row]
            newView.viewType = "Homework"
            
        }
        else if sections[indexPath.section] == "Tests" {
            newView.exam = exams[indexPath.row]
            newView.viewType = "Test"
        }
        
        newView.persistantData = persistantData
        navigationController?.pushViewController(newView, animated: true)
    }
    
    @objc private func editClass(_ sender:UIBarButtonItem!) {
        if let schoolClass = schoolClass {
            let viewController = EditClassViewController()
            viewController.schoolClass = schoolClass
            viewController.persistantData = persistantData
            navigationController?.pushViewController(viewController, animated: false)
        }  
    }
    
    func setInitialConditions() {
        rows = [[]]
        exams = []
        assignments = []
        sections = []
        sectionCount = 0
    }
    
    @objc func emailTap(_ sender:UITapGestureRecognizer) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.delegate = self
            mail.setToRecipients([schoolClass?.emailAddress ?? ""])
            mail.setSubject(schoolClass?.name ?? "")
            
            present(mail, animated: true)
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        dismiss(animated: true)
    }
    
}
