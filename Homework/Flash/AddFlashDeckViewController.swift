//
//  AddFlashDeckViewController.swift
//  Homework
//
//  Created by Javier Quintero on 8/2/19.
//  Copyright © 2019 Javier Quintero. All rights reserved.
//

import UIKit

class AddFlashDeckViewController: UIViewController {
    
    var persistantData: PersistantData?
    var schoolClass: SchoolClass?
    let name = UITextField()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveData(_:)))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel(_:)))
        self.navigationItem.title = "New Flash Deck"
        
        setUp()
    }
    
    func setUp() {
        let nameLabel = UILabel()
        self.view.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 15).isActive = true
        nameLabel.text = "Name"
        
        self.view.addSubview(name)
        name.translatesAutoresizingMaskIntoConstraints = false
        name.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5).isActive = true
        name.heightAnchor.constraint(equalToConstant: 40).isActive = true
        name.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15).isActive = true
        name.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15).isActive = true
        name.clearButtonMode = .always
        name.borderStyle = .roundedRect
        
    }
    

    @objc func saveData(_ sender:UIBarButtonItem) {
        let context = persistantData!.context
        let deck = FlashDeck(context: context)
        deck.name = name.text
        deck.schoolClass = schoolClass
        persistantData!.appDelegate.saveContext()
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func cancel(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }

}
