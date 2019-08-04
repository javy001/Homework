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
    var tableOffset: UILabel?
    var teacherName = UILabel()
    var email = UILabel()
    var location = UILabel()
    
    
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
        teacherName.text = schoolClass?.teacherName
        email.text = schoolClass?.emailAddress
        location.text = schoolClass?.location
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
        
        let flashCard = UILabel()
        self.view.addSubview(flashCard)
        flashCard.translatesAutoresizingMaskIntoConstraints = false
        flashCard.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        flashCard.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15).isActive = true
        flashCard.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15).isActive = true
        flashCard.heightAnchor.constraint(equalToConstant: 25).isActive = true
        flashCard.text = "Flash Cards"
        flashCard.textColor = UIColor(red: 0, green: 122/255, blue: 1, alpha: 1)
        
        let flashTap = UITapGestureRecognizer(target: self, action: #selector(goToFlashCards(_:)))
        flashCard.isUserInteractionEnabled = true
        flashCard.addGestureRecognizer(flashTap)
        tableOffset = flashCard
        
        let hLine0 = UIView()
        self.view.addSubview(hLine0)
        hLine0.translatesAutoresizingMaskIntoConstraints = false
        hLine0.topAnchor.constraint(equalTo: flashCard.bottomAnchor).isActive = true
        hLine0.heightAnchor.constraint(equalToConstant: 1).isActive = true
        hLine0.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        hLine0.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        hLine0.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.15)
        hLine0.isHidden = true
        
        
        self.view.addSubview(teacherName)
        teacherName.translatesAutoresizingMaskIntoConstraints = false
        teacherName.topAnchor.constraint(equalTo: flashCard.bottomAnchor, constant: 10).isActive = true
        teacherName.trailingAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        teacherName.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15).isActive = true
        teacherName.heightAnchor.constraint(greaterThanOrEqualToConstant: 25).isActive = true
        teacherName.text = schoolClass?.teacherName
        teacherName.textAlignment = .left
        teacherName.numberOfLines = 0
        if schoolClass?.teacherName?.count ?? 0 > 0 {
            tableOffset = teacherName
        }
        
        self.view.addSubview(location)
        location.translatesAutoresizingMaskIntoConstraints = false
        location.topAnchor.constraint(equalTo: flashCard.bottomAnchor, constant: 10).isActive = true
        location.leadingAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        location.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15).isActive = true
        location.heightAnchor.constraint(greaterThanOrEqualToConstant: 25).isActive = true
        location.numberOfLines = 0
        location.textAlignment = .right
        location.text = schoolClass?.location
        if schoolClass?.location?.count ?? 0 > 0 {
            tableOffset = location
        }
        
        self.view.addSubview(email)
        email.translatesAutoresizingMaskIntoConstraints = false
        if let offset = tableOffset  {
            email.topAnchor.constraint(equalTo: offset.bottomAnchor, constant: 10).isActive = true
        }
        else {
            email.topAnchor.constraint(equalTo: flashCard.bottomAnchor, constant: 10).isActive = true
        }
        
        email.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15).isActive = true
        email.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15).isActive = true
        email.heightAnchor.constraint(equalToConstant: 25).isActive = true
        email.text = schoolClass?.emailAddress
        email.textColor = UIColor(red: 0, green: 122/255, blue: 1, alpha: 1)
        email.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(emailTap(_:)))
        email.addGestureRecognizer(tap)
        if schoolClass?.emailAddress?.count ?? 0 > 0 {
            tableOffset = email
        }
        
        if tableOffset != flashCard {
            hLine0.isHidden = false
        }
        
        let hLine = UIView()
        self.view.addSubview(hLine)
        hLine.translatesAutoresizingMaskIntoConstraints = false
        hLine.topAnchor.constraint(equalTo: tableOffset!.bottomAnchor, constant: 5).isActive = true
        hLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
        hLine.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        hLine.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        hLine.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.15)
        
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.topAnchor.constraint(equalTo: hLine.bottomAnchor, constant: 5).isActive = true
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
    
    @objc func goToFlashCards(_ sender: UITapGestureRecognizer) {
        let vc = FlashDecksViewController()
        vc.persistantData = persistantData
        vc.schoolClass = self.schoolClass
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
