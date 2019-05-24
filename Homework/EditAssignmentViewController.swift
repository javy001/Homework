//
//  EditAssignmentViewController.swift
//  Homework
//
//  Created by Javier Quintero on 5/23/19.
//  Copyright © 2019 Javier Quintero. All rights reserved.
//

import UIKit

class EditAssignmentViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var assignment: Assignment?
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var classes: [SchoolClass] = []
    var picker = UIPickerView()
    var name = UITextField()
    var dueDate = UIDatePicker()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.picker.delegate = self
        self.picker.dataSource = self
        
        
        fetchClasses()
        setuUpView()
        
    }
    
    private func fetchClasses () {
        do {
            classes = try context.fetch(SchoolClass.fetchRequest())
//            schoolClass = classes[picker.selectedRow(inComponent: 0)]
        } catch {
            print("Fetch Failed")
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return classes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if let assignment = assignment {
            if classes[row].name == assignment.schoolClass?.name {
                picker.selectRow(row, inComponent: 0, animated: false)
            }
        }
        return classes[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if let assignment = assignment {
            assignment.schoolClass = classes[row]
        }
        
    }
    
    
    func setuUpView(){
        self.navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(saveAssignment(_:))), animated: true)
        self.view.backgroundColor = UIColor.white
        
        let classLabel = UILabel()
        self.view.addSubview(classLabel)
        classLabel.translatesAutoresizingMaskIntoConstraints = false
        classLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        classLabel.trailingAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        classLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        classLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100).isActive = true
        classLabel.text = "Class"
        
        self.view.addSubview(picker)
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.heightAnchor.constraint(equalToConstant: 120).isActive = true
        picker.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        picker.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        picker.topAnchor.constraint(equalTo: classLabel.topAnchor).isActive = true

        
        let assignmentLabel = UILabel()
        self.view.addSubview(assignmentLabel)
        assignmentLabel.translatesAutoresizingMaskIntoConstraints = false
        assignmentLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        assignmentLabel.trailingAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        assignmentLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        assignmentLabel.topAnchor.constraint(equalTo:picker.bottomAnchor).isActive = true
        assignmentLabel.text = "Homework Name"
        
        self.view.addSubview(name)
        name.translatesAutoresizingMaskIntoConstraints = false
        name.heightAnchor.constraint(equalToConstant: 50).isActive = true
        name.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
        name.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        name.topAnchor.constraint(equalTo:assignmentLabel.bottomAnchor).isActive = true
        name.borderStyle = .roundedRect
        if let assignment = assignment {
            name.text = assignment.name
        }
        
        let dateLabel = UILabel()
        self.view.addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        dateLabel.topAnchor.constraint(equalTo: name.bottomAnchor).isActive = true
        dateLabel.text = "Due on "
        
        self.view.addSubview(dueDate)
        dueDate.translatesAutoresizingMaskIntoConstraints = false
        dueDate.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 25).isActive = true
        dueDate.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -25).isActive = true
        dueDate.heightAnchor.constraint(equalToConstant: 100).isActive = true
        dueDate.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: -20).isActive = true
        
        let completeButton = UIButton()
        self.view.addSubview(completeButton)
        completeButton.translatesAutoresizingMaskIntoConstraints = false
        completeButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        completeButton.widthAnchor.constraint(equalToConstant: 180).isActive = true
        completeButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        completeButton.topAnchor.constraint(equalTo: dueDate.bottomAnchor, constant: 25).isActive = true
        completeButton.setTitle("Delete Homework", for: .normal)
        completeButton.setTitleColor(UIColor.red, for: .normal)
        completeButton.layer.borderWidth = 1
        completeButton.layer.borderColor = UIColor.black.cgColor
        completeButton.addTarget(self, action: #selector(deleteAssignment(_:)), for: .touchUpInside)
    }
    
    @objc func deleteAssignment(_ sender:UIButton!) {
        if let assignment = assignment {
            context.delete(assignment)
        }
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func saveAssignment(_ sender:UIBarButtonItem) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if let assignment = assignment {
            assignment.name = name.text
            assignment.dueDate = dueDate.date as NSDate
        }
        appDelegate.saveContext()
//        navigationController?.popViewController(animated: false)
        self.navigationController?.popToRootViewController(animated: true)
    }
    

    

}
