//
//  EditAssignmentViewController.swift
//  Homework
//
//  Created by Javier Quintero on 5/23/19.
//  Copyright © 2019 Javier Quintero. All rights reserved.
//

import UIKit

class EditAssignmentViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextViewDelegate {
    
    var assignment: Assignment?
    var exam: Exam?
    var classes: [SchoolClass] = []
    var picker = UIPickerView()
    var name = UITextField()
    var dueDate = UIDatePicker()
    var schoolClass: SchoolClass?
    var note = UITextView()
    var container = UIScrollView()
    var bottomView = UIView()
    var bottomViewHeightConstraint: NSLayoutConstraint?
    var deleteButton = UIButton()
    let styles = AppStyle()
    var persistantData: PersistantData?
    var dateLabel = UILabel()
    var viewType: String?
    let calendar = CalendarView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.picker.delegate = self
        self.picker.dataSource = self
        self.note.delegate = self
        
        
        setuUpView()
        getInitialClass()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel(_:)))
        
        navigationItem.largeTitleDisplayMode = .never
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func getInitialClass() {
        var i = 0
        var name = ""
        if viewType == "Homework"{
            if let className = assignment?.schoolClass?.name {
                name = className
            }
        }
        else if viewType == "Test" {
            if let className = exam?.schoolClass?.name {
                name = className
            }
        }
        
        for row in classes {
            if name == row.name {
                picker.selectRow(i, inComponent: 0, animated: false)
                schoolClass = row
            }
            i += 1
        }
    }
    
    func fetchClasses () {
        do {
            let tempClasses = try persistantData!.context.fetch(SchoolClass.fetchRequest()) as [SchoolClass]
            classes = tempClasses.sorted(by: { $0.name ?? "_" < $1.name ?? "_" })
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
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let title = classes[row].name
        return NSAttributedString(string: title!, attributes: [NSAttributedString.Key.foregroundColor: styles.mainTextColor])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        schoolClass = classes[row]
        
    }
    
    
    func setuUpView(){
        self.navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveAssignment(_:))), animated: true)
        self.view.backgroundColor = styles.backgroundColor
        
        if viewType == "Homework" {
            note.text = assignment?.notes
        }
        else if viewType == "Test" {
            note.text = exam?.notes
        }
        self.view.addSubview(container)
        let tapListener = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        let safeOffset = UIApplication.shared.keyWindow?.safeAreaInsets.top ?? 0
        let navOffset = self.navigationController?.navigationBar.frame.size.height ?? 0
        container.addGestureRecognizer(tapListener)
        
        container.translatesAutoresizingMaskIntoConstraints = false
        container.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        container.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
        container.topAnchor.constraint(equalTo: self.view.topAnchor, constant: navOffset + safeOffset).isActive = true
        container.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        let classLabel = UILabel()
        container.addSubview(classLabel)
        classLabel.translatesAutoresizingMaskIntoConstraints = false
        classLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        classLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
        classLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
        classLabel.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
        classLabel.text = "Class"
        classLabel.textColor = styles.mainTextColor
        
        
        container.addSubview(picker)
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.heightAnchor.constraint(equalToConstant: 100).isActive = true
        picker.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
        picker.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
        picker.topAnchor.constraint(equalTo: classLabel.topAnchor, constant: 10).isActive = true


        let assignmentLabel = UILabel()
        container.addSubview(assignmentLabel)
        assignmentLabel.translatesAutoresizingMaskIntoConstraints = false
        assignmentLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        assignmentLabel.trailingAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        assignmentLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
        assignmentLabel.topAnchor.constraint(equalTo:picker.bottomAnchor).isActive = true
        assignmentLabel.text = "\(viewType!) Name"
        assignmentLabel.textColor = AppStyle().mainTextColor

        container.addSubview(name)
        name.translatesAutoresizingMaskIntoConstraints = false
        name.heightAnchor.constraint(equalToConstant: 40).isActive = true
        name.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
        name.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
        name.topAnchor.constraint(equalTo:assignmentLabel.bottomAnchor).isActive = true
        name.borderStyle = .roundedRect
        if viewType == "Homework" {
            name.text = assignment?.name
        }
        else if viewType == "Test" {
            name.text = exam?.name
        }

        name.textColor = styles.mainTextColor

        
        container.addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
        dateLabel.topAnchor.constraint(equalTo: name.bottomAnchor).isActive = true
        
        dateLabel.textColor = styles.mainTextColor
        
        container.addSubview(calendar)
        calendar.superWidth = self.view.frame.width - 30
        calendar.translatesAutoresizingMaskIntoConstraints = false
        calendar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15).isActive = true
        calendar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15).isActive = true
        calendar.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10).isActive = true
        calendar.heightAnchor.constraint(equalToConstant: 261).isActive = true
        
        if viewType == "Homework" {
            let date = assignment!.dueDate! as Date
            calendar.selectedDay = date
            calendar.color = Int(assignment!.schoolClass!.color)
            calendar.genCalendar(seedDate: date)
            
        }
        else {
            let date = exam!.dueDate! as Date
            calendar.selectedDay = date
            calendar.color = Int(exam!.schoolClass!.color)
            calendar.genCalendar(seedDate: date)
        }

        dateLabel.text = "Due on"


        let noteLabel = UILabel()
        container.addSubview(noteLabel)
        noteLabel.translatesAutoresizingMaskIntoConstraints = false
        noteLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
        noteLabel.trailingAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        noteLabel.topAnchor.constraint(equalTo: calendar.bottomAnchor).isActive = true
        noteLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        noteLabel.text = "Notes"
        noteLabel.textColor = styles.mainTextColor

        container.addSubview(note)
        note.clipsToBounds = true
        note.layer.cornerRadius = 7
        note.translatesAutoresizingMaskIntoConstraints = false
        note.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
        note.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
        note.topAnchor.constraint(equalTo: noteLabel.bottomAnchor).isActive = true
        note.bottomAnchor.constraint(equalTo: noteLabel.bottomAnchor, constant: 150).isActive = true
        note.layer.borderWidth = 0.3
        note.font = UIFont(name: "HelveticaNeue", size: 15)
        note.textColor = styles.mainTextColor

        container.addSubview(deleteButton)
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        deleteButton.widthAnchor.constraint(equalToConstant: 180).isActive = true
        deleteButton.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        deleteButton.topAnchor.constraint(equalTo: note.bottomAnchor, constant: 25).isActive = true
        deleteButton.setTitle("Delete \(viewType!)", for: .normal)
        deleteButton.setTitleColor(UIColor.red, for: .normal)
        deleteButton.addTarget(self, action: #selector(deleteAssignment(_:)), for: .touchUpInside)

        container.addSubview(bottomView)
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
        bottomView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
        bottomView.bottomAnchor.constraint(equalTo: container.bottomAnchor).isActive = true
        bottomView.topAnchor.constraint(equalTo: deleteButton.bottomAnchor).isActive = true

        bottomViewHeightConstraint = bottomView.heightAnchor.constraint(equalToConstant: 50)
        bottomViewHeightConstraint!.isActive = true
        

    }
    
    @objc func deleteAssignment(_ sender:UIButton!) {
        let lowerViewType = viewType?.lowercased()
        let defaultAction = UIAlertAction(title: "Delete", style: .destructive) { (action) in
            if let assignment = self.assignment {
                self.persistantData!.context.delete(assignment)
                self.persistantData!.appDelegate.saveContext()
            }
            if let exam = self.exam {
                self.persistantData!.context.delete(exam)
                self.persistantData!.appDelegate.saveContext()
            }
            self.navigationController?.popToRootViewController(animated: true)
            do{
                try self.persistantData!.context.save()
                self.navigationController?.popToRootViewController(animated: false)
            } catch {
                print("Failed to save")
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel) { (action) in
        }
        
        let alert = UIAlertController(title: "Are you sure you want to delete this \(lowerViewType!)?",
                                      message: nil,
                                      preferredStyle: .alert)
        alert.addAction(defaultAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true) {
            
        }
        
        
    }
    
    @objc func saveAssignment(_ sender:UIBarButtonItem) {
        if let assignment = assignment {
            assignment.name = name.text
            assignment.dueDate = calendar.selectedDay as NSDate
            assignment.notes = note.text
            assignment.schoolClass = schoolClass
        }
        
        if let exam = exam {
            exam.name = name.text
            exam.dueDate = calendar.selectedDay as NSDate
            exam.notes = note.text
            exam.schoolClass = schoolClass
        }
        persistantData!.appDelegate.saveContext()
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        bottomViewHeightConstraint?.isActive = false
        bottomViewHeightConstraint = bottomView.heightAnchor.constraint(equalToConstant: 500)
        bottomViewHeightConstraint?.isActive = true
        if note.isFirstResponder {
            if let userInfo = notification.userInfo {
                let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
                let offset = keyboardFrame.height - 50
                deleteButton.isUserInteractionEnabled = false
                deleteButton.setTitleColor(styles.backgroundColor, for: .normal)
                let bottomOffset = CGPoint(x: 0, y: offset)
                container.setContentOffset(bottomOffset, animated: true)
            }
        }
        
    }
    
    @objc func keyBoardWillHide(notification: NSNotification) {
        bottomViewHeightConstraint?.isActive = false
        bottomViewHeightConstraint = bottomView.heightAnchor.constraint(equalToConstant: 50)
        bottomViewHeightConstraint?.isActive = true
        deleteButton.isUserInteractionEnabled = true
        deleteButton.setTitleColor(.red, for: .normal)
        
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

    @objc func cancel(_ sender:UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
}
