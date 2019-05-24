//
//  AddFormviewController.swift
//  Homework
//
//  Created by Javier Quintero on 5/18/19.
//  Copyright © 2019 Javier Quintero. All rights reserved.
//

import UIKit

class AddFormviewController: UIViewController, SavedButtonDelegate, SaveAssignmentDelegate  {
    
    var pageTitle : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        navigationItem.title = pageTitle

        setUp()
    }
    
    private func setUp() {
        if let title = pageTitle {
            if title == "Class" {
                let subView = AddClassView()
                self.view.addSubview(subView)
                subView.savedButtonDelegate = self
                subView.translatesAutoresizingMaskIntoConstraints = false
                subView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
                subView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
                subView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100).isActive = true
                subView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -100).isActive = true
            }
            else {
                let subView = AddAssignmentView()
                self.view.addSubview(subView)
                subView.saveAssignmentDelegate = self
                subView.translatesAutoresizingMaskIntoConstraints = false
                subView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
                subView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
                subView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 90).isActive = true
                subView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -100).isActive = true
            }
            
        }
        
        
    }
    
    func didTapSaveButton(name: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let schoolClass = SchoolClass(context: context)
        schoolClass.name = name
        appDelegate.saveContext()
        
        navigationController?.popViewController(animated: false)
    }
    
    func saveAssignment() {
        navigationController?.popViewController(animated: false)
    }

}
