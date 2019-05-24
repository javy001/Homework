//
//  EditClassViewController.swift
//  Homework
//
//  Created by Javier Quintero on 5/21/19.
//  Copyright © 2019 Javier Quintero. All rights reserved.
//

import UIKit

class EditClassViewController: UIViewController {
    
    var schoolClass = SchoolClass()
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var nameInput = UITextField()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()

    }
    
    private func setUp() {
        let subView = UIView()
        self.view.addSubview(subView)
        self.view.backgroundColor = UIColor.white
        
        subView.translatesAutoresizingMaskIntoConstraints = false
        subView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100).isActive = true
        subView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -100).isActive = true
        subView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        subView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        let label = UILabel()
        subView.addSubview(label)
        label.text = "Class Name"
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: subView.topAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: subView.leadingAnchor, constant: 10).isActive = true
        label.heightAnchor.constraint(equalToConstant: 50).isActive = true
        label.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        
        nameInput.text = schoolClass.name
        
        subView.addSubview(nameInput)
        nameInput.translatesAutoresizingMaskIntoConstraints = false
        nameInput.leadingAnchor.constraint(equalTo: subView.leadingAnchor, constant: 10).isActive = true
        nameInput.trailingAnchor.constraint(equalTo: subView.trailingAnchor, constant: -10).isActive = true
        nameInput.topAnchor.constraint(equalTo: label.bottomAnchor).isActive = true
        nameInput.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        nameInput.borderStyle = .roundedRect
        
        let saveButton = UIButton()
        subView.addSubview(saveButton)
        saveButton.setTitle("Save", for: .normal)
        saveButton.backgroundColor = UIColor.blue
        saveButton.layer.cornerRadius = 8
        
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.trailingAnchor.constraint(equalTo: subView.centerXAnchor, constant: -20).isActive = true
        saveButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
        saveButton.topAnchor.constraint(equalTo: nameInput.bottomAnchor, constant: 30).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        saveButton.addTarget(self, action: #selector(EditClassViewController.saveClass(_:)), for: .touchUpInside)
        
        let deleteButton = UIButton()
        subView.addSubview(deleteButton)
        deleteButton.setTitle("Delete", for: .normal)
        deleteButton.backgroundColor = UIColor.red
        deleteButton.layer.cornerRadius = 8
        
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.leadingAnchor.constraint(equalTo: subView.centerXAnchor, constant: 20).isActive = true
        deleteButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
        deleteButton.topAnchor.constraint(equalTo: nameInput.bottomAnchor, constant: 30).isActive = true
        deleteButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        deleteButton.addTarget(self, action: #selector(EditClassViewController.deleteClass(_:)), for: .touchUpInside)
        
        
    }
    
    @objc func deleteClass(_ sender:UIButton!){
        context.delete(schoolClass)
        do{
            try context.save()
            navigationController?.popViewController(animated: false)
        } catch {
            print("Failed to save")
        }
    }
    
    @objc func saveClass(_ sender:UIButton!) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        schoolClass.name = nameInput.text
        appDelegate.saveContext()
        navigationController?.popViewController(animated: false)
    }
    
    

}
