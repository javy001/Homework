//
//  FlashDecksViewController.swift
//  Homework
//
//  Created by Javier Quintero on 8/2/19.
//  Copyright © 2019 Javier Quintero. All rights reserved.
//

import UIKit

class FlashDecksViewController: UITableViewController {
    
    var persistantData: PersistantData?
    var schoolClass: SchoolClass?
    var decks: [FlashDeck] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        if let flashDecks = schoolClass?.flashDeck {
            decks = flashDecks.allObjects as! [FlashDeck]
        }
        self.navigationItem.largeTitleDisplayMode = .never
        self.view.backgroundColor = .white
        self.navigationItem.title = "Flash Decks"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addDeck(_:)))
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellID")
//        tableView.separatorStyle = .none
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return decks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID")
        cell?.textLabel?.text = decks[indexPath.row].name
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = SingleDeckViewController()
        vc.persistantData = persistantData
        vc.deck = decks[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

    @objc func addDeck(_ sender: UIBarButtonItem) {
        let vc = AddFlashDeckViewController()
        vc.persistantData = persistantData
        vc.schoolClass = schoolClass
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
