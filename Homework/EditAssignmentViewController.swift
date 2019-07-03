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

    override func viewDidLoad() {
        super.viewDidLoad()

        self.picker.delegate = self
        self.picker.dataSource = self
        self.note.delegate = self
        
        
        setuUpView()
        getInitialClass()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        persistantData!.context.reset()
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
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
        
        if let text = assignment?.notes {
            note.text = text
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
        assignmentLabel.text = "Homework Name"
        assignmentLabel.textColor = AppStyle().mainTextColor

        container.addSubview(name)
        name.translatesAutoresizingMaskIntoConstraints = false
        name.heightAnchor.constraint(equalToConstant: 40).isActive = true
        name.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
        name.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
        name.topAnchor.constraint(equalTo:assignmentLabel.bottomAnchor).isActive = true
        name.borderStyle = .roundedRect
        if let assignment = assignment {
            name.text = assignment.name
        }
//        name.backgroundColor = styles.greyAccent
        name.textColor = styles.mainTextColor

        
        container.addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
        dateLabel.topAnchor.constraint(equalTo: name.bottomAnchor).isActive = true
        
        dateLabel.textColor = styles.mainTextColor
        

        container.addSubview(dueDate)
        dueDate.translatesAutoresizingMaskIntoConstraints = false
        dueDate.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
        dueDate.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
        dueDate.heightAnchor.constraint(equalToConstant: 100).isActive = true
        dueDate.topAnchor.constraint(equalTo: dateLabel.bottomAnchor).isActive = true
        if let assignmentDate = assignment?.dueDate {
            dueDate.date = assignmentDate as Date
            let formatter = DateFormatter()
            formatter.dateFormat = "E, MMM-dd"
            let dateString = formatter.string(from: dueDate.date)
            dateLabel.text = "Due on \(dateString)"
        }
        dueDate.tintColor = styles.mainTextColor
        dueDate.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.1)
        dueDate.layer.cornerRadius = 8
        dueDate.setValue(styles.mainTextColor, forKey: "textColor")
        dueDate.datePickerMode = .date
        dueDate.addTarget(self, action: #selector(dateDidChange(picker:)), for: .valueChanged)

        let noteLabel = UILabel()
        container.addSubview(noteLabel)
        noteLabel.translatesAutoresizingMaskIntoConstraints = false
        noteLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
        noteLabel.trailingAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        noteLabel.topAnchor.constraint(equalTo: dueDate.bottomAnchor).isActive = true
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
//        note.backgroundColor = styles.greyAccent
        note.textColor = styles.mainTextColor

        container.addSubview(deleteButton)
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        deleteButton.widthAnchor.constraint(equalToConstant: 180).isActive = true
        deleteButton.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        deleteButton.topAnchor.constraint(equalTo: note.bottomAnchor, constant: 25).isActive = true
        deleteButton.setTitle("Delete Homework", for: .normal)
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
        if let assignment = assignment {
            persistantData!.context.delete(assignment)
            persistantData!.appDelegate.saveContext()
        }
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func saveAssignment(_ sender:UIBarButtonItem) {
        if let assignment = assignment {
            assignment.name = name.text
            assignment.dueDate = dueDate.date as NSDate
            assignment.notes = note.text
            assignment.schoolClass = schoolClass
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


}
