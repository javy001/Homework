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
        if let assignments = schoolClass?.assignment {
            let assignmentArray = assignments.allObjects as! [Assignment]
            let assignment = assignmentArray[indexPath.row]
//            cell.textLabel?.text = assignment.name
            cell.className = assignment.schoolClass?.name
            cell.assignmentName = assignment.name
            cell.dueDate = assignment.dueDate as Date?
            cell.layoutSubviews()
        }
        return cell
    }
    
    func setuUpView(){
        if let assignmentSet = schoolClass?.assignment {
            assignments = assignmentSet.allObjects as! [Assignment]
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newView = ViewAssignmentViewController()
        newView.assignment = assignments[indexPath.row]
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
