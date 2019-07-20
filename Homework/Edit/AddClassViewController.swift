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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveClass(_:))), animated: true)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel(_:)))
        
        navigationItem.largeTitleDisplayMode = .never
        
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
        
        
        self.view.addSubview(colorLabel)
        colorLabel.text = "Color"
        colorLabel.translatesAutoresizingMaskIntoConstraints = false
        colorLabel.topAnchor.constraint(equalTo: input.bottomAnchor, constant: 10).isActive = true
        colorLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        colorLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        colorLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        genColorButtons(n: buttons.count-1)
        buttons[0].layer.borderWidth = 1
        buttons[0].layer.borderColor = UIColor.black.cgColor
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
        }
    }

}
