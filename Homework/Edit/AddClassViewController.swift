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
    var persistantData: PersistantData?
    let style = AppStyle()
    var color = 0
    let label = UILabel()
    var buttons: [UIButton] = []
    let colorLabel = UILabel()
    var teacherInput = UITextField()
    let scrollView = UIScrollView()
    var emailInput = UITextField()
    var bottomViewHeightConstraint: NSLayoutConstraint?
    let bottomView = UIView()
    var roomNumber = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveClass(_:))), animated: true)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel(_:)))
        
        navigationItem.largeTitleDisplayMode = .never
        
        for i in 0...style.backgroundColors.count - 1 {
            buttons.insert(UIButton(), at: i)
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        setUp()
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    func setUp(){
        self.view.backgroundColor = .white
        let tapListener = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        scrollView.addGestureRecognizer(tapListener)
        
        self.view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        
        label.text = "Class Name"
        label.textColor = UIColor.black
        scrollView.addSubview(label)
//        let safeOffset = UIApplication.shared.keyWindow?.safeAreaInsets.top ?? 0
//        let navOffset = self.navigationController?.navigationBar.frame.size.height ?? 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        label.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        label.heightAnchor.constraint(equalToConstant: 50).isActive = true
        label.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        
        
        input.borderStyle = .roundedRect
        scrollView.addSubview(input)
        input.translatesAutoresizingMaskIntoConstraints = false
        input.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        input.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
        input.heightAnchor.constraint(equalToConstant: 40).isActive = true
        input.topAnchor.constraint(equalTo: label.bottomAnchor).isActive = true
        
        
        scrollView.addSubview(colorLabel)
        colorLabel.text = "Color"
        colorLabel.translatesAutoresizingMaskIntoConstraints = false
        colorLabel.topAnchor.constraint(equalTo: input.bottomAnchor, constant: 10).isActive = true
        colorLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        colorLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        colorLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        genColorButtons(n: buttons.count-1)
        if style.textColors[0] != UIColor.white {
            buttons[0].layer.borderColor = style.textColors[color].cgColor
        }
        else {
            buttons[0].layer.borderColor = UIColor.black.cgColor
        }
        buttons[0].layer.borderWidth = 1
        
        let teacherLabel = UILabel()
        scrollView.addSubview(teacherLabel)
        teacherLabel.translatesAutoresizingMaskIntoConstraints = false
        
        teacherLabel.topAnchor.constraint(equalTo: buttons[buttons.count-1].bottomAnchor, constant: 20).isActive = true
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
        
        scrollView.addSubview(bottomView)
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.topAnchor.constraint(equalTo: roomNumber.bottomAnchor).isActive = true
        bottomView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        bottomView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        bottomView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        bottomViewHeightConstraint = bottomView.heightAnchor.constraint(equalToConstant: 50)
        bottomViewHeightConstraint?.isActive = true
    }
    
    @objc func addColor(_ sender:UIButton){
        let i = sender.tag
        let button = self.buttons[i]
        
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
        
        if let name = input.text {
            if checkClassNames(name: name, classes: names) {
                let schoolClass = SchoolClass(context: context)
                schoolClass.name = name
                schoolClass.color = Int16(color)
                schoolClass.teacherName = teacherInput.text
                schoolClass.emailAddress = emailInput.text
                schoolClass.location = roomNumber.text
                persistantData!.appDelegate.saveContext()
                
                navigationController?.popViewController(animated: false)
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
        self.navigationController?.popToRootViewController(animated: false)
    }
    
    func genColorButtons(n: Int) {
        let margin = (self.view.frame.width - 270)/2
        for i in 0...n {
            let btn = buttons[i]
            scrollView.addSubview(btn)
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
            btn.layer.cornerRadius = 3
            btn.tag = i
            btn.addTarget(self, action: #selector(addColor(_:)), for: .touchUpInside)
            btn.backgroundColor = style.backgroundColors[i]
        }
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
