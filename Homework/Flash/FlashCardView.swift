//
//  FlashCardView.swift
//  Homework
//
//  Created by Javier Quintero on 8/2/19.
//  Copyright © 2019 Javier Quintero. All rights reserved.
//

import UIKit

class FlashCardView: UIView {

    var question = UILabel()
    var answer = UILabel()
    let reveal = UIButton()
    var card: FlashCard?
    var hasData = false
    
    func setUp() {
        self.addSubview(question)
        question.translatesAutoresizingMaskIntoConstraints = false
        question.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        question.heightAnchor.constraint(greaterThanOrEqualToConstant: 25).isActive = true
        question.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        question.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        question.numberOfLines = 0
        question.textAlignment = .center
        
        
        self.addSubview(reveal)
        reveal.translatesAutoresizingMaskIntoConstraints = false
        reveal.topAnchor.constraint(equalTo: question.bottomAnchor, constant: 10).isActive = true
        reveal.heightAnchor.constraint(equalToConstant: 30).isActive = true
        reveal.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        reveal.widthAnchor.constraint(greaterThanOrEqualToConstant: 30).isActive = true
        reveal.setTitle("Show Answer", for: .normal)
        reveal.setTitleColor(.blue, for: .normal)
        reveal.isHidden = true
        reveal.addTarget(self, action: #selector(toggleAnswer(_:)), for: .touchUpInside)
        
        self.addSubview(answer)
        answer.translatesAutoresizingMaskIntoConstraints = false
        answer.topAnchor.constraint(equalTo: reveal.bottomAnchor, constant: 25).isActive = true
        answer.heightAnchor.constraint(greaterThanOrEqualToConstant: 25).isActive = true
        answer.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        answer.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        answer.textAlignment = .center
        answer.numberOfLines = 0
        answer.isHidden = true
        
        refresh()
    }
    
    func refresh() {
        if let card = card {
            question.text = card.question
            reveal.isHidden = false
            reveal.setTitle("Show Answer", for: .normal)
            answer.text = card.answer
            answer.isHidden = true
        }
        else {
            question.text = "Add a new flash card by tapping the top right menu"
        }
    }
    
    @objc func toggleAnswer(_ sender: UIButton) {
        if answer.isHidden {
            answer.isHidden = false
            reveal.setTitle("Hide Answer", for: .normal)
        }
        else {
            answer.isHidden = true
            reveal.setTitle("Show Answer", for: .normal)
        }
        
    }

}
