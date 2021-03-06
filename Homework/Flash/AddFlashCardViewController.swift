//
//  AddFlashCardViewController.swift
//  Homework
//
//  Created by Javier Quintero on 8/2/19.
//  Copyright © 2019 Javier Quintero. All rights reserved.
//

import UIKit

class AddFlashCardViewController: UIViewController {
    
    var persistantData: PersistantData?
    var deck: FlashDeck?
    var question = UITextView()
    var answer = UITextView()
    let scrollView = UIScrollView()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel(_:)))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(save(_:)))
        
        self.navigationItem.title = "New Flash Card"
        
        setUp()
    }
    
    func setUp() {
        self.view.addSubview(scrollView)
        self.view.addSubview(scrollView)
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard(_:)))
        scrollView.addGestureRecognizer(tap)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        let questionLabel = UILabel()
        scrollView.addSubview(questionLabel)
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        questionLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10).isActive = true
        questionLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        questionLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15).isActive = true
        questionLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15).isActive = true
        questionLabel.text = "Question"
        
        scrollView.addSubview(question)
        question.clipsToBounds = true
        question.layer.cornerRadius = 7
        question.translatesAutoresizingMaskIntoConstraints = false
        question.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15).isActive = true
        question.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15).isActive = true
        question.topAnchor.constraint(equalTo: questionLabel.bottomAnchor).isActive = true
        question.heightAnchor.constraint(equalToConstant: 150).isActive = true
        question.layer.borderWidth = 0.3
        question.font = UIFont(name: "HelveticaNeue", size: 15)
        
        let answerLabel = UILabel()
        scrollView.addSubview(answerLabel)
        answerLabel.translatesAutoresizingMaskIntoConstraints = false
        answerLabel.topAnchor.constraint(equalTo: question.bottomAnchor, constant: 10).isActive = true
        answerLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        answerLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15).isActive = true
        answerLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15).isActive = true
        answerLabel.text = "Answer"
        
        scrollView.addSubview(answer)
        answer.clipsToBounds = true
        answer.layer.cornerRadius = 7
        answer.translatesAutoresizingMaskIntoConstraints = false
        answer.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15).isActive = true
        answer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15).isActive = true
        answer.topAnchor.constraint(equalTo: answerLabel.bottomAnchor).isActive = true
        answer.heightAnchor.constraint(equalToConstant: 150).isActive = true
        answer.layer.borderWidth = 0.3
        answer.font = UIFont(name: "HelveticaNeue", size: 15)
        
        let bottomView = UIView()
        scrollView.addSubview(bottomView)
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        bottomView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        bottomView.topAnchor.constraint(equalTo: answer.bottomAnchor, constant: 10).isActive = true
        bottomView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        bottomView.heightAnchor.constraint(equalToConstant: 500).isActive = true
    }
    
    
    @objc func cancel(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func save(_ sender: UIBarButtonItem) {
        let context = persistantData!.context
        let card = FlashCard(context: context)
        card.answer = answer.text
        card.question = question.text
        card.deck = deck
        persistantData!.appDelegate.saveContext()
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func hideKeyboard(_ sender: UITapGestureRecognizer) {
        scrollView.endEditing(true)
    }
}
