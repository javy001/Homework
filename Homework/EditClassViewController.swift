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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let oldColor = schoolClass?.color {
            color = Int(oldColor)
        }
        for i in 0...style.backgroundColors.count - 1 {
            buttons.insert(UIButton(), at: i)
        }
        
        buttons[color].layer.borderWidth = 1
        buttons[color].layer.borderColor = UIColor.black.cgColor
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel(_:)))
        
        self.navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveClass(_:))), animated: true)
        
        setUp()

    }
    
    private func setUp() {
        
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
        
        
        nameInput.text = schoolClass?.name
        
        subView.addSubview(nameInput)
        nameInput.translatesAutoresizingMaskIntoConstraints = false
        nameInput.leadingAnchor.constraint(equalTo: subView.leadingAnchor, constant: 10).isActive = true
        nameInput.trailingAnchor.constraint(equalTo: subView.trailingAnchor, constant: -10).isActive = true
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
        subView.addSubview(deleteButton)
        deleteButton.setTitle("Delete", for: .normal)
        deleteButton.setTitleColor(UIColor.red, for: .normal)
//        deleteButton.layer.cornerRadius = 8
        
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.centerXAnchor.constraint(equalTo: subView.centerXAnchor).isActive = true
        deleteButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
        deleteButton.topAnchor.constraint(equalTo: buttons[buttons.count-1].bottomAnchor, constant: 30).isActive = true
        deleteButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        deleteButton.addTarget(self, action: #selector(EditClassViewController.deleteClass(_:)), for: .touchUpInside)
        
        
    }
    
    func genColorButtons(n: Int) {
        for i in 0...n {
            let btn = buttons[i]
            self.view.addSubview(btn)
            btn.translatesAutoresizingMaskIntoConstraints = false
            if i == 0 {
                btn.topAnchor.constraint(equalTo: colorLabel.bottomAnchor, constant: 10).isActive = true
                btn.leadingAnchor.constraint(equalTo: colorLabel.leadingAnchor).isActive = true
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
        }
    }
    
    @objc func addColor(_ sender:UIButton){
        let i = sender.tag
        buttons[i].layer.borderWidth = 1
        buttons[i].layer.borderColor = UIColor.black.cgColor
        buttons[color].layer.borderWidth = 0
        color = i
    }
    
    @objc func deleteClass(_ sender:UIButton!){
        
        let defaultAction = UIAlertAction(title: "Delete",
                                          style: .destructive) { (action) in
            self.persistantData!.context.delete(self.schoolClass!)
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
        
        let alert = UIAlertController(title: "Are you sure?",
                                      message: "Deleting this class will also delete all of its homework and tests.",
                                      preferredStyle: .alert)
        alert.addAction(defaultAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true) {

        }
    }
    
    @objc func saveClass(_ sender:UIBarButtonItem) {
        schoolClass?.name = nameInput.text
        schoolClass?.color = Int16(color)
        persistantData!.appDelegate.saveContext()
        navigationController?.popToRootViewController(animated: false)
    }
    
    @objc func cancel(_ sender:UIBarButtonItem) {
        self.navigationController?.popToRootViewController(animated: false)
    }

}
