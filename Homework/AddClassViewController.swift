//
//  AddClassViewController.swift
//  Homework
//
//  Created by Javier Quintero on 5/29/19.
//  Copyright © 2019 Javier Quintero. All rights reserved.
//

import UIKit

class AddClassViewController: UIViewController {
    
    var input = UITextField()
    var schoolClass = SchoolClass()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveClass(_:))), animated: true)
        
        setUp()
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.reset()
    }
    
    
    func setUp(){
        self.view.backgroundColor = .white
        
        let label = UILabel()
        label.text = "Class Name"
        label.textColor = UIColor.black
        self.view.addSubview(label)
        let safeOffset = UIApplication.shared.keyWindow?.safeAreaInsets.top ?? 0
        let navOffset = self.navigationController?.navigationBar.frame.size.height ?? 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        label.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        label.heightAnchor.constraint(equalToConstant: 50).isActive = true
        label.topAnchor.constraint(equalTo: self.view.topAnchor, constant: safeOffset + navOffset).isActive = true
        
        
        input.borderStyle = .roundedRect
        self.view.addSubview(input)
        input.translatesAutoresizingMaskIntoConstraints = false
        input.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        input.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
        input.heightAnchor.constraint(equalToConstant: 40).isActive = true
        input.topAnchor.constraint(equalTo: label.bottomAnchor).isActive = true
    }
    
    @objc func saveClass(_ sender:UIBarButtonItem) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        var names: [String] = []
        do {
            let schoolClasses = try context.fetch(SchoolClass.fetchRequest()) as! [SchoolClass]
            for schoolCLass in schoolClasses {
                if let name = schoolCLass.name {
                    names.append(name)
                }
            }
        }
        catch {
            print("Failed Fetch")
        }
        
        if let name = input.text {
            if checkClassNames(name: name, classes: names) {
                let schoolClass = SchoolClass(context: context)
                schoolClass.name = name
                appDelegate.saveContext()
            }
            else {
                print("dq fail")
            }
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    func checkClassNames(name: String, classes: [String]) -> Bool {
        for schoolClass in classes {
            if schoolClass == name {
                return false
            }
        }
        return true
    }

}
