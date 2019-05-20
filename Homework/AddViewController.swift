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
    var cells = ["Homework", "Test", "Class"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Add Item"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return cells.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as UITableViewCell
        cell.textLabel!.text = cells[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let name = cells[indexPath.row]
        let viewController = AddFormviewController()
        viewController.pageTitle = name
        navigationController?.pushViewController(viewController, animated: false)
    }
    
    

}
