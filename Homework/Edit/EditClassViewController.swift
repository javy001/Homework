//
//  EditClassViewController.swift
//  Homework
//
//  Created by Javier Quintero on 5/21/19.
//  Copyright © 2019 Javier Quintero. All rights reserved.
//

import UIKit

class EditClassViewController: UIViewController {
    
    var schoolClass: SchoolClass?
    var persistantData: PersistantData?
    var nameInput = UITextField()
    let style = AppStyle()
    var color = 0
    var buttons: [UIButton] = []
    let colorLabel = UILabel()
    let scrollView = UIScrollView()
    var emailInput = UITextField()
    var teacherInput = UITextField()
    var bottomViewHeightConstraint: NSLayoutConstraint?
    let bottomView = UIView()
    var roomNumber = UITextField()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        if let oldColor = schoolClass?.color {
            color = Int(oldColor)
        }
        for i in 0...style.backgroundColors.count - 1 {
            buttons.insert(UIButton(), at: i)
        }
        
        buttons[color].layer.borderWidth = 1
        if style.textColors[color] != UIColor.white {
            buttons[color].layer.borderColor = style.textColors[color].cgColor
        }
        else {
            buttons[color].layer.borderColor = UIColor.black.cgColor
        }
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel(_:)))
        
        self.navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveClass(_:))), animated: true)
        
        navigationItem.largeTitleDisplayMode = .never
        
        setUp()

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func setUp() {
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(scrollView)
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard(sender:)))
        scrollView.addGestureRecognizer(tap)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        let label = UILabel()
        scrollView.addSubview(label)
        label.text = "Class Name"
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 10).isActive = true
        label.heightAnchor.constraint(equalToConstant: 50).isActive = true
        label.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        
        nameInput.text = schoolClass?.name
        
        scrollView.addSubview(nameInput)
        nameInput.translatesAutoresizingMaskIntoConstraints = false
        nameInput.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 10).isActive = true
        nameInput.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
        nameInput.topAnchor.constraint(equalTo: label.bottomAnchor).isActive = true
        nameInput.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        nameInput.borderStyle = .roundedRect
        
        
        self.view.addSubview(colorLabel)
        colorLabel.text = "Color"
        colorLabel.translatesAutoresizingMaskIntoConstraints = false
        colorLabel.topAnchor.constraint(equalTo: nameInput.bottomAnchor, constant: 10).isActive = true
        colorLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        colorLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        colorLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        genColorButtons(n: buttons.count-1)
        
        let deleteButton = UIButton()
        scrollView.addSubview(deleteButton)
        deleteButton.setTitle("Delete", for: .normal)
        deleteButton.setTitleColor(UIColor.red, for: .normal)
//        deleteButton.layer.cornerRadius = 8
        
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        deleteButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
        deleteButton.topAnchor.constraint(equalTo: buttons[buttons.count-1].bottomAnchor, constant: 30).isActive = true
        deleteButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        deleteButton.addTarget(self, action: #selector(EditClassViewController.deleteClass(_:)), for: .touchUpInside)
        
        let teacherLabel = UILabel()
        scrollView.addSubview(teacherLabel)
        teacherLabel.translatesAutoresizingMaskIntoConstraints = false
        
        teacherLabel.topAnchor.constraint(equalTo: deleteButton.bottomAnchor, constant: 20).isActive = true
        teacherLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        teacherLabel.trailingAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        teacherLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        teacherLabel.text = "Teacher's name"
        teacherLabel.textAlignment = .left
        
        
        teacherInput.borderStyle = .roundedRect
        scrollView.addSubview(teacherInput)
        teacherInput.translatesAutoresizingMaskIntoConstraints = false
        teacherInput.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        teacherInput.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
        teacherInput.heightAnchor.constraint(equalToConstant: 40).isActive = true
        teacherInput.topAnchor.constraint(equalTo: teacherLabel.bottomAnchor).isActive = true
        teacherInput.text = schoolClass?.teacherName
        
        let emailLabel = UILabel()
        scrollView.addSubview(emailLabel)
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        
        emailLabel.topAnchor.constraint(equalTo:teacherInput.bottomAnchor, constant: 20).isActive = true
        emailLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        emailLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        emailLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        emailLabel.text = "Teacher's email address"
        emailLabel.textAlignment = .left
        
        
        emailInput.borderStyle = .roundedRect
        scrollView.addSubview(emailInput)
        emailInput.translatesAutoresizingMaskIntoConstraints = false
        emailInput.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        emailInput.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
        emailInput.heightAnchor.constraint(equalToConstant: 40).isActive = true
        emailInput.topAnchor.constraint(equalTo: emailLabel.bottomAnchor).isActive = true
        emailInput.text = schoolClass?.emailAddress
        
        let locationLabel = UILabel()
        scrollView.addSubview(locationLabel)
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        locationLabel.topAnchor.constraint(equalTo:emailInput.bottomAnchor, constant: 20).isActive = true
        locationLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        locationLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        locationLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        locationLabel.text = "Class Room Number"
        locationLabel.textAlignment = .left
        
        
        roomNumber.borderStyle = .roundedRect
        scrollView.addSubview(roomNumber)
        roomNumber.translatesAutoresizingMaskIntoConstraints = false
        roomNumber.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        roomNumber.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
        roomNumber.heightAnchor.constraint(equalToConstant: 40).isActive = true
        roomNumber.topAnchor.constraint(equalTo: locationLabel.bottomAnchor).isActive = true
        roomNumber.text = schoolClass?.location
        
        scrollView.addSubview(bottomView)
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.topAnchor.constraint(equalTo: roomNumber.bottomAnchor).isActive = true
        bottomView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        bottomView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        bottomView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        bottomViewHeightConstraint = bottomView.heightAnchor.constraint(equalToConstant: 50)
        bottomViewHeightConstraint?.isActive = true
        
        
    }
    
    func genColorButtons(n: Int) {
        let margin = (self.view.frame.width - 270)/2
        for i in 0...n {
            let btn = buttons[i]
            self.view.addSubview(btn)
            btn.translatesAutoresizingMaskIntoConstraints = false
            if i == 0 {
                btn.topAnchor.constraint(equalTo: colorLabel.bottomAnchor, constant: 10).isActive = true
                btn.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: margin).isActive = true
            }
            else if i <= 4 {
                btn.topAnchor.constraint(equalTo: colorLabel.bottomAnchor, constant: 10).isActive = true
                btn.leadingAnchor.constraint(equalTo: buttons[i-1].trailingAnchor, constant: 5).isActive = true
            }
            else {
                btn.topAnchor.constraint(equalTo: buttons[i-5].bottomAnchor, constant: 5).isActive = true
                btn.leadingAnchor.constraint(equalTo: buttons[i-5].leadingAnchor).isActive = true
            }
            
            btn.widthAnchor.constraint(equalToConstant: 50).isActive = true
            btn.heightAnchor.constraint(equalToConstant: 50).isActive = true
            btn.tag = i
            btn.addTarget(self, action: #selector(addColor(_:)), for: .touchUpInside)
            btn.backgroundColor = style.backgroundColors[i]
            btn.layer.cornerRadius = 3
        }
    }
    
    @objc func addColor(_ sender:UIButton){
        let i = sender.tag
        let button = buttons[i]
        if color != i {
            button.layer.borderWidth = 1
            if style.textColors[i] != UIColor.white {
                button.layer.borderColor = style.textColors[i].cgColor
            }
            else {
                button.layer.borderColor = UIColor.black.cgColor
            }
            buttons[color].layer.borderWidth = 0
            color = i
        }
        
        UIView.animate(withDuration: 0.1, animations: {
            button.frame.size = CGSize(width: 52, height: 52)
            button.transform = CGAffineTransform(translationX: -2, y: -2)
        }, completion: { (_) in
            UIView.animate(withDuration: 0.1, animations: {
                button.frame.size = CGSize(width: 50, height: 50)
                button.transform = CGAffineTransform.identity
            })
        })
    }
    
    @objc func deleteClass(_ sender:UIButton!){
        
        let defaultAction = UIAlertAction(title: "Delete",
                                          style: .destructive) { (action) in
            self.persistantData!.context.delete(self.schoolClass!)
            do{
                try self.persistantData!.context.save()
                self.navigationController?.popToRootViewController(animated: true)
            } catch {
                print("Failed to save")
            }

                                            
        }
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel) { (action) in
        }
        
        let alert = UIAlertController(title: "Are you sure?",
                                      message: "Deleting this class will also delete all of its homework and tests.",
                                      preferredStyle: .alert)
        alert.addAction(defaultAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true) {

        }
    }
    
    @objc func saveClass(_ sender:UIBarButtonItem) {
        let context = persistantData!.context
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
        
//        removing existsing class name from names array
        for i in 0...names.count-1 {
            if schoolClass!.name! == names[i] {
                names.remove(at: i)
                break
            }
        }

        if let name = nameInput.text {
            if checkClassNames(name: name, classes: names) {
                schoolClass?.name = name
                schoolClass?.color = Int16(color)
                schoolClass?.teacherName = teacherInput.text
                schoolClass?.emailAddress = emailInput.text
                schoolClass?.location = roomNumber.text
                persistantData!.appDelegate.saveContext()
                navigationController?.popToRootViewController(animated: true)
            }
            else {
                let alert = UIAlertController(title: "Pick a different name",
                                              message: "A class already exists with the name \(name)",
                    preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK",
                                             style: .default) { (action) in
                }
                alert.addAction(okAction)
                present(alert, animated: true) {
                    
                }
            }
        }
    }
    
    func checkClassNames(name: String, classes: [String]) -> Bool {
        for schoolClass in classes {
            if schoolClass == name {
                return false
            }
        }
        return true
    }
    
    @objc func cancel(_ sender:UIBarButtonItem) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        bottomViewHeightConstraint?.isActive = false
        bottomViewHeightConstraint = self.bottomView.heightAnchor.constraint(equalToConstant: 500)
        bottomViewHeightConstraint?.isActive = true
        if emailInput.isFirstResponder || teacherInput.isFirstResponder || roomNumber.isFirstResponder {
            if let userInfo = notification.userInfo {
                let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
                let offset = keyboardFrame.height - (self.scrollView.frame.height - self.roomNumber.frame.origin.y - self.roomNumber.frame.height)
                let bottomOffset = CGPoint(x: 0, y: offset)
                self.scrollView.setContentOffset(bottomOffset, animated: true)
                print(offset)
                
            }
        }
        
    }
    
    @objc func keyBoardWillHide(notification: NSNotification) {
        bottomViewHeightConstraint?.isActive = false
        bottomViewHeightConstraint = self.bottomView.heightAnchor.constraint(equalToConstant: 50)
        bottomViewHeightConstraint?.isActive = true
        
    }
    
    @objc func hideKeyboard(sender: UITapGestureRecognizer) {
        self.scrollView.endEditing(true)
    }

}
