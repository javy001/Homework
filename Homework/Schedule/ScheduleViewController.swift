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
        setUp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        calendar.updateData(seedDate: Date())
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
        let height = (8 * 30) + (6 * 6) + (9 * 3) + 1
        calendar.heightAnchor.constraint(equalToConstant: CGFloat(height)).isActive = true
        
        calendar.genCalendar(seedDate: Date())
        
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: calendar.bottomAnchor, constant: 5).isActive = true
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
        label.font = UIFont(name: "Avenir-Heavy", size: 22)
        
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
    
    func dateSelected(day: ScheduleDay) {
        sections = []
        sectionCount = 0
        rows = [[]]
        assignments = day.assignments
        exams = day.exams
        
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
