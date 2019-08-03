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
    
    func setUp() {
        self.addSubview(question)
        question.translatesAutoresizingMaskIntoConstraints = false
        question.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        question.heightAnchor.constraint(greaterThanOrEqualToConstant: 25).isActive = true
        question.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        question.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        question.numberOfLines = 0
        question.text = "Why did the chicken cross the road?"
        question.textAlignment = .center
        
        let reveal = UIButton()
        self.addSubview(reveal)
        reveal.translatesAutoresizingMaskIntoConstraints = false
        reveal.topAnchor.constraint(equalTo: question.bottomAnchor, constant: 10).isActive = true
        reveal.heightAnchor.constraint(equalToConstant: 30).isActive = true
        reveal.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        reveal.widthAnchor.constraint(greaterThanOrEqualToConstant: 30).isActive = true
        reveal.setTitle("Show Answer", for: .normal)
        reveal.setTitleColor(.blue, for: .normal)
    }

}
