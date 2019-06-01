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
        self.navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveClass(_:))), animated: true)
        let subView = UIView()
        self.view.addSubview(subView)
        self.view.backgroundColor = UIColor.white
        
        let safeOffset = UIApplication.shared.keyWindow?.safeAreaInsets.top ?? 0
        let navOffset = self.navigationController?.navigationBar.frame.size.height ?? 0
        
        subView.translatesAutoresizingMaskIntoConstraints = false
        subView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: safeOffset + navOffset).isActive = true
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
        
        let deleteButton = UIButton()
        subView.addSubview(deleteButton)
        deleteButton.setTitle("Delete", for: .normal)
        deleteButton.setTitleColor(UIColor.red, for: .normal)
//        deleteButton.layer.cornerRadius = 8
        
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.centerXAnchor.constraint(equalTo: subView.centerXAnchor).isActive = true
        deleteButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
        deleteButton.topAnchor.constraint(equalTo: nameInput.bottomAnchor, constant: 30).isActive = true
        deleteButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        deleteButton.addTarget(self, action: #selector(EditClassViewController.deleteClass(_:)), for: .touchUpInside)
        
        
    }
    
    @objc func deleteClass(_ sender:UIButton!){
        context.delete(schoolClass)
        do{
            try context.save()
            navigationController?.popToRootViewController(animated: false)
        } catch {
            print("Failed to save")
        }
    }
    
    @objc func saveClass(_ sender:UIBarButtonItem) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        schoolClass.name = nameInput.text
        appDelegate.saveContext()
        navigationController?.popToRootViewController(animated: false)
    }
    
    

}
