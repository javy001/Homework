//
//  ViewClassViewController.swift
//  Homework
//
//  Created by Javier Quintero on 5/24/19.
//  Copyright © 2019 Javier Quintero. All rights reserved.
//

import UIKit

class ClassAssignmentsViewController: UITableViewController {

    var schoolClass: SchoolClass?
    var cellID = "cellID"
    var assignments: [Assignment] = []
    var exams: [Exam] = []
    var rows: [[AnyObject]] = [[]]
    var sectionCount = 0
    var sections: [String] = []
    let style = AppStyle()
    var persistantData: PersistantData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInitialConditions()
        self.tableView.reloadData()
        
        if let name = schoolClass?.name {
            self.navigationItem.title = name
        }
        self.tableView.register(PendingCellView.self, forCellReuseIdentifier: cellID)
        self.navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editClass(_:))), animated: true)
        
        setuUpView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
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
    
    func setuUpView(){
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
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
        navigationController?.pushViewController(newView, animated: false)
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
    
}
