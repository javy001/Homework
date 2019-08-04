//
//  FlashCardView.swift
//  Homework
//
//  Created by Javier Quintero on 8/2/19.
//  Copyright © 2019 Javier Quintero. All rights reserved.
//

import UIKit

protocol FlashCardDelegate: class {
    func addCard()
    func editCard()
}

class FlashCardView: UIView {
    
    weak var delegate: FlashCardDelegate?
    var textData = UILabel()
    let style = AppStyle()
    var answer = UILabel()
    let reveal = UIButton()
    var card: FlashCard?
    var hasData = false
    var isFront = true
    let scrollView = UIScrollView()
    var persistantData: PersistantData?
    
    func setUp() {
        self.layer.borderColor = UIColor(red: 209/255, green: 209/255, blue: 209/255, alpha: 1).cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 5
        
        let editButton = UIButton()
        self.addSubview(editButton)
        editButton.translatesAutoresizingMaskIntoConstraints = false
        editButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        editButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        editButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        editButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 30).isActive = true
        editButton.setTitle("Edit", for: .normal)
        editButton.setTitleColor(style.buttonTextColor, for: .normal)
        editButton.addTarget(self, action: #selector(editCard(_:)), for: .touchUpInside)
        
        self.addSubview(reveal)
        reveal.translatesAutoresizingMaskIntoConstraints = false
        reveal.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        reveal.heightAnchor.constraint(equalToConstant: 30).isActive = true
        reveal.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        reveal.widthAnchor.constraint(greaterThanOrEqualToConstant: 30).isActive = true
        reveal.setTitle("Show Answer", for: .normal)
        reveal.setTitleColor(style.buttonTextColor, for: .normal)
        reveal.isHidden = true
        reveal.addTarget(self, action: #selector(toggleAnswer(_:)), for: .touchUpInside)
        
        let addButton = UIButton()
        self.addSubview(addButton)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        addButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        addButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        addButton.setImage(UIImage(named: "add"), for: .normal)
        addButton.addTarget(self, action: #selector(addCard(_:)), for: .touchUpInside)
        
        self.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: editButton.bottomAnchor, constant: 5).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        scrollView.addSubview(textData)
        textData.translatesAutoresizingMaskIntoConstraints = false
        textData.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        textData.heightAnchor.constraint(greaterThanOrEqualToConstant: 25).isActive = true
        textData.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        textData.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        textData.numberOfLines = 0
        textData.textAlignment = .center
        
        
        

        let bottomView = UIView()
        scrollView.addSubview(bottomView)
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.topAnchor.constraint(equalTo: textData.bottomAnchor).isActive = true
        bottomView.heightAnchor.constraint(equalToConstant: 10).isActive = true
        bottomView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        bottomView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        bottomView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        
        refresh()
    }
    
    func refresh() {
        scrollView.setContentOffset(CGPoint(x: 0, y: -self.scrollView.contentInset.top), animated: false)
        if let card = card {
            textData.text = card.question
            reveal.isHidden = false
            reveal.setTitle("Show Answer", for: .normal)
        }
        else {
            textData.text = "Add a new flash card by tapping the plus button"
        }
    }
    
    @objc func toggleAnswer(_ sender: UIButton) {
        if isFront {
            textData.text = card?.answer
            reveal.setTitle("Show Question", for: .normal)
            isFront = false
        }
        else {
            textData.text = card?.question
            isFront = true
            reveal.setTitle("Show Answer", for: .normal)
        }
        
    }
    
    @objc func addCard(_ sender: UIButton) {
        delegate?.addCard()
    }
    
    @objc func editCard(_ sender: UIButton) {
        delegate?.editCard()
    }

}
