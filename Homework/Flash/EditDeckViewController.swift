//
//  EditDeckViewController.swift
//  Homework
//
//  Created by Javier Quintero on 8/3/19.
//  Copyright © 2019 Javier Quintero. All rights reserved.
//

import UIKit

class EditDeckViewController: UIViewController {

    var persistantData: PersistantData?
    var deck: FlashDeck?
    let name = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveData(_:)))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel(_:)))
        self.navigationItem.title = "Edit Flash Deck"
        
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
        name.text = deck?.name
        
        let deleteButton = UIButton()
        self.view.addSubview(deleteButton)
        deleteButton.setTitle("Delete", for: .normal)
        deleteButton.setTitleColor(UIColor.red, for: .normal)
        //        deleteButton.layer.cornerRadius = 8
        
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        deleteButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
        deleteButton.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 30).isActive = true
        deleteButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        deleteButton.addTarget(self, action: #selector(self.deleteDeck(_:)), for: .touchUpInside)
        
    }
    
    
    @objc func saveData(_ sender:UIBarButtonItem) {
        if let flashDeck = deck {
            flashDeck.name = name.text
            persistantData!.appDelegate.saveContext()
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @objc func cancel(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func deleteDeck(_ sender:UIButton!){
        
        let defaultAction = UIAlertAction(title: "Delete",
                                          style: .destructive) { (action) in
            self.persistantData!.context.delete(self.deck!)
            do{
                try self.persistantData!.context.save()
                let vcs = self.navigationController?.viewControllers
                let vc = vcs![vcs!.count-3]
                self.navigationController?.popToViewController(vc, animated: true)
            } catch {
                print("Failed to save")
            }
                            
        }
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel) { (action) in
        }
        
        let alert = UIAlertController(title: "Are you sure?",
                                      message: "Deleting this flash card deck will also delete all of its flash cards.",
                                      preferredStyle: .alert)
        alert.addAction(defaultAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true) {
            
        }
    }
}
