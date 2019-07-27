//
//  AddAssignmentViewController.swift
//  Homework
//
//  Created by Javier Quintero on 5/29/19.
//  Copyright © 2019 Javier Quintero. All rights reserved.
//

import UIKit

class AddAssignmentViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextViewDelegate {
    
    var assignment: Assignment?
    var exam: Exam?
    var persistantData: PersistantData?
    var classes: [SchoolClass] = []
    var picker = UIPickerView()
    var name = UITextField()
    var initialDate = Date()
    var schoolClass: SchoolClass?
    var note = UITextView()
    var container = UIScrollView()
    var bottomView = UIView()
    var bottomViewHeightConstraint: NSLayoutConstraint?
    var containerContstraint: NSLayoutConstraint?
    var dateLabel = UILabel()
    var addType: String?
    var calendar = CalendarView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.picker.delegate = self
        self.picker.dataSource = self
        self.note.delegate = self
        
        
        fetchClasses()
        setuUpView()
        getInitialClass()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel(_:)))
        
        navigationItem.largeTitleDisplayMode = .never
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        persistantData!.context.reset()
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        
        navigationController?.navigationBar.barTintColor = .white
    }
    
    func getInitialClass() {
        var i = 0
        if let name = assignment?.schoolClass?.name {
            for row in classes {
                if name == row.name {
                    picker.selectRow(i, inComponent: 0, animated: false)
                    schoolClass = row
                }
                i += 1
            }
        }
    }
    
    func fetchClasses () {
        do {
            classes = try persistantData!.context.fetch(SchoolClass.fetchRequest())
            classes = classes.sorted(by: { $0.name ?? "_" < $1.name ?? "_" })
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
    
    
    func setuUpView(){
        assignment = Assignment(context: persistantData!.context)
        exam = Exam(context: persistantData!.context)
        schoolClass = classes[0]
        self.navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveData(_:))), animated: true)
        self.view.backgroundColor = UIColor.white
        
        self.view.addSubview(container)
        let tapListener = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        container.addGestureRecognizer(tapListener)
        container.translatesAutoresizingMaskIntoConstraints = false
        container.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        container.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
        containerContstraint = container.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 70)
        containerContstraint!.isActive = true
        container.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        
        let classLabel = UILabel()
        container.addSubview(classLabel)
        classLabel.translatesAutoresizingMaskIntoConstraints = false
        classLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        classLabel.trailingAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        classLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
        classLabel.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
        classLabel.text = "Class"
        
        self.view.addSubview(picker)
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.heightAnchor.constraint(equalToConstant: 120).isActive = true
        picker.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -10).isActive = true
        picker.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10).isActive = true
        picker.topAnchor.constraint(equalTo: classLabel.topAnchor).isActive = true
        
        
        let assignmentLabel = UILabel()
        container.addSubview(assignmentLabel)
        assignmentLabel.translatesAutoresizingMaskIntoConstraints = false
        assignmentLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        assignmentLabel.trailingAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        assignmentLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
        assignmentLabel.topAnchor.constraint(equalTo:picker.bottomAnchor).isActive = true
        assignmentLabel.text = "\(addType!) Name"
        
        container.addSubview(name)
        name.translatesAutoresizingMaskIntoConstraints = false
        name.heightAnchor.constraint(equalToConstant: 40).isActive = true
        name.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15).isActive = true
        name.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
        name.topAnchor.constraint(equalTo:assignmentLabel.bottomAnchor).isActive = true
        name.borderStyle = .roundedRect
        
        
        container.addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
        dateLabel.topAnchor.constraint(equalTo: name.bottomAnchor).isActive = true
        dateLabel.text = "Due on"
        
        container.addSubview(calendar)
        calendar.superWidth = self.view.frame.width - 30
        calendar.translatesAutoresizingMaskIntoConstraints = false
        calendar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15).isActive = true
        calendar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15).isActive = true
        calendar.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10).isActive = true
        calendar.heightAnchor.constraint(equalToConstant: 261).isActive = true
        calendar.selectedDay = initialDate
        calendar.genCalendar(seedDate: initialDate)
        
        let noteLabel = UILabel()
        container.addSubview(noteLabel)
        noteLabel.translatesAutoresizingMaskIntoConstraints = false
        noteLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
        noteLabel.trailingAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        noteLabel.topAnchor.constraint(equalTo: calendar.bottomAnchor).isActive = true
        noteLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        noteLabel.text = "Notes"
        
        container.addSubview(note)
        note.clipsToBounds = true
        note.layer.cornerRadius = 7
        note.translatesAutoresizingMaskIntoConstraints = false
        note.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
        note.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15).isActive = true
        note.topAnchor.constraint(equalTo: noteLabel.bottomAnchor).isActive = true
        note.bottomAnchor.constraint(equalTo: noteLabel.bottomAnchor, constant: 150).isActive = true
        note.layer.borderWidth = 0.3
        note.font = UIFont(name: "HelveticaNeue", size: 15)
        
        container.addSubview(bottomView)
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
        bottomView.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
        bottomView.bottomAnchor.constraint(equalTo: container.bottomAnchor).isActive = true
        bottomView.topAnchor.constraint(equalTo: note.bottomAnchor).isActive = true
        
        bottomViewHeightConstraint = bottomView.heightAnchor.constraint(equalToConstant: 50)
        bottomViewHeightConstraint!.isActive = true
        
    }
    
    
    @objc func saveData(_ sender:UIBarButtonItem) {
        if addType == "Homework"{
            if let assignment = assignment {
                assignment.name = name.text
                assignment.dueDate = calendar.selectedDay as NSDate
                assignment.notes = note.text
                assignment.schoolClass = schoolClass
                assignment.isComplete = false
                persistantData!.appDelegate.saveContext()
                self.navigationController?.popToRootViewController(animated: false)
            }
        }
        else {
            if let exam = exam {
                exam.name = name.text
                exam.dueDate = calendar.selectedDay as NSDate
                exam.notes = note.text
                exam.schoolClass = schoolClass
                exam.isComplete = false
                persistantData!.appDelegate.saveContext()
                self.navigationController?.popToRootViewController(animated: false)
            }
        }
        
    }
    
    @objc func cancel(_ sender:UIBarButtonItem) {
        self.navigationController?.popToRootViewController(animated: false)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        bottomViewHeightConstraint?.isActive = false
        bottomViewHeightConstraint = bottomView.heightAnchor.constraint(equalToConstant: 500)
        bottomViewHeightConstraint?.isActive = true
        if note.isFirstResponder {
            if let userInfo = notification.userInfo {
                let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
                let offset = keyboardFrame.height - 50
                let bottomOffset = CGPoint(x: 0, y: offset)
                container.setContentOffset(bottomOffset, animated: true)
            }
        }
        
    }
    
    @objc func keyBoardWillHide(notification: NSNotification) {
        bottomViewHeightConstraint?.isActive = false
        bottomViewHeightConstraint = bottomView.heightAnchor.constraint(equalToConstant: 50)
        bottomViewHeightConstraint?.isActive = true
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        container.endEditing(true)
    }
    
    @objc func hideKeyboard(sender: UITapGestureRecognizer) {
        container.endEditing(true)
    }
    
    @objc func dateDidChange(picker: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, MMM-dd"
        let dateString = formatter.string(from: picker.date)
        dateLabel.text = "Due on \(dateString)"
    }

}
