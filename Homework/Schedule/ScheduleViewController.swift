//
//  ScheduleViewController.swift
//  Homework
//
//  Created by Javier Quintero on 7/19/19.
//  Copyright © 2019 Javier Quintero. All rights reserved.
//

import UIKit

class ScheduleViewController: UIViewController, ScheduleViewDelegate, UITableViewDataSource, UITableViewDelegate {

    let calendar = ScheduleView()
    var persistantData: PersistantData?
    var assignments: [Assignment] = []
    var exams: [Exam] = []
    var sections: [String] = []
    var rows: [[AnyObject]] = [[]]
    var sectionCount = 0
    let cellID = "cellID"
    let tableView = UITableView()
    var selectedDay: ScheduleDay?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        self.navigationItem.title = "Schedule"
        navigationController?.navigationBar.prefersLargeTitles = true
        calendar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PendingCellView.self, forCellReuseIdentifier: cellID)
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        let filterButton = UIBarButtonItem(image: UIImage(named: "filter"), style: .plain, target: self, action: #selector(filterData(_:)))
        
        self.navigationItem.setLeftBarButton(filterButton, animated: true)
        self.navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem(_:))), animated: true)
        setUp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        resetTable()
    }
    
    func setUp() {
        let safeOffset = UIApplication.shared.keyWindow?.safeAreaInsets.top ?? 0
        let navOffset = self.navigationController?.navigationBar.frame.size.height ?? 0
        
        calendar.persistantData = persistantData
        self.view.addSubview(calendar)
        calendar.superWidth = self.view.frame.width
        calendar.translatesAutoresizingMaskIntoConstraints = false
        calendar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        calendar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        calendar.topAnchor.constraint(equalTo: self.view.topAnchor, constant: safeOffset + navOffset).isActive = true
        let height = (8 * 30) + (6 * 6) + (3 * 3) + (5 * 2) + 1
        calendar.heightAnchor.constraint(equalToConstant: CGFloat(height)).isActive = true
        
        calendar.genCalendar(seedDate: Date())
        
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: calendar.bottomAnchor, constant: 1).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionCount
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
        label.font = UIFont(name: "Avenir-Heavy", size: 18)
        
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
    
    @objc func filterData(_ sender:UIBarButtonItem){
        let alert = UIAlertController(title: "Filter Items", message: nil, preferredStyle: .actionSheet)
        let completeActoin = UIAlertAction(title: "Completed", style: .default) { (action) in
            self.calendar.filter = NSPredicate(format: "isComplete == true")
            self.calendar.updateData(seedDate: self.calendar.firstDate!)
            self.resetTable()
        }
        let pendingAction = UIAlertAction(title: "Pending", style: .default) { (action) in
            self.calendar.filter = NSPredicate(format: "isComplete == false")
            self.calendar.updateData(seedDate: self.calendar.firstDate!)
            self.resetTable()
        }
        let allAction = UIAlertAction(title: "All", style: .default) { (action) in
            self.calendar.filter = nil
            self.calendar.updateData(seedDate: self.calendar.firstDate!)
            self.resetTable()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
        }
        for action in [allAction, pendingAction, completeActoin, cancelAction] {
            alert.addAction(action)
        }
        present(alert, animated: true)
    }
    
    func resetTable() {
        if let day = selectedDay {
            calendar.updateData(seedDate: day.date!)
            day.handleTap(day.dateButton)
        }
        tableView.reloadData()
    }
    
    func dateSelected(day: ScheduleDay) {
        sections = []
        sectionCount = 0
        rows = [[]]
        assignments = day.assignments
        exams = day.exams
        selectedDay = day
        if day.assignments.count > 0 {
            sections.insert("Homework", at: 0)
            rows[0] = assignments
            sectionCount += 1
        }
        if day.exams.count > 0 {
            sections.insert("Tests", at: 0)
            rows.insert(exams, at: 0)
            sectionCount += 1
        }
        tableView.reloadData()
        
    }
}
