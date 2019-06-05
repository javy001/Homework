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
    var rows: [Assignment] = []
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rows = []
        tableView.register(PendingCellView.self, forCellReuseIdentifier: cellID)
        navigationItem.title = "Pending Items"
//        self.view.backgroundColor = UIColor(red: 91/255, green: 91/255, blue: 91/255, alpha: 1)
        self.view.backgroundColor = .black
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        do{
            let fetchRequest = Assignment.assignmentFetchRequest()
            fetchRequest.predicate = NSPredicate(format: "isComplete == false")
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: #keyPath(Assignment.dueDate), ascending: true)]
            rows = try context.fetch(fetchRequest)
            self.tableView.reloadData()
        } catch {
            print("fetch failed")
        }
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let assignment = rows[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! PendingCellView
        
        cell.className = assignment.schoolClass?.name
        cell.assignmentName = assignment.name
        cell.dueDate = assignment.dueDate as Date?
        cell.layoutSubviews()
//        cell.textLabel?.text = rows[indexPath.row].name
        return cell
        
    }
    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 55
//    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let assignment = rows[indexPath.row]
        let viewController = ViewAssignmentViewController()
        viewController.assignment = assignment
        navigationController?.pushViewController(viewController, animated: false)
    }

}
