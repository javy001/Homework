//
//  PendingViewController.swift
//  Homework
//
//  Created by Javier Quintero on 5/11/19.
//  Copyright © 2019 Javier Quintero. All rights reserved.
//

import UIKit

class PendingViewController: UITableViewController {

    var cellID = "cellID"
    var assignments: [Assignment] = []
    var exams: [Exam] = []
    var sections: [String] = []
    var rows: [[AnyObject]] = [[]]
    var style = AppStyle()
    var persistantData: PersistantData?
    var sectionCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assignments = []
        tableView.register(PendingCellView.self, forCellReuseIdentifier: cellID)
        navigationItem.title = "Pending Items"
        self.view.backgroundColor = style.backgroundColor
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        self.navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem(_:))), animated: true)
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setInitialConditions()
        do{
            let fetchRequest = Assignment.assignmentFetchRequest()
            fetchRequest.predicate = NSPredicate(format: "isComplete == false")
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: #keyPath(Assignment.dueDate), ascending: true)]
            assignments = try persistantData!.context.fetch(fetchRequest)
            if assignments.count > 0 {
                sectionCount += 1
                rows[0] = assignments
                sections.insert("Homework", at: 0)
            }
            
            self.tableView.reloadData()
        } catch {
            print("fetch failed")
        }
        
        do{
            let fetchRequest = Exam.examFetchRequest()
            fetchRequest.predicate = NSPredicate(format: "isComplete == false")
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: #keyPath(Exam.dueDate), ascending: true)]
            exams = try persistantData!.context.fetch(fetchRequest)
            if exams.count > 0 {
                sectionCount += 1
                rows.insert(exams, at: 0)
                sections.insert("Tests", at: 0)
            }
            self.tableView.reloadData()
        } catch {
            print("fetch failed")
        }
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

    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows[section].count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let assignment = rows[indexPath.section][indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! PendingCellView
        
        cell.className = assignment.schoolClass?.name
        cell.isComplete = assignment.isComplete
        cell.assignmentName = assignment.name
        cell.dueDate = assignment.dueDate as Date?
        if let daysLeft = cell.dueDate?.timeIntervalSinceNow {
            cell.daysLeft = daysLeft/3600/24
        }
        
        if let color = assignment.schoolClass?.color {
            cell.colorIndex = Int(color)
        }
        cell.genColors()
        cell.layoutSubviews()
        return cell
        
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = rows[indexPath.section][indexPath.row]
        let viewController = ViewAssignmentViewController()
        if sections[indexPath.section] == "Homework" {
            viewController.assignment = (item as! Assignment)
            viewController.viewType = sections[indexPath.section]
        }
        else {
            viewController.exam = (item as! Exam)
            viewController.viewType = "Test"
        }
        viewController.persistantData = persistantData
        
        navigationController?.pushViewController(viewController, animated: false)
    }
    
    func setInitialConditions() {
        rows = [[]]
        sections = []
        sectionCount = 0
    }
    
    @objc func addItem(_ sender:UIBarButtonItem){
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let homeWorkAction = UIAlertAction(title: "Homework", style: .default) { (action) in
            self.checkForClasses()
            let viewController = AddAssignmentViewController()
            viewController.addType = "Homework"
            viewController.persistantData = self.persistantData
            self.navigationController?.pushViewController(viewController, animated: false)
            
        }
        let testAction = UIAlertAction(title: "Test", style: .default) { (action) in
            self.checkForClasses()
            let viewController = AddAssignmentViewController()
            viewController.addType = "Test"
            viewController.persistantData = self.persistantData
            self.navigationController?.pushViewController(viewController, animated: false)
        }
        let classAction = UIAlertAction(title: "Class", style: .default) { (action) in
            let viewController = AddClassViewController()
            viewController.persistantData = self.persistantData
            self.navigationController?.pushViewController(viewController, animated: false)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
        }
        for action in [homeWorkAction, testAction, classAction, cancelAction] {
            alert.addAction(action)
        }
        present(alert, animated: true)
    }
    
    func checkForClasses() {
        let context = persistantData!.context
        do {
            let schoolClasses = try context.fetch(SchoolClass.fetchRequest()) as! [SchoolClass]
            if !(schoolClasses.count > 0) {
                let alert = UIAlertController(title: "No Classes",
                                              message: "You need to add a class before you can add a test or homework assignment.",
                                              preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK",
                                             style: .default) { (action) in
                }
                alert.addAction(okAction)
                present(alert, animated: true) {
                    
                }
            }
        }
        catch {
            print("Failed Fetch")
        }
        
    }

}
