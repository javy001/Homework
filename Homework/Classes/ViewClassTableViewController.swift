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
        
        self.navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem(_:))), animated: true)
        
        navigationController?.navigationBar.prefersLargeTitles = true
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
