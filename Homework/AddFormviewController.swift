//
//  AddFormviewController.swift
//  Homework
//
//  Created by Javier Quintero on 5/18/19.
//  Copyright © 2019 Javier Quintero. All rights reserved.
//

import UIKit

class AddFormviewController: UIViewController, SavedButtonDelegate {
    
    var pageTitle : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        navigationItem.title = pageTitle
        
        let addClass = AddClassView()
        setUp(subView: addClass)

        
    }
    
    private func setUp(subView: AddClassView){
        self.view.addSubview(subView)
        subView.savedButtonDelegate = self 
        subView.translatesAutoresizingMaskIntoConstraints = false
        subView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        subView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        subView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100).isActive = true
        subView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -100).isActive = true
    }
    
    func didTapSaveButton(name: String) {
        print(name)
        navigationController?.popViewController(animated: false)
    }

}
