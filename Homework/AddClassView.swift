//
//  AddClassView.swift
//  Homework
//
//  Created by Javier Quintero on 5/19/19.
//  Copyright © 2019 Javier Quintero. All rights reserved.
//

import UIKit

protocol SavedButtonDelegate {
    func didTapSaveButton(name: String)
}

class AddClassView: UIView, UITextFieldDelegate {
    
    var savedButtonDelegate: SavedButtonDelegate?
    var input = UITextField()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        input.delegate = self
        
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        return false
    }
    
    
    func setUp(){
        let label = UILabel()
        label.text = "Class Name"
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
        
        let submitButton = UIButton()
        self.addSubview(submitButton)
        submitButton.setTitle("Save", for: .normal)
        submitButton.backgroundColor = UIColor.blue
        submitButton.layer.cornerRadius = 8
        
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        submitButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        submitButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
        submitButton.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        submitButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        submitButton.addTarget(self, action: #selector(AddClassView.handleSubmit(_:)), for: .touchUpInside)
        
    }
    
    @objc func handleSubmit(_ sender:UIButton!){
        if let data = input.text {
            savedButtonDelegate?.didTapSaveButton(name: data)
        }
    }
    
}
