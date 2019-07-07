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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveClass(_:))), animated: true)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel(_:)))
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 241/255, green: 184/255, blue: 251/255, alpha: 1)
        
        for i in 0...style.backgroundColors.count - 1 {
            buttons.insert(UIButton(), at: i)
        }
        
        setUp()
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.barTintColor = .white
    }
    
    
    func setUp(){
        self.view.backgroundColor = .white
        
        
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
        
        let colorLabel = UILabel()
        self.view.addSubview(colorLabel)
        colorLabel.text = "Color"
        colorLabel.translatesAutoresizingMaskIntoConstraints = false
        colorLabel.topAnchor.constraint(equalTo: input.bottomAnchor, constant: 10).isActive = true
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
        btn1.layer.borderWidth = 1
        btn1.layer.borderColor = UIColor.black.cgColor

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
    }
    
    @objc func addColor(_ sender:UIButton){
        let i = sender.tag
        buttons[i].layer.borderWidth = 1
        buttons[i].layer.borderColor = UIColor.black.cgColor
        buttons[color].layer.borderWidth = 0
        color = i
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
                persistantData!.appDelegate.saveContext()
            }
            else {
                print("dq fail")
            }
        }
        
        navigationController?.popViewController(animated: false)
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

}
