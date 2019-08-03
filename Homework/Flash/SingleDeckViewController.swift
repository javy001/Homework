//
//  SingleDeckViewController.swift
//  Homework
//
//  Created by Javier Quintero on 8/2/19.
//  Copyright © 2019 Javier Quintero. All rights reserved.
//

import UIKit

class SingleDeckViewController: UIViewController {
    
    var persistantData: PersistantData?
    var deck: FlashDeck?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.navigationItem.title = deck?.name
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addCard(_:)))
        
        setUp()
    }
    
    func setUp() {
        let card = FlashCardView()
        self.view.addSubview(card)
        card.translatesAutoresizingMaskIntoConstraints = false
        card.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        card.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15).isActive = true
        card.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 15).isActive = true
        card.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        card.setUp()
    }
    
    @objc func addCard(_ sender: UIBarButtonItem) {
        let vc = AddFlashCardViewController()
        vc.persistantData = persistantData
        vc.deck = deck
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
