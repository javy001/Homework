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
    var cards: [FlashCard] = []
    var currentCard = 0
    let style = AppStyle()
    let card = FlashCardView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.navigationItem.title = deck?.name
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "menu"), style: .plain, target: self, action: #selector(openMenu(_:)))
        
        setUp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = deck?.name
        if let flashCards = deck?.flashCard {
            cards = flashCards.allObjects as! [FlashCard]
            if currentCard < cards.count {
                card.card = cards[currentCard]
            }
            card.refresh()
        }
    }
    
    func setUp() {
        if let flashCards = deck?.flashCard {
            cards = flashCards.allObjects as! [FlashCard]
        }
        
        let shuffleButton = UIButton()
        self.view.addSubview(shuffleButton)
        shuffleButton.translatesAutoresizingMaskIntoConstraints = false
        shuffleButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        shuffleButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 50).isActive = true
        shuffleButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        shuffleButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        shuffleButton.setTitle("Shuffle", for: .normal)
        shuffleButton.setTitleColor(style.buttonTextColor, for: .normal)
        shuffleButton.addTarget(self, action: #selector(shuffleCards(_:)), for: .touchUpInside)
        
        let nextButton = UIButton()
        self.view.addSubview(nextButton)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        nextButton.widthAnchor.constraint(equalToConstant: 55).isActive = true
        nextButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        nextButton.setTitle("Next", for: .normal)
        nextButton.setTitleColor(style.buttonTextColor, for: .normal)
        nextButton.addTarget(self, action: #selector(nextCard(_:)), for: .touchUpInside)
        
        let previous = UIButton()
        self.view.addSubview(previous)
        previous.translatesAutoresizingMaskIntoConstraints = false
        previous.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        previous.widthAnchor.constraint(equalToConstant: 100).isActive = true
        previous.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        previous.heightAnchor.constraint(equalToConstant: 30).isActive = true
        previous.setTitle("Previous", for: .normal)
        previous.setTitleColor(style.buttonTextColor, for: .normal)
        previous.addTarget(self, action: #selector(previousCard(_:)), for: .touchUpInside)
        
        if cards.count > 0 {
            card.card = cards[0]
        }
        self.view.addSubview(card)
        card.clipsToBounds = true
        card.translatesAutoresizingMaskIntoConstraints = false
        card.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        card.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15).isActive = true
        card.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15).isActive = true
        card.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -10).isActive = true
        card.setUp()
        
    }
    
    @objc func addCard(_ sender: UIBarButtonItem) {
        let vc = AddFlashCardViewController()
        vc.persistantData = persistantData
        vc.deck = deck
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func openMenu(_ sender:UIBarButtonItem){
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let addCardAction = UIAlertAction(title: "Add Flash Card", style: .default) { (action) in
            let vc = AddFlashCardViewController()
            vc.persistantData = self.persistantData
            vc.deck = self.deck
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        let editCardAction = UIAlertAction(title: "Edit Flash Card", style: .default) { (action) in
            let vc = EditFlashCardViewController()
            vc.persistantData = self.persistantData
            vc.card = self.cards[self.currentCard]
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        let editDeckAction = UIAlertAction(title: "Edit Flash Deck", style: .default) { (action) in
            let vc = EditDeckViewController()
            vc.persistantData = self.persistantData
            vc.deck = self.deck
            
            self.navigationController?.pushViewController(vc, animated: true)
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
        }
        for action in [addCardAction, editCardAction, editDeckAction, cancelAction] {
            alert.addAction(action)
        }
        present(alert, animated: true)
    }
    
    @objc func nextCard(_ sender: UIButton) {
        if cards.count > 0 {
            let max = cards.count - 1
            var nextCard = 0
            if currentCard != max {
                nextCard = currentCard + 1
            }
            currentCard = nextCard
            card.card = cards[currentCard]
            card.refresh()
        }
    }
    
    @objc func previousCard(_ sender: UIButton) {
        if cards.count > 0 {
            let max = cards.count - 1
            var nextCard = max
            if currentCard != 0 {
                nextCard = currentCard - 1
            }
            currentCard = nextCard
            card.card = cards[currentCard]
            card.refresh()
        } 
    }
    
    @objc func shuffleCards(_ sender: UIButton) {
        cards.shuffle()
        if cards.count > 0 {
            let max = cards.count - 1
            var nextCard = max
            if currentCard != 0 {
                nextCard = currentCard - 1
            }
            currentCard = nextCard
            card.card = cards[currentCard]
            card.refresh()
        }
    }

}
