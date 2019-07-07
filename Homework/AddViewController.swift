//
//  AddViewController.swift
//  Homework
//
//  Created by Javier Quintero on 5/11/19.
//  Copyright © 2019 Javier Quintero. All rights reserved.
//

import UIKit

class AddViewController: UITableViewController {
    
    let cellID = "cellID"
    let cells = ["Homework", "Test", "Class"]
    var persistantData: PersistantData?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Add Item"
        tableView.register(TableViewCellButton.self, forCellReuseIdentifier: cellID)
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return cells.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! TableViewCellButton
        cell.textLabel?.text = cells[indexPath.row]
        cell.textLabel?.textAlignment = .center
        cell.setUp()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let name = cells[indexPath.row]
        if name == "Class" {
            let viewController = AddClassViewController()
            viewController.persistantData = persistantData
            navigationController?.pushViewController(viewController, animated: false)
        }
        else if name == "Homework" {
            let viewController = AddAssignmentViewController()
            viewController.addType = name
            viewController.persistantData = persistantData
            navigationController?.pushViewController(viewController, animated: false)
        }
        else {
            let viewController = AddAssignmentViewController()
            viewController.addType = name
            viewController.persistantData = persistantData
            navigationController?.pushViewController(viewController, animated: false)
        }
    }
    
    

}
