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
    let style = AppStyle()
    var persistantData: PersistantData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let name = schoolClass?.name {
            self.navigationItem.title = name
        }
        self.tableView.register(PendingCellView.self, forCellReuseIdentifier: cellID)
        self.navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editClass(_:))), animated: true)
        
        setuUpView()
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let assignments = schoolClass?.assignment {
            return assignments.count
        }
        else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! PendingCellView
        let assignment = assignments[indexPath.row]
        //            cell.textLabel?.text = assignment.name
        cell.className = assignment.schoolClass?.name
        cell.isComplete = assignment.isComplete
        cell.assignmentName = assignment.name
        cell.dueDate = assignment.dueDate as Date?
        if let daysLeft = cell.dueDate?.timeIntervalSinceNow {
            cell.daysLeft = daysLeft/3600/24
            cell.genColors()
        }
        
        cell.layoutSubviews()
        return cell
    }
    
    func setuUpView(){
        if let assignmentSet = schoolClass?.assignment {
            let tempAssignments = assignmentSet.allObjects as! [Assignment]
            let sortedAssignments = tempAssignments.sorted(by: { $0.dueDate?.timeIntervalSinceNow ?? 0 > $1.dueDate?.timeIntervalSinceNow ?? 0 })
            assignments = sortedAssignments
        }
        self.view.backgroundColor = style.backgroundColor
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newView = ViewAssignmentViewController()
        newView.assignment = assignments[indexPath.row]
        newView.persistantData = persistantData
        navigationController?.pushViewController(newView, animated: false)
    }
    
    @objc private func editClass(_ sender:UIBarButtonItem!) {
        if let schoolClass = schoolClass {
            let viewController = EditClassViewController()
            viewController.schoolClass = schoolClass
            navigationController?.pushViewController(viewController, animated: false)
        }  
    }

}
