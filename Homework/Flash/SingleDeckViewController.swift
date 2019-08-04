//
//  SingleDeckViewController.swift
//  Homework
//
//  Created by Javier Quintero on 8/2/19.
//  Copyright © 2019 Javier Quintero. All rights reserved.
//

import UIKit

class SingleDeckViewController: UIViewController, FlashCardDelegate {
    
    
    var persistantData: PersistantData?
    var deck: FlashDeck?
    var cards: [FlashCard] = []
    var currentCard = 0
    let style = AppStyle()
    let card = FlashCardView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        card.delegate = self
        self.view.backgroundColor = .white
        self.navigationItem.title = deck?.name
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editDeck(_:)))
        
        setUp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = deck?.name
        if let flashCards = deck?.flashCard {
            cards = flashCards.allObjects as! [FlashCard]
            if currentCard < cards.count {
                card.card = cards[currentCard]
            }
            else if cards.count > 0 {
                currentCard = 0
                card.card = cards[currentCard]
            }
            else {
                card.card = nil
            }
            card.refresh()
        }
    }
    
    func setUp() {
        if let flashCards = deck?.flashCard {
            cards = flashCards.allObjects as! [FlashCard]
        }
        
        if cards.count > 0 {
            card.card = cards[0]
        }
        self.view.addSubview(card)
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(previousCard(_:)))
        swipeRight.direction = .right
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(nextCard(_:)))
        swipeLeft.direction = .left
        card.addGestureRecognizer(swipeRight)
        card.addGestureRecognizer(swipeLeft)
        card.clipsToBounds = true
        card.translatesAutoresizingMaskIntoConstraints = false
        card.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        card.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15).isActive = true
        card.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15).isActive = true
        card.bottomAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 40).isActive = true
        card.setUp()
        
        let shuffleButton = UIButton()
        self.view.addSubview(shuffleButton)
        shuffleButton.translatesAutoresizingMaskIntoConstraints = false
        shuffleButton.topAnchor.constraint(equalTo: card.bottomAnchor, constant: 10).isActive = true
        shuffleButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 50).isActive = true
        shuffleButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        shuffleButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        shuffleButton.setTitle("Shuffle", for: .normal)
        shuffleButton.setTitleColor(style.buttonTextColor, for: .normal)
        shuffleButton.addTarget(self, action: #selector(shuffleCards(_:)), for: .touchUpInside)
        
        let nextButton = UIButton()
        self.view.addSubview(nextButton)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.topAnchor.constraint(equalTo: card.bottomAnchor, constant: 10).isActive = true
        nextButton.widthAnchor.constraint(equalToConstant: 55).isActive = true
        nextButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        nextButton.setImage(UIImage(named: "right_arrow"), for: .normal)
        nextButton.setTitleColor(style.buttonTextColor, for: .normal)
        nextButton.addTarget(self, action: #selector(nextCard(_:)), for: .touchUpInside)
        
        let previous = UIButton()
        self.view.addSubview(previous)
        previous.translatesAutoresizingMaskIntoConstraints = false
        previous.topAnchor.constraint(equalTo: card.bottomAnchor, constant: 10).isActive = true
        previous.widthAnchor.constraint(equalToConstant: 55).isActive = true
        previous.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        previous.heightAnchor.constraint(equalToConstant: 30).isActive = true
        previous.setImage(UIImage(named: "left_arrow"), for: .normal)
        previous.setTitleColor(style.buttonTextColor, for: .normal)
        previous.addTarget(self, action: #selector(previousCard(_:)), for: .touchUpInside)
        
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
    
    @objc func editDeck(_ sender: UIBarButtonItem) {
        let vc = EditDeckViewController()
        vc.persistantData = self.persistantData
        vc.deck = self.deck
        self.navigationController?.pushViewController(vc, animated: true)
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
    
    func addCard() {
        let vc = AddFlashCardViewController()
        vc.persistantData = self.persistantData
        vc.deck = self.deck
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func editCard() {
        if cards.count > 0 {
            let vc = EditFlashCardViewController()
            vc.persistantData = self.persistantData
            vc.card = self.cards[self.currentCard]
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

}
