//
//  EditFlashCardViewController.swift
//  Homework
//
//  Created by Javier Quintero on 8/3/19.
//  Copyright © 2019 Javier Quintero. All rights reserved.
//

import UIKit

class EditFlashCardViewController: UIViewController {
    
    var persistantData: PersistantData?
    var card: FlashCard?
    let scrollView = UIScrollView()
    var question = UITextView()
    var answer = UITextView()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        self.navigationItem.title = "Edit Flash Card"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(save(_:)))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel(_:)))
        
        setUp()
    }
    
    func setUp() {
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
        question.text = card?.question
        
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
        answer.text = card?.answer
        
        let deleteButton = UIButton()
        self.view.addSubview(deleteButton)
        deleteButton.setTitle("Delete", for: .normal)
        deleteButton.setTitleColor(UIColor.red, for: .normal)
        //        deleteButton.layer.cornerRadius = 8
        
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        deleteButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
        deleteButton.topAnchor.constraint(equalTo: answer.bottomAnchor, constant: 30).isActive = true
        deleteButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        deleteButton.addTarget(self, action: #selector(self.deleteCard(_:)), for: .touchUpInside)
        
        let bottomView = UIView()
        scrollView.addSubview(bottomView)
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        bottomView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        bottomView.topAnchor.constraint(equalTo: deleteButton.bottomAnchor, constant: 10).isActive = true
        bottomView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        bottomView.heightAnchor.constraint(equalToConstant: 500).isActive = true
    }
    
    
    @objc func cancel(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func save(_ sender: UIBarButtonItem) {
        self.card?.answer = answer.text
        self.card?.question = question.text
        persistantData!.appDelegate.saveContext()
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func deleteCard(_ sender: UIBarButtonItem) {
        let defaultAction = UIAlertAction(title: "Delete",
                                          style: .destructive) { (action) in
            self.persistantData!.context.delete(self.card!)
            do{
                try self.persistantData!.context.save()
                self.navigationController?.popViewController(animated: true)
            } catch {
                print("Failed to save")
            }
                                            
        }
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel) { (action) in
        }
        
        let alert = UIAlertController(title: "Are you sure?",
                                      message: nil,
                                      preferredStyle: .alert)
        alert.addAction(defaultAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true) {
            
        }
    }
    
    @objc func hideKeyboard(_ sender: UITapGestureRecognizer) {
        scrollView.endEditing(true)
    }
}
