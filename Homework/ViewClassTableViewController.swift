//
//  ViewClassTableViewController.swift
//  Homework
//
//  Created by Javier Quintero on 5/24/19.
//  Copyright © 2019 Javier Quintero. All rights reserved.
//

import UIKit

class ViewClassTableViewController: UITableViewController {
    
    var cellId = "cellId"
    var rows: [SchoolClass] = []
    var persistantData: PersistantData?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        rows = []
        tableView.register(ClassTableViewCell.self, forCellReuseIdentifier: cellId)
        navigationItem.title = "Classes"
        self.view.backgroundColor = .white
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
    }
    
    override func viewWillAppear(_ animated: Bool) {
        do{
//            let fetchRequest = SchoolClass.fetchRequest()
//            fetchRequest.predicate = NSPredicate(format: "isComplete == true")
            rows = try persistantData!.context.fetch(SchoolClass.fetchRequest())
            self.tableView.reloadData()
        } catch {
            print("fetch failed")
        }
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return rows.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ClassTableViewCell
        cell.textLabel?.text = rows[indexPath.row].name
        cell.textLabel?.textAlignment = .center
        cell.colorIndex = Int(rows[indexPath.row].color)
        cell.setUp()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = ClassAssignmentsViewController()
        viewController.schoolClass = rows[indexPath.row]
        viewController.persistantData = persistantData
        self.navigationController?.pushViewController(viewController, animated: false)
    }
    
}
