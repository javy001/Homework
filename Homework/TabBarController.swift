//
//  ViewController.swift
//  Homework
//
//  Created by Javier Quintero on 5/10/19.
//  Copyright © 2019 Javier Quintero. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let persistantData = PersistantData()
        
        let pendingViewController = PendingViewController()
        pendingViewController.persistantData = persistantData
        let pendingNavigationController = UINavigationController(rootViewController: pendingViewController)
        
        pendingViewController.tabBarItem.image = UIImage(named: "list")
        pendingViewController.tabBarItem.title = "Pending"
        pendingViewController.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 2)
        
        
        let schoolClassTableViewController = ViewClassTableViewController()
        schoolClassTableViewController.persistantData = persistantData
        let schooClassNavigationController = UINavigationController(rootViewController: schoolClassTableViewController)
        schooClassNavigationController.tabBarItem.image = UIImage(named: "class")
        schooClassNavigationController.tabBarItem.title = "Classes"
        schooClassNavigationController.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 2)
        
        
        viewControllers = [pendingNavigationController, schooClassNavigationController]
        
        for controller in viewControllers! {
            controller.tabBarItem.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }


}

