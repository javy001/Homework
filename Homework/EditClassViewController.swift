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
        
        
        nameInput.text = schoolClass?.name
        
        subView.addSubview(nameInput)
        nameInput.translatesAutoresizingMaskIntoConstraints = false
        nameInput.leadingAnchor.constraint(equalTo: subView.leadingAnchor, constant: 10).isActive = true
        nameInput.trailingAnchor.constraint(equalTo: subView.trailingAnchor, constant: -10).isActive = true
        nameInput.topAnchor.constraint(equalTo: label.bottomAnchor).isActive = true
        nameInput.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        nameInput.borderStyle = .roundedRect
        
        let colorLabel = UILabel()
        self.view.addSubview(colorLabel)
        colorLabel.text = "Color"
        colorLabel.translatesAutoresizingMaskIntoConstraints = false
        colorLabel.topAnchor.constraint(equalTo: nameInput.bottomAnchor, constant: 10).isActive = true
        colorLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        colorLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        colorLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        let btn1 = buttons[0]
        self.view.addSubview(btn1)
        btn1.translatesAutoresizingMaskIntoConstraints = false
        btn1.topAnchor.constraint(equalTo: colorLabel.bottomAnchor, constant: 10).isActive = true
        btn1.widthAnchor.constraint(equalToConstant: 50).isActive = true
        btn1.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btn1.leadingAnchor.constraint(equalTo: colorLabel.leadingAnchor).isActive = true
        btn1.backgroundColor = style.backgroundColors[0]
        btn1.tag = 0
        btn1.addTarget(self, action: #selector(addColor(_:)), for: .touchUpInside)
        
        let btn2 = buttons[1]
        self.view.addSubview(btn2)
        btn2.translatesAutoresizingMaskIntoConstraints = false
        btn2.topAnchor.constraint(equalTo: colorLabel.bottomAnchor, constant: 10).isActive = true
        btn2.widthAnchor.constraint(equalToConstant: 50).isActive = true
        btn2.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btn2.leadingAnchor.constraint(equalTo: btn1.trailingAnchor, constant: 5).isActive = true
        btn2.backgroundColor = style.backgroundColors[1]
        btn2.tag = 1
        btn2.addTarget(self, action: #selector(addColor(_:)), for: .touchUpInside)
        
        let btn3 = buttons[2]
        self.view.addSubview(btn3)
        btn3.translatesAutoresizingMaskIntoConstraints = false
        btn3.topAnchor.constraint(equalTo: colorLabel.bottomAnchor, constant: 10).isActive = true
        btn3.widthAnchor.constraint(equalToConstant: 50).isActive = true
        btn3.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btn3.leadingAnchor.constraint(equalTo: btn2.trailingAnchor, constant: 5).isActive = true
        btn3.backgroundColor = style.backgroundColors[2]
        btn3.tag = 2
        btn3.addTarget(self, action: #selector(addColor(_:)), for: .touchUpInside)
        
        let btn4 = buttons[3]
        self.view.addSubview(btn4)
        btn4.translatesAutoresizingMaskIntoConstraints = false
        btn4.topAnchor.constraint(equalTo: colorLabel.bottomAnchor, constant: 10).isActive = true
        btn4.widthAnchor.constraint(equalToConstant: 50).isActive = true
        btn4.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btn4.leadingAnchor.constraint(equalTo: btn3.trailingAnchor, constant: 5).isActive = true
        btn4.backgroundColor = style.backgroundColors[3]
        btn4.tag = 3
        btn4.addTarget(self, action: #selector(addColor(_:)), for: .touchUpInside)
        
        let btn5 = buttons[4]
        self.view.addSubview(btn5)
        btn5.translatesAutoresizingMaskIntoConstraints = false
        btn5.topAnchor.constraint(equalTo: colorLabel.bottomAnchor, constant: 10).isActive = true
        btn5.widthAnchor.constraint(equalToConstant: 50).isActive = true
        btn5.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btn5.leadingAnchor.constraint(equalTo: btn4.trailingAnchor, constant: 5).isActive = true
        btn5.backgroundColor = style.backgroundColors[4]
        btn5.tag = 4
        btn5.addTarget(self, action: #selector(addColor(_:)), for: .touchUpInside)
        
        let btn6 = buttons[5]
        self.view.addSubview(btn6)
        btn6.translatesAutoresizingMaskIntoConstraints = false
        btn6.topAnchor.constraint(equalTo: btn1.bottomAnchor, constant: 5).isActive = true
        btn6.widthAnchor.constraint(equalToConstant: 50).isActive = true
        btn6.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btn6.leadingAnchor.constraint(equalTo: btn1.leadingAnchor).isActive = true
        btn6.backgroundColor = style.backgroundColors[5]
        btn6.tag = 5
        btn6.addTarget(self, action: #selector(addColor(_:)), for: .touchUpInside)
        
        let btn7 = buttons[6]
        self.view.addSubview(btn7)
        btn7.translatesAutoresizingMaskIntoConstraints = false
        btn7.topAnchor.constraint(equalTo: btn1.bottomAnchor, constant: 5).isActive = true
        btn7.widthAnchor.constraint(equalToConstant: 50).isActive = true
        btn7.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btn7.leadingAnchor.constraint(equalTo: btn6.trailingAnchor, constant: 5).isActive = true
        btn7.backgroundColor = style.backgroundColors[6]
        btn7.tag = 6
        btn7.addTarget(self, action: #selector(addColor(_:)), for: .touchUpInside)
        
        let deleteButton = UIButton()
        subView.addSubview(deleteButton)
        deleteButton.setTitle("Delete", for: .normal)
        deleteButton.setTitleColor(UIColor.red, for: .normal)
//        deleteButton.layer.cornerRadius = 8
        
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.centerXAnchor.constraint(equalTo: subView.centerXAnchor).isActive = true
        deleteButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
        deleteButton.topAnchor.constraint(equalTo: btn7.bottomAnchor, constant: 30).isActive = true
        deleteButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        deleteButton.addTarget(self, action: #selector(EditClassViewController.deleteClass(_:)), for: .touchUpInside)
        
        
    }
    
    @objc func addColor(_ sender:UIButton){
        let i = sender.tag
        buttons[i].layer.borderWidth = 1
        buttons[i].layer.borderColor = UIColor.black.cgColor
        buttons[color].layer.borderWidth = 0
        color = i
    }
    
    @objc func deleteClass(_ sender:UIButton!){
        persistantData!.context.delete(schoolClass!)
        do{
            try persistantData!.context.save()
            navigationController?.popToRootViewController(animated: false)
        } catch {
            print("Failed to save")
        }
    }
    
    @objc func saveClass(_ sender:UIBarButtonItem) {
        schoolClass?.name = nameInput.text
        schoolClass?.color = Int16(color)
        persistantData!.appDelegate.saveContext()
        navigationController?.popToRootViewController(animated: false)
    }
    
    

}
