//
//  AddAssignmentView.swift
//  Homework
//
//  Created by Javier Quintero on 5/21/19.
//  Copyright © 2019 Javier Quintero. All rights reserved.
//

import UIKit

protocol SaveAssignmentDelegate {
    func saveAssignment()
}

class AddAssignmentView: UIView, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var classes: [SchoolClass] = []
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var input = UITextField()
    var picker = UIPickerView()
//    var className = ""
    var assigment :Assignment?
    var schoolClass :SchoolClass?
    var dueDate = UIDatePicker()
    var saveAssignmentDelegate: SaveAssignmentDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.picker.delegate = self
        self.picker.dataSource = self
        
        dueDate.datePickerMode = .date
        
        fetchClasses()
        setUp()
        
    }
    
    private func fetchClasses () {
        do {
            classes = try context.fetch(SchoolClass.fetchRequest())
            schoolClass = classes[picker.selectedRow(inComponent: 0)]
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
        return classes[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        schoolClass = classes[row]
    }
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp(){
        let label = UILabel()
        label.text = "Homework Name"
        label.textColor = UIColor.black
        self.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        label.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        label.heightAnchor.constraint(equalToConstant: 50).isActive = true
        label.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        
        
        input.borderStyle = .roundedRect
        self.addSubview(input)
        input.translatesAutoresizingMaskIntoConstraints = false
        input.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        input.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        input.heightAnchor.constraint(equalToConstant: 30).isActive = true
        input.topAnchor.constraint(equalTo: label.bottomAnchor).isActive = true
        
        input.borderStyle = .roundedRect
        self.addSubview(input)
        input.translatesAutoresizingMaskIntoConstraints = false
        input.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        input.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        input.heightAnchor.constraint(equalToConstant: 30).isActive = true
        input.topAnchor.constraint(equalTo: label.bottomAnchor).isActive = true
        
        let pickerLabel = UILabel()
        pickerLabel.text = "Class"
        pickerLabel.textColor = UIColor.black
        self.addSubview(pickerLabel)
        pickerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        pickerLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        pickerLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        pickerLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        pickerLabel.topAnchor.constraint(equalTo: input.bottomAnchor).isActive = true
        
        self.addSubview(picker)
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25).isActive = true
        picker.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -25).isActive = true
        picker.heightAnchor.constraint(equalToConstant: 100).isActive = true
        picker.topAnchor.constraint(equalTo: pickerLabel.bottomAnchor, constant: -20).isActive = true
        
        let dueDateLabel = UILabel()
        dueDateLabel.text = "Due Date"
        dueDateLabel.textColor = UIColor.black
        self.addSubview(dueDateLabel)
        dueDateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        dueDateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        dueDateLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        dueDateLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        dueDateLabel.topAnchor.constraint(equalTo: picker.bottomAnchor).isActive = true
        
        self.addSubview(dueDate)
        dueDate.translatesAutoresizingMaskIntoConstraints = false
        dueDate.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25).isActive = true
        dueDate.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -25).isActive = true
        dueDate.heightAnchor.constraint(equalToConstant: 100).isActive = true
        dueDate.topAnchor.constraint(equalTo: dueDateLabel.bottomAnchor, constant: -20).isActive = true
        
        let submitButton = UIButton()
        self.addSubview(submitButton)
        submitButton.setTitle("Save", for: .normal)
        submitButton.backgroundColor = UIColor.blue
        submitButton.layer.cornerRadius = 8
        
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        submitButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        submitButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
        submitButton.topAnchor.constraint(equalTo: dueDate.bottomAnchor, constant: 20).isActive = true
        submitButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        submitButton.addTarget(self, action: #selector(AddAssignmentView.saveData(_:)), for: .touchUpInside)
    }
    
    @objc func saveData(_ sender:UIButton!) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let newAssignment = Assignment(context: context)
        newAssignment.name = input.text
        newAssignment.isComplete = false
        newAssignment.dueDate = dueDate.date as NSDate
        if let schoolClass = schoolClass {
            newAssignment.schoolClass = schoolClass
        }
        appDelegate.saveContext()
        saveAssignmentDelegate?.saveAssignment()
    }
    
}
